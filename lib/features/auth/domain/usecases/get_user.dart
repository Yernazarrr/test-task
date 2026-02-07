import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

@injectable
class GetUser extends UseCase<User, GetUserParams> {
  final AuthRepository repository;

  GetUser(this.repository);

  @override
  Future<Either<Failure, User>> call(GetUserParams params) async {
    return await repository.getUser(params.accessToken);
  }
}

class GetUserParams extends Equatable {
  final String accessToken;

  const GetUserParams({required this.accessToken});

  @override
  List<Object> get props => [accessToken];
}
