import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reminder/core/network/network_info.dart';
import 'package:reminder/features/login/data/datasources/login_local_data_source.dart';
import 'package:reminder/features/login/data/datasources/login_remote_data_source.dart';
import 'package:reminder/features/login/data/repositories/login_repository_impl.dart';
import 'package:reminder/features/login/domain/entities/verify_request_entity.dart';
import 'package:reminder/features/login/domain/usecases/login_request.dart';
import 'package:reminder/features/login/domain/usecases/verify_request.dart';
import 'package:reminder/features/login/presentation/screens/verification_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  late final LoginRepositoryImpl repo;
  var _phoneNumber = '';
  var _key = '';
  late final String _token;
  late final SharedPreferences sp;
  late final LoginLocalDataSourceImpl localDataSource;
  late final NetworkInfo netInfo;

  var _initialized = false;

  String get phoneNumber => _phoneNumber;

  String get token => _token;

  Future<bool> get hasValidToken async {
    while (!_initialized) {
      await Future.delayed(Duration(milliseconds: 500));
    }
    _token = localDataSource.getLoginToken().toString();
    if (_token.length > 1) {
      if (JwtDecoder.isExpired(_token)) {
        localDataSource.deleteCacheLoginToken();
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  @override
  Future<void> onInit() async {
    sp = await SharedPreferences.getInstance();
    netInfo = NetworkInfoImpl(InternetConnectionChecker());
    final remotDataSource = LoginRemoteDataSourceImpl(client: Client());
    localDataSource = LoginLocalDataSourceImpl(sharedPreferences: sp);
    repo = LoginRepositoryImpl(
        networkInfo: netInfo,
        remoteDataSource: remotDataSource,
        localDataSource: localDataSource);
    super.onInit();
    _initialized = true;
  }

  Future<void> sendPhone(String value) async {
    _phoneNumber = value;
    print(value);

    var temp = await LoginRequest(repo).call(Params(number: value));
    temp.fold((l) => Get.snackbar(l.toString(), ''), (r) {
      _key = r.response;
    });

    Get.toNamed(VerificationScreen.route);
  }

  Future<void> verifyCode(String code) async {
    final _verify = VerifyRequestEntity(
        userName: _phoneNumber, code: int.parse(code), key: _key);
    var temp = await VerifyRequest(repo).call(_verify);
    temp.fold((l) => print(l), (r) => print(r));
    Get.toNamed('page');
  }
}
