
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_api/util/util.dart';


final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  dio.interceptors.add(
    CustomInterceptor(
      ref: ref,
    ),
  );

  return dio;
});

class CustomInterceptor extends Interceptor {
  final Ref ref;

  CustomInterceptor({
    required this.ref,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');
    options.headers.addAll({
      'Content-Type': 'application/json;charset=UTF-8',
      'Accept': 'application/json'
    });

    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');
      const token = accessToken;
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }
    return super.onRequest(options, handler);
  }

  // 2) 응답을 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    return super.onResponse(response, handler);
  }

  // 3) 에러가 났을때
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    return handler.reject(err);
  }
}
