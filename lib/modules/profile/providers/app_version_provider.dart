import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

part 'app_version_provider.g.dart';

enum AppUpdateProgressStatus {
  idle,
  checking,
  upToDate,
  updateAvailable,
  downloading,
  downloadedReadyToRestart,
  error,
}

class AppVersionState {
  final String appVersion;
  final String buildNumber;
  final int? currentPatchNumber;
  final bool isShorebirdAvailable;
  final AppUpdateProgressStatus updateStatus;
  final String? errorMessage;

  const AppVersionState({
    required this.appVersion,
    required this.buildNumber,
    this.currentPatchNumber,
    required this.isShorebirdAvailable,
    this.updateStatus = AppUpdateProgressStatus.idle,
    this.errorMessage,
  });

  String get formattedVersion => 'v$appVersion (Build $buildNumber)';

  String get formattedPatch => currentPatchNumber != null
      ? 'Patch #$currentPatchNumber'
      : isShorebirdAvailable
          ? 'Base Release'
          : 'Local Dev';

  AppVersionState copyWith({
    String? appVersion,
    String? buildNumber,
    int? currentPatchNumber,
    bool? isShorebirdAvailable,
    AppUpdateProgressStatus? updateStatus,
    String? errorMessage,
  }) {
    return AppVersionState(
      appVersion: appVersion ?? this.appVersion,
      buildNumber: buildNumber ?? this.buildNumber,
      currentPatchNumber: currentPatchNumber ?? this.currentPatchNumber,
      isShorebirdAvailable: isShorebirdAvailable ?? this.isShorebirdAvailable,
      updateStatus: updateStatus ?? this.updateStatus,
      errorMessage: errorMessage,
    );
  }
}

@Riverpod(keepAlive: true)
class AppVersionNotifier extends _$AppVersionNotifier {
  final ShorebirdUpdater _updater = ShorebirdUpdater();

  @override
  Future<AppVersionState> build() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final isAvailable = _updater.isAvailable;

    int? patchNumber;
    if (isAvailable) {
      try {
        final currentPatch = await _updater.readCurrentPatch();
        patchNumber = currentPatch?.number;
      } catch (e) {
        debugPrint('Error reading current patch: $e');
      }
    }

    return AppVersionState(
      appVersion: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
      currentPatchNumber: patchNumber,
      isShorebirdAvailable: isAvailable,
    );
  }

  Future<void> checkForUpdates() async {
    final currentState = state.value;
    if (currentState == null) return;

    if (!currentState.isShorebirdAvailable) {
      state = AsyncValue.data(
        currentState.copyWith(
          updateStatus: AppUpdateProgressStatus.upToDate,
        ),
      );
      return;
    }

    state = AsyncValue.data(
      currentState.copyWith(updateStatus: AppUpdateProgressStatus.checking),
    );

    try {
      final status = await _updater.checkForUpdate();

      if (status == UpdateStatus.outdated) {
        state = AsyncValue.data(
          currentState.copyWith(
            updateStatus: AppUpdateProgressStatus.updateAvailable,
          ),
        );
      } else if (status == UpdateStatus.restartRequired) {
        state = AsyncValue.data(
          currentState.copyWith(
            updateStatus: AppUpdateProgressStatus.downloadedReadyToRestart,
          ),
        );
      } else {
        state = AsyncValue.data(
          currentState.copyWith(
            updateStatus: AppUpdateProgressStatus.upToDate,
          ),
        );
      }
    } catch (e) {
      state = AsyncValue.data(
        currentState.copyWith(
          updateStatus: AppUpdateProgressStatus.error,
          errorMessage: 'Failed to check for updates: $e',
        ),
      );
    }
  }

  Future<void> downloadAndInstallUpdate() async {
    final currentState = state.value;
    if (currentState == null) return;

    state = AsyncValue.data(
      currentState.copyWith(updateStatus: AppUpdateProgressStatus.downloading),
    );

    try {
      await _updater.update();
      final updatedPatch = await _updater.readCurrentPatch();

      state = AsyncValue.data(
        currentState.copyWith(
          currentPatchNumber: updatedPatch?.number,
          updateStatus: AppUpdateProgressStatus.downloadedReadyToRestart,
        ),
      );
    } catch (e) {
      state = AsyncValue.data(
        currentState.copyWith(
          updateStatus: AppUpdateProgressStatus.error,
          errorMessage: 'Failed to download update: $e',
        ),
      );
    }
  }

  void resetStatus() {
    final currentState = state.value;
    if (currentState == null) return;
    state = AsyncValue.data(
      currentState.copyWith(updateStatus: AppUpdateProgressStatus.idle),
    );
  }
}
