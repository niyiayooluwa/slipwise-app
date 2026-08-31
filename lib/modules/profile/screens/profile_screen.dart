import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Temporary mock UserStats model.
// Replace with the actual UserStats model when available.
class UserStats {
  final double netProfit;
  final int totalTickets;
  final int wonTickets;
  final double totalStaked;
  final double totalReturns;

  const UserStats({
    required this.netProfit,
    required this.totalTickets,
    required this.wonTickets,
    required this.totalStaked,
    required this.totalReturns,
  });
}

// Temporary mock provider for UI testing.
final mockUserStatsProvider = Provider<UserStats>((ref) {
  return const UserStats(
    netProfit: 1250.50,
    totalTickets: 120,
    wonTickets: 75,
    totalStaked: 5000.0,
    totalReturns: 6250.50,
  );
});

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // In the future, this will watch the actual user stats provider
    final stats = ref.watch(mockUserStatsProvider);
    final theme = Theme.of(context);

    final isProfit = stats.netProfit >= 0;
    final profitColor = isProfit ? Colors.green : Colors.red;
    final winRate = stats.totalTickets > 0
        ? stats.wonTickets / stats.totalTickets
        : 0.0;

    // To normalize for the progress bars, we can find the max of staked vs returns
    final maxAmount = stats.totalStaked > stats.totalReturns
        ? stats.totalStaked
        : stats.totalReturns;
    final stakedProgress = maxAmount > 0 ? stats.totalStaked / maxAmount : 0.0;
    final returnsProgress = maxAmount > 0
        ? stats.totalReturns / maxAmount
        : 0.0;

    return Scaffold(
      appBar: AppBar(title: const Text('Analytics'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Hero Metric
            Text(
              'Net Profit',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${isProfit ? '+' : '-'}\$${stats.netProfit.abs().toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: theme.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: profitColor,
              ),
            ),

            const SizedBox(height: 48),

            // 2. Win/Loss Ring
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 160,
                    height: 160,
                    child: CircularProgressIndicator(
                      value: winRate,
                      strokeWidth: 14,
                      backgroundColor: theme.colorScheme.onSurface.withOpacity(
                        0.1,
                      ),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        theme.colorScheme.primary,
                      ),
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${(winRate * 100).toStringAsFixed(1)}%',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Win Rate',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Won ${stats.wonTickets} of ${stats.totalTickets} tickets',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),

            const SizedBox(height: 48),

            // 3. Total Staked vs Total Returns visual
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withOpacity(
                  0.4,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.colorScheme.outline.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Performance Overview',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Staked Row
                  _buildStatBar(
                    context: context,
                    label: 'Total Staked',
                    value: '\$${stats.totalStaked.toStringAsFixed(2)}',
                    progress: stakedProgress,
                    color: Colors.blueAccent,
                  ),

                  const SizedBox(height: 20),

                  // Returns Row
                  _buildStatBar(
                    context: context,
                    label: 'Total Returns',
                    value: '\$${stats.totalReturns.toStringAsFixed(2)}',
                    progress: returnsProgress,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBar({
    required BuildContext context,
    required String label,
    required String value,
    required double progress,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: theme.colorScheme.onSurface.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 10,
          ),
        ),
      ],
    );
  }
}
