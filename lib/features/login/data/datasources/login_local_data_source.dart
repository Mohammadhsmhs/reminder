import 'dart:convert';

import 'package:reminder/features/login/data/models/login_info_model.dart';
import 'package:reminder/features/login/domain/entities/login_info_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';

abstract class LoginLocalDataSource {
  LoginInfoEntity getLoginToken();

  Future<void> cacheLoginToken(LoginInfoModel logintoCache);
}

const CACHED_LOGIN_TOKEN = 'CACHED_LOGIN_TOKEN';

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SharedPreferences sharedPreferences;

  LoginLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheLoginToken(LoginInfoModel logintoCache) {
    return sharedPreferences.setString(
      CACHED_LOGIN_TOKEN,
      json.encode(logintoCache.toSharedPrefrences()),
    );
  }

  Future<void> deleteCacheLoginToken() {
    return sharedPreferences.remove(
      CACHED_LOGIN_TOKEN,
    );
  }

  @override
  LoginInfoEntity getLoginToken() {
    final jsonString = sharedPreferences.getString(CACHED_LOGIN_TOKEN);
    if (jsonString != null) {
      return LoginInfoModel.fromJsonResponse(json.decode(jsonString));
    } else {
      throw CacheException();
    }
  }
}
