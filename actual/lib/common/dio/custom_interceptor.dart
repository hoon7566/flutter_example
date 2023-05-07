import 'package:actual/common/const/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({required this.storage});

  // 1) 요청을 보낼 때

  // 2) 응답을 받을 때

  // 3) 에러가 발생했을 때

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return super.onError(err, handler);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // request method와 url을 출력해준다.
    print("[REQ]${options.method} | ${options.uri}");

    if (options.headers["accessToken"] == 'true') {
      options.headers.remove('accessToken');
      final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
      options.headers['accessToken'] = "Bearer $accessToken";
    }
    if (options.headers["refreshToken"] == 'true') {
      options.headers.remove('refreshToken');
      final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
      options.headers['refreshToken'] = "Bearer $refreshToken";
    }

    return super.onRequest(options, handler);
  }
}
