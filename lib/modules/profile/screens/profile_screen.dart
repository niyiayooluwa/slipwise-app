import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/core/providers/user_notifier.dart';
import 'package:slipwise/core/ui/gradient_sliver_app_bar.dart';
import 'package:slipwise/modules/profile/providers/user_stats_provider.dart';
import 'package:slipwise/modules/profile/screens/widgets/feedback_modal.dart';
import 'package:slipwise/modules/profile/screens/widgets/personal_info_modal.dart';
import 'package:slipwise/modules/profile/screens/widgets/security_modal.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;

    final userAsync = ref.watch(userProvider);
    final user = userAsync.value;

    final username = user?.username ?? 'Guest';
    final email = user?.email ?? '';
    final profileUrl = 'https://api.dicebear.com/10.x/blobs/svg?seed=$username';

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: CustomScrollView(
        slivers: [
          const GradientSliverAppBar(title: 'Profile'),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  // Profile Header Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: colorScheme.card,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: colorScheme.border),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: colorScheme.primary.withValues(alpha: 0.5),
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: SvgPicture.network(
                              profileUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                username,
                                style: theme.textTheme.h4.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.foreground,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                email,
                                style: theme.textTheme.small.copyWith(
                                  color: colorScheme.mutedForeground,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Stats Card
                  _buildStatsCard(theme, colorScheme, ref),

                  const SizedBox(height: 32),

                  // Menu Items
                  _buildMenuGroup(
                    theme: theme,
                    colorScheme: colorScheme,
                    title: 'Account',
                    items: [
                      _buildMenuItem(
                        icon: LucideIcons.user,
                        label: 'Personal Information',
                        theme: theme,
                        colorScheme: colorScheme,
                        onTap: () => _showBottomSheetModal(
                          context,
                          'Personal Information',
                          PersonalInfoModal(
                            currentUsername: username,
                            currentEmail: email,
                          ),
                        ),
                      ),
                      _buildMenuItem(
                        icon: LucideIcons.lock,
                        label: 'Reset Password',
                        theme: theme,
                        colorScheme: colorScheme,
                        onTap: () => _showBottomSheetModal(
                          context,
                          'Reset Password',
                          SecurityModal(email: email),
                        ),
                      ),
                      _buildMenuItem(
                        icon: LucideIcons.bell,
                        label: 'Notifications',
                        theme: theme,
                        colorScheme: colorScheme,
                        onTap: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  _buildMenuGroup(
                    theme: theme,
                    colorScheme: colorScheme,
                    title: 'Support',
                    items: [
                      _buildMenuItem(
                        icon: LucideIcons.helpCircle,
                        label: 'Help & Support',
                        theme: theme,
                        colorScheme: colorScheme,
                        onTap: () => _showBottomSheetModal(
                          context,
                          'Help & Support',
                          const Center(
                            child: Text('Contact us at 16tolu@gmail.com'),
                          ),
                        ),
                      ),
                      _buildMenuItem(
                        icon: LucideIcons.messageSquare,
                        label: 'Submit Feedback',
                        theme: theme,
                        colorScheme: colorScheme,
                        onTap: () => _showBottomSheetModal(
                          context,
                          'Anonymous Feedback',
                          const FeedbackModal(),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ShadButton.destructive(
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ShadDialog(
                              title: const Text('Log Out'),
                              description: const Text(
                                'Are you sure you want to log out of your account?',
                              ),
                              actions: [
                                ShadButton.outline(
                                  child: const Text('Cancel'),
                                  onPressed: () => Navigator.pop(ctx, false),
                                ),
                                ShadButton.destructive(
                                  child: const Text('Log Out'),
                                  onPressed: () => Navigator.pop(ctx, true),
                                ),
                              ],
                            ),
                          ),
                        );

                        if (confirmed == true) {
                          await ref.read(userProvider.notifier).logout();
                          if (context.mounted) {
                            context.go('/get-started');
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(LucideIcons.logOut, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Log Out',
                            style: theme.textTheme.small.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.destructiveForeground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(
    ShadThemeData theme,
    ShadColorScheme colorScheme,
    WidgetRef ref,
  ) {
    final statsAsync = ref.watch(userStatsProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.border),
      ),
      child: statsAsync.when(
        loading: () => const SizedBox(
          height: 72,
          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
        error: (_, __) => const SizedBox.shrink(),
        data: (stats) {
          final isProfit = stats.netProfit >= 0;
          final profitColor = isProfit
              ? const Color(0xFF22c55e)
              : const Color(0xFFef4444);

          return Column(
            children: [
              // Net profit headline
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Net Profit',
                    style: theme.textTheme.small.copyWith(
                      color: colorScheme.mutedForeground,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${isProfit ? '+' : ''}₦${stats.netProfit.toStringAsFixed(2)}',
                    style: theme.textTheme.large.copyWith(
                      color: profitColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Divider(height: 1, color: colorScheme.border),
              const SizedBox(height: 16),

              // 4-stat grid
              Row(
                children: [
                  _buildStatCell(
                    'Total',
                    '${stats.totalTickets}',
                    theme,
                    colorScheme,
                  ),
                  _buildStatDivider(colorScheme),
                  _buildStatCell(
                    'Won',
                    '${stats.wonTickets}',
                    theme,
                    colorScheme,
                    color: const Color(0xFF22c55e),
                  ),
                  _buildStatDivider(colorScheme),
                  _buildStatCell(
                    'Lost',
                    '${stats.lostTickets}',
                    theme,
                    colorScheme,
                    color: const Color(0xFFef4444),
                  ),
                  _buildStatDivider(colorScheme),
                  _buildStatCell(
                    'Pending',
                    '${stats.pendingTickets}',
                    theme,
                    colorScheme,
                    color: colorScheme.primary,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatCell(
    String label,
    String value,
    ShadThemeData theme,
    ShadColorScheme colorScheme, {
    Color? color,
  }) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: theme.textTheme.large.copyWith(
              fontWeight: FontWeight.bold,
              color: color ?? colorScheme.foreground,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.muted.copyWith(
              fontSize: 11,
              color: colorScheme.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider(ShadColorScheme colorScheme) {
    return SizedBox(
      height: 36,
      child: VerticalDivider(width: 1, color: colorScheme.border),
    );
  }

  Widget _buildMenuGroup({
    required String title,
    required List<Widget> items,
    required ShadThemeData theme,
    required ShadColorScheme colorScheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 12),
          child: Text(
            title.toUpperCase(),
            style: theme.textTheme.small.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.mutedForeground,
              letterSpacing: 1.2,
              fontSize: 11,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colorScheme.border),
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isLast = index == items.length - 1;

              if (isLast) {
                return item;
              }

              return Column(
                children: [
                  item,
                  Padding(
                    padding: const EdgeInsets.only(left: 56),
                    child: Divider(height: 1, color: colorScheme.border),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required ShadThemeData theme,
    required ShadColorScheme colorScheme,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: colorScheme.foreground),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.small.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.foreground,
                ),
              ),
            ),
            Icon(
              LucideIcons.chevronRight,
              size: 18,
              color: colorScheme.mutedForeground,
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheetModal(
    BuildContext context,
    String title,
    Widget content,
  ) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.background,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              border: Border.all(color: colorScheme.border),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Drag Handle
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: colorScheme.muted,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.h4.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.foreground,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            LucideIcons.x,
                            color: colorScheme.mutedForeground,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: colorScheme.border),
                  // Content
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: content,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
