import 'dart:developer' as developer;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/modules/auth/data/repositories/auth_repository.dart';
import 'package:slipwise/router/router.dart';
import 'package:slipwise/modules/notifications/providers/notification_controller.dart';
import 'package:slipwise/firebase_options.dart';
import 'package:slipwise/core/storage/secure_storage.dart';
import 'package:slipwise/core/utils/toast_utils.dart';

part 'push_notification_service.g.dart';

@Riverpod(keepAlive: true)
PushNotificationService pushNotificationService(Ref ref) {
  return PushNotificationService(ref);
}

// Global background handler for messages received while the app is terminated or in the background.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    developer.log(
      'Handling a background message: ${message.messageId}',
      name: 'PushNotification',
    );
  } catch (e) {
    developer.log('Error in background handler: $e', name: 'PushNotification');
  }
}

class PushNotificationService {
  final Ref _ref;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  PushNotificationService(this._ref);

  String? pendingTicketId;

  Future<void> initialize() async {
    try {
      // 1. Set the background messaging handler early
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      // 2. Initialize local notifications for foreground heads-up alerts
      await _initLocalNotifications();

      // 3. Setup message handlers immediately for deep linking
      _setupMessageHandlers();

      // 4. Request permissions (iOS specifically, Android 13+)
      final messaging = FirebaseMessaging.instance;
      final settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        // 5. Get the token and register device
        final token = await messaging.getToken();
        if (token != null) {
          _registerDevice(token);
        }

        // Listen for token refreshes
        messaging.onTokenRefresh.listen((newToken) {
          _registerDevice(newToken);
        });
      }
    } catch (e, stack) {
      developer.log(
        'Failed to initialize push notifications: $e\n$stack',
        name: 'PushNotification',
      );
    }
  }

  Future<void> _initLocalNotifications() async {
    try {
      const androidSettings = AndroidInitializationSettings(
        '@mipmap/launcher_icon',
      );
      const darwinSettings = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );

      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: darwinSettings,
      );

      await _localNotifications.initialize(
        settings: initSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          final payload = response.payload;
          if (payload != null && payload.isNotEmpty) {
            _navigateToTicket(payload);
          }
        },
      );

      // Create high-importance channel on Android
      final androidPlugin = _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      if (androidPlugin != null) {
        await androidPlugin.createNotificationChannel(
          const AndroidNotificationChannel(
            'slipwise_alerts',
            'SlipWise Alerts',
            description: 'Match updates and ticket notifications',
            importance: Importance.max,
          ),
        );
      }

      // Check if launched by tapping a local notification from terminated state
      final launchDetails = await _localNotifications
          .getNotificationAppLaunchDetails();
      if (launchDetails?.didNotificationLaunchApp ?? false) {
        final payload = launchDetails?.notificationResponse?.payload;
        if (payload != null && payload.isNotEmpty) {
          _navigateToTicket(payload);
        }
      }
    } catch (e, stack) {
      developer.log(
        'Failed to initialize local notifications: $e\n$stack',
        name: 'PushNotification',
      );
    }
  }

  Future<void> registerCurrentToken() async {
    try {
      final messaging = FirebaseMessaging.instance;
      final token = await messaging.getToken();
      if (token != null) {
        _registerDevice(token);
      }
    } catch (e) {
      developer.log(
        'Failed to fetch token for registration: $e',
        name: 'PushNotification',
      );
    }
  }

  void _registerDevice(String token) async {
    try {
      final storage = _ref.read(secureStorageProvider);
      final accessToken = await storage.getAccessToken();
      if (accessToken == null) {
        developer.log(
          'User not logged in, skipping FCM token registration.',
          name: 'PushNotification',
        );
        return;
      }

      final cachedToken = await storage.getFCMToken();
      if (cachedToken == token) {
        developer.log(
          'FCM Token unchanged, skipping backend registration.',
          name: 'PushNotification',
        );
        return;
      }

      developer.log('FCM Token: $token', name: 'PushNotification');
      final authRepo = _ref.read(authRepositoryProvider);

      // This endpoint is protected, so this will automatically upsert the device
      // using the currently logged-in user's Bearer token.
      await authRepo.registerDevice(token);

      // Save the token locally so we don't spam the backend on next startup
      await storage.saveFCMToken(token);
    } catch (e) {
      developer.log('Failed to register device: $e', name: 'PushNotification');
    }
  }

  void _setupMessageHandlers() {
    // A. Handle messages while the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      developer.log(
        'Received foreground message: ${message.messageId}, data: ${message.data}',
        name: 'PushNotification',
      );

      final ticketId =
          (message.data['ticket_id'] ??
                  message.data['ticketId'] ??
                  message.data['id'])
              ?.toString();
      final type = message.data['type'] as String? ?? 'ticket_update';

      final title = message.notification?.title ?? 'Match Update';
      final body = message.notification?.body ?? 'You have a new ticket alert';

      // 1. Add to in-app notification inbox
      _ref
          .read(notificationControllerProvider.notifier)
          .addNotification(
            title: title,
            body: body,
            ticketId: ticketId,
            type: type,
          );

      // 2. Show native heads-up notification in system tray
      _showLocalNotification(
        id: message.hashCode,
        title: title,
        body: body,
        payload: ticketId,
      );

      // 3. Show in-app interactive toast banner
      _showInAppToast(title: title, body: body, ticketId: ticketId);
    });

    // B. Handle notification taps when the app is in the background (but running)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      developer.log(
        'onMessageOpenedApp triggered: ${message.data}',
        name: 'PushNotification',
      );
      _handleMessage(message);
    });

    // C. Handle notification tap when the app is launched from a terminated state
    FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message,
    ) {
      if (message != null) {
        developer.log(
          'getInitialMessage found: ${message.data}',
          name: 'PushNotification',
        );
        _handleMessage(message);
      }
    });
  }

  void _showLocalNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'slipwise_alerts',
        'SlipWise Alerts',
        channelDescription: 'Match updates and ticket notifications',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
      );
      const platformDetails = NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );

      await _localNotifications.show(
        id: id,
        title: title,
        body: body,
        notificationDetails: platformDetails,
        payload: payload,
      );
    } catch (e) {
      developer.log(
        'Failed to show local notification: $e',
        name: 'PushNotification',
      );
    }
  }

  void _showInAppToast({
    required String title,
    required String body,
    String? ticketId,
  }) {
    try {
      final context = navigatorKey.currentContext;
      if (context == null) return;

      Widget? action;
      if (ticketId != null && ticketId.isNotEmpty) {
        action = ShadButton.outline(
          size: ShadButtonSize.sm,
          onPressed: () {
            _navigateToTicket(ticketId);
          },
          child: const Text('View'),
        );
      }

      AppToast.show(
        context,
        title: title,
        description: body,
        action: action,
        duration: const Duration(milliseconds: 3500),
      );
    } catch (e) {
      developer.log(
        'Failed to show in-app toast: $e',
        name: 'PushNotification',
      );
    }
  }

  void _handleMessage(RemoteMessage message) {
    developer.log(
      'Opened app from notification: ${message.data}',
      name: 'PushNotification',
    );

    final data = message.data;
    final ticketId = (data['ticket_id'] ?? data['ticketId'] ?? data['id'])
        ?.toString();

    if (ticketId != null && ticketId.isNotEmpty) {
      _navigateToTicket(ticketId);
    }
  }

  void _navigateToTicket(String ticketId) {
    if (ticketId.isEmpty) return;

    try {
      final router = _ref.read(routerProvider);

      String? currentPath;
      try {
        currentPath = router.routerDelegate.currentConfiguration.uri.path;
      } catch (_) {}

      developer.log(
        'Routing to ticket: $ticketId (currentPath: $currentPath)',
        name: 'PushNotification',
      );

      if (currentPath == null ||
          currentPath.isEmpty ||
          currentPath == '/splash') {
        pendingTicketId = ticketId;
      } else {
        router.push('/ticket-details?id=$ticketId');
      }
    } catch (e, stack) {
      developer.log(
        'Error navigating to ticket: $e\n$stack',
        name: 'PushNotification',
      );
      pendingTicketId = ticketId;
    }
  }
}
