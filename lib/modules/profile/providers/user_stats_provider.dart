import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slipwise/modules/auth/data/repositories/auth_repository.dart';
import 'package:slipwise/modules/profile/data/models/user_stats.dart';

part 'user_stats_provider.g.dart';

@riverpod
Future<UserStats> userStats(Ref ref) async {
  final result = await ref.read(authRepositoryProvider).getUserStats();
  return result.fold(
    ifLeft: (failure) => throw Exception(failure.message),
    ifRight: (stats) => stats,
  );
}
