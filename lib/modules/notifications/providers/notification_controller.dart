import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/notifications/data/models/app_notification.dart';
import 'package:slipwise/modules/notifications/data/repositories/notification_repository.dart';
import 'package:uuid/uuid.dart';

part 'notification_controller.g.dart';

@Riverpod(keepAlive: true)
class NotificationController extends _$NotificationController {
  @override
  FutureOr<List<AppNotification>> build() async {
    return _fetchNotifications();
  }

  Future<List<AppNotification>> _fetchNotifications() async {
    return ref.read(notificationRepositoryProvider.notifier).getNotifications();
  }

  Future<void> addNotification({
    String? title,
    String? body,
    String? ticketId,
    String type = 'ticket_update',
  }) async {
    final newNotif = AppNotification(
      id: const Uuid().v4(),
      title: title,
      body: body,
      ticketId: ticketId,
      type: type,
      createdAt: DateTime.now().toUtc(),
      isRead: false,
    );

    final current = state.value ?? [];
    // Insert at top
    final updated = [newNotif, ...current];
    state = AsyncData(updated);

    await ref.read(notificationRepositoryProvider.notifier).saveNotifications(updated);
  }

  Future<void> markAsRead(String id) async {
    final current = state.value ?? [];
    final updated = current.map((n) {
      if (n.id == id) {
        return n.copyWith(isRead: true);
      }
      return n;
    }).toList();

    state = AsyncData(updated);
    await ref.read(notificationRepositoryProvider.notifier).saveNotifications(updated);
  }

  Future<void> markAllAsRead() async {
    final current = state.value ?? [];
    final updated = current.map((n) => n.copyWith(isRead: true)).toList();

    state = AsyncData(updated);
    await ref.read(notificationRepositoryProvider.notifier).saveNotifications(updated);
  }
}
