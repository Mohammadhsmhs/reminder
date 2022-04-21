import 'package:dartz/dartz.dart';
import 'package:reminder/core/error/failure.dart';
import 'package:reminder/features/login/domain/entities/login_info_entity.dart';
import 'package:reminder/features/login/domain/entities/verify_request_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginInfoEntity>> sendPhone(String number);
  Future<Either<Failure, bool>> verifyCode(VerifyRequestEntity verifyRequest);
}
