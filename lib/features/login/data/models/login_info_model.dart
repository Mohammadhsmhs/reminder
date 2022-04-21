import 'package:reminder/features/login/domain/entities/login_info_entity.dart';

class LoginInfoModel extends LoginInfoEntity {
  const LoginInfoModel(String response) : super(response);

  factory LoginInfoModel.fromJson(Map<String, dynamic> json) {
    return LoginInfoModel(
      json['key'],
    );
  }
  factory LoginInfoModel.fromJsonResponse(Map<String, dynamic> json) {
    return LoginInfoModel(
      json['token'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'username': response,
    };
  }
  Map<String, dynamic> toSharedPrefrences() {
    return {
      'token': response,
    };
  }
}
