import 'package:equatable/equatable.dart';

class LoginInfoEntity extends Equatable {
  const LoginInfoEntity(this.response);
  final String response;

  @override
  List<Object?> get props => [response];
}
