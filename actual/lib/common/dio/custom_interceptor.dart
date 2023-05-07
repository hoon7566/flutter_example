import 'package:dio/dio.dart';

class CustomInterceptor extends Interceptor {

  // 1) 요청을 보낼 때

  // 2) 응답을 받을 때

  // 3) 에러가 발생했을 때



  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    print(options);
    return super.onRequest(options, handler);
  }
}