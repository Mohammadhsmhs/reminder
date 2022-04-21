
   
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:reminder/features/login/domain/entities/login_info_entity.dart';
import 'package:reminder/features/login/domain/repositories/login_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';



class LoginRequest implements UseCase<LoginInfoEntity, Params> {
  final LoginRepository repository;

  LoginRequest(this.repository);

  @override
  Future<Either<Failure, LoginInfoEntity>> call(Params params) async {
    return await repository.sendPhone(params.number);
  }
}

class Params extends Equatable {
  final String number;

  const Params({required this.number});

  @override
  List<Object> get props => [number];
}