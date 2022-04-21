import 'package:reminder/features/login/domain/entities/verify_request_entity.dart';

class VerifyRequestModel extends VerifyRequestEntity {
  const VerifyRequestModel(
      {required String userName, required int code, required String key})
      : super(userName: userName, code: code, key: key);

  Map<String, dynamic> toJson() {
    return {
      'username': userName,
      'key': key,
      'otp': code,
    };
  }
}
