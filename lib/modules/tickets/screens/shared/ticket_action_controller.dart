// ticket_actions_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/auth/data/models/message_response.dart';
import 'package:slipwise/modules/tickets/data/models/preview.dart';
import 'package:slipwise/modules/tickets/data/models/track.dart';
import 'package:slipwise/modules/tickets/data/repositories/ticket_repository.dart';

part 'ticket_action_controller.g.dart';

@riverpod
class TicketActions extends _$TicketActions {
  @override
  Future<void> build() async => Future.value();

  Future<PreviewResponse> previewTicket(PreviewRequest request) async {
    state = const AsyncValue.loading();
    
    final result = await ref.read(ticketRepositoryProvider).previewTicket(request);
    
    return result.fold(
      ifLeft: (failure) {
        state = AsyncValue.error(Exception(failure.message), StackTrace.current);
        throw Exception(failure.message);
      },
      ifRight: (preview) {
        state = const AsyncValue.data(null);
        return preview;
      },
    );
  }

  Future<MessageResponse> trackTicket(TrackRequest request) async {
    state = const AsyncValue.loading();
    
    final result = await ref.read(ticketRepositoryProvider).trackTicket(request);
    
    return result.fold(
      ifLeft: (failure) {
        state = AsyncValue.error(Exception(failure.message), StackTrace.current);
        throw Exception(failure.message);
      },
      ifRight: (response) {
        state = const AsyncValue.data(null);
        return response;
      },
    );
  }
}