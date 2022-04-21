import 'package:equatable/equatable.dart';

class VerifyRequestEntity extends Equatable {
  const VerifyRequestEntity(
      {required this.userName, required this.code, required this.key});

  final String userName;
  final String key;
  final int code;

  @override
  List<Object?> get props => [
        userName,
        key,
        code,
      ];
}
