import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';

class AuthRemote {
  final Dio _dio;

  AuthRemote(this._dio);

  Future<Either<Failure, UserModel>> login () {}
}
