import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

@injectable
class RefreshTokenUseCase extends UseCase<AuthTokens, RefreshTokenParams> {
  final AuthRepository repository;

  RefreshTokenUseCase(this.repository);

  @override
  Future<Either<Failure, AuthTokens>> call(RefreshTokenParams params) async {
    return await repository.refreshToken(params.refreshToken);
  }
}

class RefreshTokenParams extends Equatable {
  final String refreshToken;

  const RefreshTokenParams({required this.refreshToken});

  @override
  List<Object> get props => [refreshToken];
}
