import 'package:dartz/dartz.dart';

import 'package:reminder/features/login/data/datasources/login_local_data_source.dart';
import 'package:reminder/features/login/data/datasources/login_remote_data_source.dart';
import 'package:reminder/features/login/domain/entities/login_info_entity.dart';
import 'package:reminder/features/login/domain/entities/verify_request_entity.dart';
import 'package:reminder/features/login/domain/repositories/login_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../models/verify_request_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, LoginInfoEntity>> sendPhone(String number) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.loginRequest(number);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> verifyCode(
      VerifyRequestEntity verifyRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.verifyRequest(verifyRequest);
        localDataSource.cacheLoginToken(response);
        return const Right(true);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
