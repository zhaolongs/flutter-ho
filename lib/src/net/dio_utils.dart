import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import 'log_interceptor.dart';

export 'http_helper.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/11/10.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class DioUtils {
  Dio _dio;
  // 工厂模式
  factory DioUtils() => _getInstance();
  static DioUtils get instance => _getInstance();
  static DioUtils _instance;

  //配置代理标识 false 不配置
  bool isProxy = false;
  //网络代理地址
  String proxyIp = "192.168.0.107";
  //网络代理端口
  String proxyPort = "8888";

  DioUtils._internal() {
    BaseOptions options = new BaseOptions();
    //请求时间
    options.connectTimeout = 20000;
    options.receiveTimeout = 2 * 60 * 1000;
    options.sendTimeout = 2 * 60 * 1000;
    // 初始化
    _dio = new Dio(options);
    //当App运行在Release环境时，inProduction为true；
    // 当App运行在Debug和Profile环境时，inProduction为false。
    bool inProduction = bool.fromEnvironment("dart.vm.product");
    if (!inProduction) {
      debugFunction();
    }
  }

  static DioUtils _getInstance() {
    if (_instance == null) {
      _instance = new DioUtils._internal();
    }
    return _instance;
  }

  void debugFunction() {
    // 添加log
    _dio.interceptors.add(LogsInterceptors());
    //配置代理
    if (isProxy) {
      _setupPROXY();
    }
  }

  /// 配置代理
  void _setupPROXY() {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        //proxyIp 地址  proxyPort 端口
        return 'PROXY $proxyIp : $proxyPort';
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        //忽略证书
        return true;
      };
    };
  }


  /// get 请求
  ///[url]请求链接
  ///[queryParameters]请求参数
  ///[cancelTag] 取消网络请求的标识
  Future<ResponseInfo> getRequest(
      {@required String url,
      Map<String, dynamic> queryParameters,
      CancelToken cancelTag}) async {
    //发起get请求
    try {
      _dio.options = await buildOptions(_dio.options);
      _dio.options.headers["content-type"]="application/json";
      Response response = await _dio.get(url,
          queryParameters: queryParameters, cancelToken: cancelTag);
      //响应数据
      dynamic responseData = response.data;
      //数据解析
      if (responseData is Map<String, dynamic>) {
        //转换
        Map<String, dynamic> responseMap = responseData;
        //
        int code = responseMap["code"];
        if (code == 200) {
          //业务代码处理正常
          //获取数据
          dynamic data = responseMap["data"];
          return ResponseInfo(data: data);
        } else {
          //业务代码异常
          return ResponseInfo.error(code: responseMap["code"],message:  responseMap["message"]);
        }
      }
    } catch (e, s) {
      //异常
      return errorController(e, s);
    }
  }

  /// post 请求
  ///[url]请求链接
  ///[formDataMap]formData 请求参数
  ///[jsonMap] JSON 格式
  Future<ResponseInfo> postRequest(
      {@required String url,
      Map<String, dynamic> formDataMap,
      Map<String, dynamic> jsonMap,
      CancelToken cancelTag}) async {
    FormData form;
    if (formDataMap != null) {
      form = FormData.fromMap(formDataMap);
    }

    _dio.options = await buildOptions(_dio.options);
    // _dio.options.headers["content-type"]="multipart/form-data";
    //发起post请求
    try {
      Response response = await _dio.post(url,
          data: form == null ? jsonMap : form,
          cancelToken: cancelTag);
      //响应数据
      dynamic responseData = response.data;
      if (responseData is Map<String, dynamic>) {
        Map<String, dynamic> responseMap = responseData;
        int code = responseMap["code"];
        if (code == 200) {
          //业务代码处理正常
          //获取数据
          dynamic data = responseMap["data"];
          return ResponseInfo(data: data);
        } else {
          //业务代码异常
          return ResponseInfo.error(
              code: responseMap["code"],
              message:responseMap["message"]);
        }
      }
    } catch (e, s) {
      return errorController(e, s);
    }
  }

  Future<ResponseInfo> errorController(e, StackTrace s) {
    ResponseInfo responseInfo = ResponseInfo();
    responseInfo.success = false;

    //网络处理错误
    if (e is DioError) {
      DioError dioError = e;
      switch (dioError.type) {
        case DioErrorType.CONNECT_TIMEOUT:
          responseInfo.message = "连接超时";
          break;
        case DioErrorType.SEND_TIMEOUT:
          responseInfo.message = "请求超时";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          responseInfo.message = "响应超时";
          break;
        case DioErrorType.RESPONSE:
          // 响应错误
          responseInfo.message = "响应错误";
          break;
        case DioErrorType.CANCEL:
          // 取消操作
          responseInfo.message = "已取消";
          break;
        case DioErrorType.DEFAULT:
          // 默认自定义其他异常
          responseInfo.message = "网络请求异常";
          break;
      }
    } else {
      //其他错误
      responseInfo.message = "未知错误";
    }
    responseInfo.success=false;
    return Future.value(responseInfo);
  }

  Future<BaseOptions> buildOptions(BaseOptions options) async {
    ///请求header的配置
    options.headers["productId"]=Platform.isAndroid?"Android":"IOS";
    options.headers["application"]="coalx";

    //获取当前App的版本信息
    PackageInfo   packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    options.headers["appVersion"]="$version";

    return Future.value(options);
  }
}

class ResponseInfo {
  bool success;
  int code;
  String message;
  dynamic data;

  ResponseInfo(
      {this.success = true,
        this.code = 200,
        this.data,
        this.message = "请求成功"});

  ResponseInfo.error(
      {this.success = false,
        this.code = 201,
        this.message = "请求异常"});
}
