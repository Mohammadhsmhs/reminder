import 'package:dartz/dartz.dart';

import 'package:reminder/features/login/domain/entities/verify_request_entity.dart';
import 'package:reminder/features/login/domain/repositories/login_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class VerifyRequest implements UseCase<bool, VerifyRequestEntity> {
  final LoginRepository repository;

  VerifyRequest(this.repository);

  @override
  Future<Either<Failure, bool>> call(VerifyRequestEntity verifyRequest) async {
    return await repository.verifyCode(verifyRequest);
  }
}
