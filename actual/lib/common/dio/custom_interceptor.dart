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
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // 401에러가 났을 때
    // 토큰을 재발급 받는 시도를 하고 토큰이 재발급되면 다시 요청을 보낸다.

    print("[ERR]${err.requestOptions.method} | ${err.requestOptions.uri}");

    final statusCode = err.response?.statusCode;
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    if(refreshToken == null){
      // 에러를 던짐.
      // handler.reject(err)로 에러를 그대로 발생 시킬 수 있다.
      return handler.reject(err);
    }

    final isStatus401 = statusCode == 401;
    final isPathRefresh = err.requestOptions.path == "/auth/token";

    if(isStatus401 && !isPathRefresh){
      try{

        final dio = Dio();
        final resp = await dio.post("http://$SERVER_IP/auth/token", options: Options(
          headers: {
            'authorization': 'Bearer $refreshToken',
          }
        ));

        final newAccessToken = resp.data['accessToken'];

        final options = err.requestOptions;

        options.headers.addAll({
          'authorization': 'Bearer $newAccessToken',
        });

        await storage.write(key: ACCESS_TOKEN_KEY, value: newAccessToken);

        // fetch로 요청 재전송
        final response = await dio.fetch(options);

        // 다시 보낸 요청의 응답값을 resolve로 response를 주면 정상적인 요청이 간것처럼 처리된다.
        return handler.resolve(response);
      } on DioError catch(e){
        // 에러를 던짐.
        return handler.reject(err);
      }


    }





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

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // response status code와 url을 출력해준다.
    print("[RES]${response.statusCode} |${response.requestOptions.method}| ${response.requestOptions.uri}");

    return super.onResponse(response, handler);
  }
}
