import 'dart:developer' as developer;
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:slipwise/core/errors/error_mapper.dart';
import 'package:slipwise/core/errors/failures.dart';
import 'package:slipwise/core/server/dio_client.dart';
import 'package:slipwise/modules/auth/data/models/message_response.dart';

import '../models/history.dart';
import '../models/preview.dart';
import '../models/ticket_detail.dart';
import '../models/track.dart';
import '../models/update_ticket.dart';

part 'ticket_remote.g.dart';

class TicketRemote {
  final Dio _dio;

  TicketRemote(this._dio);

  Future<Either<Failure, PaginatedHistoryResponse>> getTickets({
    int page = 1,
    int limit = 20,
    String? status,
    String? since,
  }) async {
    try {
      final response = await _dio.get(
        '/v1/tickets',
        queryParameters: {
          'page': page,
          'limit': limit,
          'status': status,
          'since': since,
        }..removeWhere((_, v) => v == null),
      );
      return Right(PaginatedHistoryResponse.fromJson(response.data));
    } on DioException catch (e) {
      developer.log('DioException in getTickets: $e', name: 'TicketRemote');
      return Left(mapDioException(e));
    } catch (e, stack) {
      developer.log(
        'Exception in getTickets: $e\n$stack',
        name: 'TicketRemote',
      );
      return Left(mapException(e));
    }
  }

  Future<Either<Failure, MessageResponse>> deleteTicket(String id) async {
    try {
      final response = await _dio.delete('/v1/tickets/$id');
      return Right(MessageResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(mapException(e));
    }
  }

  Future<Either<Failure, TicketDetailsResponse>> getTicketDetails(
    String id,
  ) async {
    try {
      final response = await _dio.get('/v1/tickets/$id');
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return Right(TicketDetailsResponse.fromJson(data));
      } else if (data is Map) {
        return Right(
          TicketDetailsResponse.fromJson(Map<String, dynamic>.from(data)),
        );
      } else if (data is List) {
        // Fallback for legacy raw array response
        final items = data
            .map((e) => TicketDetailItem.fromJson(e as Map<String, dynamic>))
            .toList();
        final won = items
            .where((i) => i.selectionStatus.toLowerCase() == 'won')
            .length;
        final lost = items
            .where(
              (i) =>
                  i.selectionStatus.toLowerCase() == 'lost' ||
                  i.selectionStatus.toLowerCase() == 'cut',
            )
            .length;
        final pending = items.length - won - lost;
        return Right(
          TicketDetailsResponse(
            summary: TicketSummary(
              totalLegs: items.length,
              wonLegs: won,
              lostLegs: lost,
              pendingLegs: pending > 0 ? pending : 0,
            ),
            selections: items,
          ),
        );
      }
      return const Left(ServerFailure('Invalid response format from server'));
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(mapException(e));
    }
  }

  Future<Either<Failure, PreviewResponse>> previewTicket(
    PreviewRequest request,
  ) async {
    try {
      final response = await _dio.post(
        '/v1/tickets/preview',
        data: request.toJson(),
      );
      final data = response.data;
      if (data is Map) {
        final selections = data['selections'];
        if (selections == null || (selections is List && selections.isEmpty)) {
          return const Left(
            BadRequestFailure(
              'Hmmm... Your code has either expired or is invalid',
            ),
          );
        }
      }
      return Right(PreviewResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(mapException(e));
    }
  }

  Future<Either<Failure, MessageResponse>> trackTicket(
    TrackRequest request,
  ) async {
    try {
      final response = await _dio.post(
        '/v1/tickets/track',
        data: request.toJson(),
      );
      return Right(MessageResponse.fromJson(response.data));
    } on DioException catch (e) {
      developer.log('DioException in trackTicket: $e', name: 'TicketRemote');
      return Left(mapDioException(e));
    } catch (e, stack) {
      developer.log(
        'Exception in trackTicket: $e\n$stack',
        name: 'TicketRemote',
      );
      return Left(mapException(e));
    }
  }

  Future<Either<Failure, MessageResponse>> updateTicket(
    String id,
    UpdateTicketRequest request,
  ) async {
    try {
      final response = await _dio.patch(
        '/v1/tickets/$id',
        data: request.toJson(),
      );
      return Right(MessageResponse.fromJson(response.data));
    } on DioException catch (e) {
      developer.log('DioException in updateTicket: $e', name: 'TicketRemote');
      return Left(mapDioException(e));
    } catch (e, stack) {
      developer.log(
        'Exception in updateTicket: $e\n$stack',
        name: 'TicketRemote',
      );
      return Left(mapException(e));
    }
  }
}

@riverpod
TicketRemote ticketRemote(Ref ref) {
  return TicketRemote(ref.watch(dioProvider));
}
