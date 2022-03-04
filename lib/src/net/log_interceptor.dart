import 'package:dio/dio.dart';

/*
 * 创建人： zhaollong
 * 创建时间：2019-09-02
 * 页面说明：dio 网络请求拦截日志
 * 功能性修改记录：
 */
class LogsInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    super.onRequest(options, handler);
    print("\n================== 请求数据 ==========================");
    print("|请求url：${options.path}");
    print('|请求头: ' + options.headers.toString());
    print('|请求参数: ' + options.queryParameters.toString());
    print('|请求方法: ' + options.method);
    print("|contentType = ${options.contentType}");
    print('|请求时间: ' + DateTime.now().toString());
    if (options.data != null) {
      print('|请求数据: ' + options.data.toString());
    }
  }

  @override
  onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    super.onResponse(response, handler);
    print("\n|================== 响应数据 ==========================");
    if (response != null) {
      print("|url = ${response.realUri.path}");
      print("|code = ${response.statusCode}");
      print("|data = ${response.data}");
      print('|返回时间: ' + DateTime.now().toString());
      print("\n");
    } else {
      print("|data = 请求错误 E409");
      print('|返回时间: ' + DateTime.now().toString());
      print("\n");
    }
  }

  @override
  onError(
    DioError e,
    ErrorInterceptorHandler handler,
  ) {
    super.onError(e, handler);
    print("\n================== 错误响应数据 ======================");
    print("|type = ${e.type}");
    print("|message = ${e.message}");

    print('|response = ${e.response}');
    print("\n");
  }
}
