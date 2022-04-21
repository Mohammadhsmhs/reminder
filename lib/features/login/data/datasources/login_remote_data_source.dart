import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reminder/core/constants/constants.dart';
import 'package:reminder/features/login/data/models/login_info_model.dart';
import 'package:reminder/features/login/data/models/verify_request_model.dart';
import 'package:reminder/features/login/domain/entities/verify_request_entity.dart';

import '../../../../core/error/exceptions.dart';

abstract class LoginRemoteDataSource {
  Future<LoginInfoModel> loginRequest(String userName);
  Future<LoginInfoModel> verifyRequest(VerifyRequestEntity verifyRequest);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({required this.client});

  @override
  Future<LoginInfoModel> loginRequest(String userName) async {
    var request = http.Request(
        'POST', Uri.parse('${Constants.constantUrl}/v1/auth/login'));
    request.body = json.encode({"username": userName});
    var headers = {'Content-Type': 'application/json'};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var temp = await response.stream.bytesToString();

      return LoginInfoModel.fromJson(json.decode(temp));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<LoginInfoModel> verifyRequest(
      VerifyRequestEntity verifyRequest) async {
    VerifyRequestModel _verify = VerifyRequestModel(
        userName: verifyRequest.userName,
        code: verifyRequest.code,
        key: verifyRequest.key);
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('${Constants.constantUrl}/v1/auth/verify'));
    request.body = json.encode(_verify.toJson());
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var temp = await response.stream.bytesToString();

      return LoginInfoModel.fromJsonResponse(json.decode(temp));
    } else {
      throw ServerException();
    }
  }
}
