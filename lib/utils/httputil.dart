//import 'package:dio/dio.dart';
//import 'dart:io';
//import 'dart:convert';
//import 'package:pda_pick_app/common/api.dart';
import 'package:http/http.dart' as http;
//
//  class HttpUtil {
//    static HttpUtil instance;
//    Dio dio;
//    BaseOptions options;
//
//    CancelToken cancelToken = new CancelToken();
//
//    static HttpUtil getInstance() {
//    if (null == instance) instance = new HttpUtil();
//    return instance;
//    }
//
//    /*
//   * config it and create
//   */
//    HttpUtil() {
//    //BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
//    options = new BaseOptions(
//    //请求基地址,可以包含子路径
//    baseUrl: Api.BASE_URL,
//    //连接服务器超时时间，单位是毫秒.
//    connectTimeout: 15000,
//    //响应流上前后两次接受到数据的间隔，单位为毫秒。
//    receiveTimeout: 5000,
//    //Http请求头.
//    headers: {
//    //do something
//    "version": "1.0.0"
//    },
//    //请求的Content-Type，默认值是[ContentType.json]. 也可以用ContentType.parse("application/x-www-form-urlencoded")
//    contentType: ContentType.json,
//    //表示期望以那种格式(方式)接受响应数据。接受三种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
//    responseType: ResponseType.plain,
//    );
//
//    dio = new Dio(options);
//
//    //添加拦截器
//    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
//    print("请求之前");
//    print(options.headers);
//    print(options.contentType);
//    // Do something before request is sent
//    return options; //continue
//    }, onResponse: (Response response) {
//    print("响应之前");
//    // Do something with response data
//    return response; // continue
//    }, onError: (DioError e) {
//    print("错误之前");
//    // Do something with response error
//    return e; //continue
//    }));
//    }
//
//    /*
//   * get请求
//   */
//    get(url, {data, options, cancelToken}) async {
//      print('get请求启动! url：$url ,queryParameters: $data');
//      Response response;
//      try {
//        response = await dio.get(
//          url,
//          queryParameters: data,
//          options: options,
//          cancelToken: cancelToken,
//        );
//        print('get success---------${response.statusCode}');
//        print('get请求成功!response.data：${response.data}');
//      } on DioError catch (e) {
//        if (CancelToken.isCancel(e)) {
//          print('get请求取消! ' + e.message);
//        }
//        print('get请求发生错误：$e');
//      }
//      return response.data;
//    }
//
//    post(url, {data, options, cancelToken}) async {
//      print('post请求启动! url：$url ,queryParameters: $data');
//
//      Response response;
//      try {
//        response = await dio.post(
//          url,
//          queryParameters: data,
//          options: options,
//          cancelToken: cancelToken,
//        );
//      Map<String, dynamic> dataMap =json.decode(response.data);
//        print('post请求成功!response.data：${response.data}');
//        print(dataMap);
//      } on DioError catch (e) {
//        if (CancelToken.isCancel(e)) {
//          print('post请求取消! ' + e.message);
//        }
//        print('post请求发生错误：$e');
//      }
//      return response.data;
//    }
//
//
//  /**
//   * 异常处理
//   */
//    void formatError(DioError e) {
//      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
//        // It occurs when url is opened timeout.
//        print("连接超时");
//      } else if (e.type == DioErrorType.SEND_TIMEOUT) {
//        // It occurs when url is sent timeout.
//        print("请求超时");
//      } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
//        //It occurs when receiving timeout
//        print("响应超时");
//      } else if (e.type == DioErrorType.RESPONSE) {
//        // When the server response, but with a incorrect status, such as 404, 503...
//        print("出现异常");
//      } else if (e.type == DioErrorType.CANCEL) {
//        // When the request is cancelled, dio will throw a error with this type.
//        print("请求取消");
//      } else {
//        //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
//        print("未知错误");
//      }
//    }
//}


class HttpController {
  static void get(String url, Function callback,
      {Map<String, String> params, Function errorCallback}) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    try {
      http.Response res = await http.get(url);
      if (callback != null) {
        callback(res.body);
      }
    } catch (exception) {
      if (errorCallback != null) {
        errorCallback(exception);
      }
    }
  }

  static void post(String url, Function callback,
      {Map<String, String> params, Function errorCallback}) async {
    try {
      http.Response res = await http.post(url, body: params);

      if (callback != null) {
        callback(res.body);
      }
    } catch (e) {
      if (errorCallback != null) {
        errorCallback(e);
      }
    }
  }
}
