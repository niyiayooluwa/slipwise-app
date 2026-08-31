import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/tickets/data/models/preview.dart';
import 'package:slipwise/modules/tickets/data/models/track.dart';
import 'package:slipwise/modules/tickets/providers/history_controller.dart';
import 'package:slipwise/modules/tickets/providers/ticket_action_controller.dart';

part 'track_form_controller.g.dart';

class TrackFormState {
  final PreviewResponse? previewResponse;
  final bool isPreviewing;
  final bool isTracking;
  final String? errorMessage;
  final bool isTimeout;
  final bool isSuccess;

  TrackFormState({
    this.previewResponse,
    this.isPreviewing = false,
    this.isTracking = false,
    this.errorMessage,
    this.isTimeout = false,
    this.isSuccess = false,
  });

  TrackFormState copyWith({
    PreviewResponse? previewResponse,
    bool? isPreviewing,
    bool? isTracking,
    String? errorMessage,
    bool? isTimeout,
    bool? isSuccess,
    bool clearError = false,
  }) {
    return TrackFormState(
      previewResponse: previewResponse ?? this.previewResponse,
      isPreviewing: isPreviewing ?? this.isPreviewing,
      isTracking: isTracking ?? this.isTracking,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isTimeout: isTimeout ?? this.isTimeout,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

@riverpod
class TrackFormController extends _$TrackFormController {
  @override
  TrackFormState build() => TrackFormState();

  void clearError() {
    state = state.copyWith(clearError: true, isTimeout: false);
  }

  void resetSuccess() {
    state = state.copyWith(isSuccess: false);
  }

  void clearPreview() {
    state = TrackFormState(); // Reset completely
  }

  Future<void> previewTicket(String code, String provider) async {
    if (code.isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter your booking code');
      return;
    }

    state = state.copyWith(isPreviewing: true, clearError: true);

    try {
      final preview = await ref
          .read(ticketActionsProvider.notifier)
          .previewTicket(PreviewRequest(code: code, provider: provider));

      if (preview != null) {
        state = state.copyWith(previewResponse: preview, isPreviewing: false);
      } else {
        state = state.copyWith(isPreviewing: false);
      }
    } catch (e) {
      _handleError(e);
      state = state.copyWith(isPreviewing: false);
    }
  }

  Future<void> trackTicket(String? stakeText, String? descriptionText) async {
    final preview = state.previewResponse;
    if (preview == null) return;

    state = state.copyWith(isTracking: true, clearError: true);

    try {
      final stake = stakeText?.isEmpty ?? true
          ? null
          : double.tryParse(stakeText!);
      final description = descriptionText?.isEmpty ?? true
          ? null
          : descriptionText!.trim();

      final response = await ref
          .read(ticketActionsProvider.notifier)
          .trackTicket(
            TrackRequest(
              bookingCodeId: preview.bookingCodeId,
              stake: stake,
              description: description,
            ),
          );

      if (response != null) {
        state = state.copyWith(isTracking: false, isSuccess: true);
        ref.invalidate(historyControllerProvider('ALL'));
      } else {
        state = state.copyWith(isTracking: false);
      }
    } catch (e) {
      _handleError(e);
      state = state.copyWith(isTracking: false);
    }
  }

  void _handleError(Object error) {
    final errorMessage = error.toString();
    if (errorMessage.contains('timeout') ||
        errorMessage.contains('deadline exceeded')) {
      state = state.copyWith(
        isTimeout: true,
        errorMessage:
            'Sportybet is taking too long to respond. Please try again in a moment.',
      );
    } else {
      state = state.copyWith(
        errorMessage: errorMessage.replaceAll('Exception: ', ''),
      );
    }
  }
}
