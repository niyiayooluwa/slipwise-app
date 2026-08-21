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

part 'ticket_remote.g.dart';

class TicketRemote {
  final Dio _dio;

  TicketRemote(this._dio);

  Future<Either<Failure, PaginatedHistoryResponse>> getTickets({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _dio.get(
        '/v1/tickets',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );
      return Right(PaginatedHistoryResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
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

  Future<Either<Failure, List<TicketDetailItem>>> getTicketDetails(String id) async {
    try {
      final response = await _dio.get('/v1/tickets/$id');
      final data = response.data as List;
      final items = data.map((e) => TicketDetailItem.fromJson(e as Map<String, dynamic>)).toList();
      return Right(items);
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(mapException(e));
    }
  }

  Future<Either<Failure, PreviewResponse>> previewTicket(PreviewRequest request) async {
    try {
      final response = await _dio.post(
        '/v1/tickets/preview',
        data: request.toJson(),
      );
      return Right(PreviewResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(mapException(e));
    }
  }

  Future<Either<Failure, MessageResponse>> trackTicket(TrackRequest request) async {
    try {
      final response = await _dio.post(
        '/v1/tickets/track',
        data: request.toJson(),
      );
      return Right(MessageResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(mapException(e));
    }
  }
}

@riverpod
TicketRemote ticketRemote(Ref ref) {
  return TicketRemote(ref.watch(dioProvider));
}
