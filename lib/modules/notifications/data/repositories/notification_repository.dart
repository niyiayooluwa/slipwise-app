import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slipwise/modules/notifications/data/models/app_notification.dart';

part 'notification_repository.g.dart';

@riverpod
class NotificationRepository extends _$NotificationRepository {
  static const _key = 'app_notifications';

  @override
  FutureOr<SharedPreferences> build() async {
    return SharedPreferences.getInstance();
  }

  Future<List<AppNotification>> getNotifications() async {
    final prefs = await future;
    final jsonList = prefs.getStringList(_key) ?? [];
    return jsonList
        .map((jsonStr) => AppNotification.fromJson(jsonDecode(jsonStr)))
        .toList();
  }

  Future<void> saveNotifications(List<AppNotification> notifications) async {
    final prefs = await future;
    final jsonList = notifications.map((n) => jsonEncode(n.toJson())).toList();
    await prefs.setStringList(_key, jsonList);
  }

  Future<void> clearNotifications() async {
    final prefs = await future;
    await prefs.remove(_key);
  }
}
