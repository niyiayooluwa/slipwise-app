import 'package:dart_either/dart_either.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:slipwise/core/errors/failures.dart';
import 'package:slipwise/modules/auth/data/models/message_response.dart';
import 'package:slipwise/modules/tickets/data/remote/ticket_remote.dart';

import '../models/bulk_action.dart';
import '../models/history.dart';
import '../models/preview.dart';
import '../models/ticket_detail.dart';
import '../models/track.dart';
import '../models/update_ticket.dart';

part 'ticket_repository.g.dart';

class TicketRepository {
  final TicketRemote _ticketRemote;

  TicketRepository(this._ticketRemote);

  Future<Either<Failure, PaginatedHistoryResponse>> getTickets({
    int page = 1,
    int limit = 20,
    String? status,
    String? since,
  }) async {
    return _ticketRemote.getTickets(
      page: page,
      limit: limit,
      status: status,
      since: since,
    );
  }

  Future<Either<Failure, MessageResponse>> deleteTicket(String id) async {
    return _ticketRemote.deleteTicket(id);
  }

  Future<Either<Failure, BulkActionResponse>> bulkArchiveTickets(
    List<String> ticketIds,
  ) async {
    return _ticketRemote.bulkArchiveTickets(ticketIds);
  }

  Future<Either<Failure, BulkActionResponse>> bulkUnarchiveTickets(
    List<String> ticketIds,
  ) async {
    return _ticketRemote.bulkUnarchiveTickets(ticketIds);
  }

  Future<Either<Failure, BulkActionResponse>> bulkDeleteTickets(
    List<String> ticketIds,
  ) async {
    return _ticketRemote.bulkDeleteTickets(ticketIds);
  }

  Future<Either<Failure, PaginatedHistoryResponse>> getArchivedTickets({
    int page = 1,
    int limit = 20,
    String? status,
    String? since,
  }) async {
    return _ticketRemote.getArchivedTickets(
      page: page,
      limit: limit,
      status: status,
      since: since,
    );
  }

  Future<Either<Failure, TicketDetailsResponse>> getTicketDetails(
    String id,
  ) async {
    return _ticketRemote.getTicketDetails(id);
  }

  Future<Either<Failure, PreviewResponse>> previewTicket(
    PreviewRequest request,
  ) async {
    return _ticketRemote.previewTicket(request);
  }

  Future<Either<Failure, MessageResponse>> trackTicket(
    TrackRequest request,
  ) async {
    return _ticketRemote.trackTicket(request);
  }

  Future<Either<Failure, MessageResponse>> updateTicket(
    String id,
    UpdateTicketRequest request,
  ) async {
    return _ticketRemote.updateTicket(id, request);
  }
}

@riverpod
TicketRepository ticketRepository(Ref ref) {
  return TicketRepository(ref.watch(ticketRemoteProvider));
}
