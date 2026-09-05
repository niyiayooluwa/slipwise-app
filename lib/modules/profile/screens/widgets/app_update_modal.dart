import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/modules/profile/providers/app_version_provider.dart';

class AppUpdateModal extends HookConsumerWidget {
  const AppUpdateModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final colorScheme = theme.colorScheme;

    final versionAsync = ref.watch(appVersionProvider);

    return versionAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 32.0),
        child: Center(child: SpinKitThreeBounce(size: 20, color: Colors.white)),
      ),
      error: (err, _) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          'Failed to load version info: $err',
          style: theme.textTheme.small.copyWith(color: colorScheme.destructive),
        ),
      ),
      data: (info) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // App Info summary banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colorScheme.border),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      LucideIcons.smartphone,
                      size: 24,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SlipWise App',
                          style: theme.textTheme.large.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.foreground,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${info.formattedVersion} • ${info.formattedPatch}',
                          style: theme.textTheme.small.copyWith(
                            color: colorScheme.mutedForeground,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Dynamic status content
            _buildStatusSection(context, ref, info, theme, colorScheme),

            const SizedBox(height: 24),

            // Action Button
            _buildActionButton(context, ref, info, theme, colorScheme),
          ],
        );
      },
    );
  }

  Widget _buildStatusSection(
    BuildContext context,
    WidgetRef ref,
    AppVersionState info,
    ShadThemeData theme,
    ShadColorScheme colorScheme,
  ) {
    switch (info.updateStatus) {
      case AppUpdateProgressStatus.checking:
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorScheme.border),
          ),
          child: Column(
            children: [
              const SpinKitThreeBounce(size: 20, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                'Checking for updates...',
                style: theme.textTheme.small.copyWith(
                  color: colorScheme.foreground,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );

      case AppUpdateProgressStatus.updateAvailable:
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xfffbbf24).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xfffbbf24).withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                LucideIcons.sparkles,
                size: 24,
                color: Color(0xfffbbf24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New OTA Patch Available!',
                      style: theme.textTheme.small.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xfffbbf24),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'A new quick update is ready. It will download instantly in the background without reinstalling.',
                      style: theme.textTheme.small.copyWith(
                        color: colorScheme.foreground,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

      case AppUpdateProgressStatus.downloading:
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorScheme.border),
          ),
          child: Column(
            children: [
              const SpinKitThreeBounce(size: 20, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                'Downloading & applying patch...',
                style: theme.textTheme.small.copyWith(
                  color: colorScheme.foreground,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );

      case AppUpdateProgressStatus.downloadedReadyToRestart:
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xff4ade80).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xff4ade80).withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                LucideIcons.checkCircle2,
                size: 24,
                color: Color(0xff4ade80),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Update Downloaded!',
                      style: theme.textTheme.small.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff4ade80),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'The patch is ready. Fully close and reopen SlipWise to enjoy the latest updates.',
                      style: theme.textTheme.small.copyWith(
                        color: colorScheme.foreground,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

      case AppUpdateProgressStatus.upToDate:
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xff4ade80).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xff4ade80).withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                LucideIcons.checkCircle,
                size: 22,
                color: Color(0xff4ade80),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You are on the latest version',
                      style: theme.textTheme.small.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff4ade80),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'No new patches or updates are currently available.',
                      style: theme.textTheme.small.copyWith(
                        color: colorScheme.mutedForeground,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

      case AppUpdateProgressStatus.error:
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.destructive.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.destructive.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                LucideIcons.alertCircle,
                size: 22,
                color: colorScheme.destructive,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  info.errorMessage ??
                      'An error occurred while checking for updates.',
                  style: theme.textTheme.small.copyWith(
                    color: colorScheme.destructive,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        );

      case AppUpdateProgressStatus.idle:
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorScheme.border),
          ),
          child: Row(
            children: [
              Icon(
                LucideIcons.info,
                size: 20,
                color: colorScheme.mutedForeground,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'SlipWise receives instant over-the-air performance and bug fix patches.',
                  style: theme.textTheme.small.copyWith(
                    color: colorScheme.mutedForeground,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        );
    }
  }

  Widget _buildActionButton(
    BuildContext context,
    WidgetRef ref,
    AppVersionState info,
    ShadThemeData theme,
    ShadColorScheme colorScheme,
  ) {
    if (info.updateStatus == AppUpdateProgressStatus.updateAvailable) {
      return ShadButton(
        onPressed: () {
          ref.read(appVersionProvider.notifier).downloadAndInstallUpdate();
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.downloadCloud, size: 18),
            SizedBox(width: 8),
            Text('Download & Install Patch'),
          ],
        ),
      );
    }

    if (info.updateStatus == AppUpdateProgressStatus.downloadedReadyToRestart) {
      return ShadButton.outline(
        onPressed: () => Navigator.pop(context),
        child: const Text('Done (Restart App Later)'),
      );
    }

    final isBusy =
        info.updateStatus == AppUpdateProgressStatus.checking ||
        info.updateStatus == AppUpdateProgressStatus.downloading;

    return ShadButton.outline(
      enabled: !isBusy,
      onPressed: () {
        ref.read(appVersionProvider.notifier).checkForUpdates();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(LucideIcons.refreshCw, size: 16),
          const SizedBox(width: 8),
          Text(isBusy ? 'Checking...' : 'Check for Updates'),
        ],
      ),
    );
  }
}
