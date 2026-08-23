import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/core/ui/empty_state_widget.dart';
import 'package:slipwise/core/ui/gradient_sliver_app_bar.dart';
import 'package:slipwise/modules/notifications/data/models/app_notification.dart';
import 'package:slipwise/modules/notifications/providers/notification_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationsScreen extends HookConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;
    final notificationsAsync = ref.watch(notificationControllerProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: CustomScrollView(
        slivers: [
          GradientSliverAppBar(
            title: 'Inbox',
            
            actions: [
              IconButton(
                icon: Icon(
                  LucideIcons.checkCheck,
                  color: colorScheme.primaryForeground,
                ),
                onPressed: () {
                  ref
                      .read(notificationControllerProvider.notifier)
                      .markAllAsRead();
                },
                tooltip: 'Mark all as read',
              ),
            ],
          ),
          notificationsAsync.when(
            data: (notifications) {
              if (notifications.isEmpty) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: EmptyStateWidget(
                    title: 'No new notifications',
                    message: 'You are all caught up!',
                    
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final notif = notifications[index];
                    return _NotificationTile(notif: notif);
                  },
                  childCount: notifications.length,
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            error: (err, stack) => SliverFillRemaining(
              child: Center(
                child: Text(
                  'Failed to load notifications: $err',
                  style: TextStyle(color: colorScheme.destructive),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationTile extends ConsumerWidget {
  final AppNotification notif;

  const _NotificationTile({required this.notif});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final isDark = true;

    return InkWell(
      onTap: () {
        ref.read(notificationControllerProvider.notifier).markAsRead(notif.id);
        if (notif.ticketId != null) {
          context.push('/ticket-details?id=${notif.ticketId}');
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: notif.isRead
              ? Colors.transparent
              : theme.colorScheme.primary.withValues(alpha: 0.1),
          border: Border(
            bottom: BorderSide(color: theme.colorScheme.border),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xff1A1A1A) : Colors.grey.shade100,
                shape: BoxShape.circle,
                border: Border.all(color: theme.colorScheme.border),
              ),
              child: Icon(
                notif.type == 'ticket_update'
                    ? LucideIcons.ticket
                    : LucideIcons.bell,
                color: theme.colorScheme.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          notif.title ?? 'Alert',
                          style: theme.textTheme.large.copyWith(
                            fontWeight: notif.isRead
                                ? FontWeight.normal
                                : FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        timeago.format(notif.createdAt),
                        style: theme.textTheme.small.copyWith(
                          color: theme.colorScheme.mutedForeground,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notif.body ?? '',
                    style: theme.textTheme.p.copyWith(
                      color: notif.isRead
                          ? theme.colorScheme.mutedForeground
                          : theme.colorScheme.foreground,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (!notif.isRead) ...[
              const SizedBox(width: 12),
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
