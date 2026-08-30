import 'dart:developer' as developer;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/auth/data/repositories/auth_repository.dart';
import 'package:slipwise/router/router.dart';
import 'package:slipwise/modules/notifications/providers/notification_controller.dart';
import 'package:slipwise/firebase_options.dart';
import 'package:slipwise/core/storage/secure_storage.dart';

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

  PushNotificationService(this._ref);

  Future<void> initialize() async {
    try {
      // Set the background messaging handler early on, as a logic basis
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      // 2. Request permission (iOS specifically, Android 13+)
      final messaging = FirebaseMessaging.instance;
      final settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        // 3. Get the token and register device
        final token = await messaging.getToken();
        if (token != null) {
          _registerDevice(token);
        }

        // Listen for token refreshes
        messaging.onTokenRefresh.listen((newToken) {
          _registerDevice(newToken);
        });

        // 4. Setup message handlers for deep linking
        _setupMessageHandlers();
      }
    } catch (e) {
      developer.log(
        'Failed to initialize push notifications: $e',
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
        'Received foreground message: ${message.messageId}',
        name: 'PushNotification',
      );

      final ticketId = message.data['ticket_id'] as String?;
      final type = message.data['type'] as String? ?? 'ticket_update';

      _ref
          .read(notificationControllerProvider.notifier)
          .addNotification(
            title: message.notification?.title ?? 'Update',
            body: message.notification?.body ?? 'You have a new alert',
            ticketId: ticketId,
            type: type,
          );

      // Here you could show a local notification if needed.
    });

    // B. Handle notification taps when the app is in the background (but running)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    // C. Handle notification tap when the app is launched from a terminated state
    FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message,
    ) {
      if (message != null) {
        _handleMessage(message);
      }
    });
  }

  void _handleMessage(RemoteMessage message) {
    developer.log(
      'Opened app from notification: ${message.data}',
      name: 'PushNotification',
    );

    final data = message.data;
    final type = data['type'];
    final ticketId = data['ticket_id'];

    if (type == 'ticket_update' && ticketId != null) {
      // Use the global navigator key to push the deep link
      final context = navigatorKey.currentContext;
      if (context != null) {
        // Redirect to our loader screen which handles ticket ID fetching
        context.push('/ticket-details?id=$ticketId');
      }
    }
  }
}
