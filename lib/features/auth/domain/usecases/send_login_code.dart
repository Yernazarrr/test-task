import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

@injectable
class SendLoginCode extends UseCase<void, SendLoginCodeParams> {
  final AuthRepository repository;

  SendLoginCode(this.repository);

  @override
  Future<Either<Failure, void>> call(SendLoginCodeParams params) async {
    return await repository.sendLoginCode(params.email);
  }
}

class SendLoginCodeParams extends Equatable {
  final String email;

  const SendLoginCodeParams({required this.email});

  @override
  List<Object> get props => [email];
}
