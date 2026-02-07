import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

@injectable
class ConfirmCode extends UseCase<AuthTokens, ConfirmCodeParams> {
  final AuthRepository repository;

  ConfirmCode(this.repository);

  @override
  Future<Either<Failure, AuthTokens>> call(ConfirmCodeParams params) async {
    return await repository.confirmCode(params.email, params.code);
  }
}

class ConfirmCodeParams extends Equatable {
  final String email;
  final String code;

  const ConfirmCodeParams({
    required this.email,
    required this.code,
  });

  @override
  List<Object> get props => [email, code];
}
