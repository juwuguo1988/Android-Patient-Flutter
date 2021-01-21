import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:convert';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:patient/config/env.dart';
import 'package:flui/flui.dart';
// 是否生产环境
const isProd = bool.fromEnvironment('dart.vm.product');
String BASE_URL =
    isProd ? Configs.apiHost(Env.PROD) : Configs.apiHost(Env.TEST);

Map<String, dynamic> httpHeaders = {

 "Authorization":
   "bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI4bVpKbjUiLCJ1c2VyX25hbWUiOiIxODMxMDA5OTI3MSIsImF1dGhvcml0aWVzIjpbIlBBVElFTlRfUkVBRCIsIlBBVElFTlRfV1JJVEUiXSwianRpIjoiODc2ZDZmMjUtMzYxZC00Zjk4LTljNDMtMDY4NGQ3MjE3YmQzIiwiY2xpZW50X2lkIjoicGF0aWVudF9hcHAiLCJzY29wZSI6WyJQQVRJRU5UIl19.gwNwTECMwjiGj0uIUQBu6lIPan7ApJDRNbRJ_Qbh8RWzXRMosc4cv9WDEyQKze9UKrfjj6HNCSC4YUP6nYco3k2-8Mld_jSrY-_POWVZ8R5sRv0wXoF5SbZKTRQprS-OnjXkOPtcEcxDY6Pnsukdp0UQ3UXSL88a7ncoPbdquu4JC-Ksjs-krjbTkjQPvP3YaPhgeLB7l-RUIB2rD0lKW_PM8DS8c9QltWCBtGu_1ZdLZROmLbi4PElmtSr14PI7sozwt6fALQdkwG3l0aDiDEluYvmPEL1uid28AmdtSzuRPwdj8GzOERP4A0nD3yZa6HGuc3en96dtVH_8uRH7LQ",

//  "Authorization":
//      "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJsdmdEVjgiLCJ1c2VyX25hbWUiOiIxODUwNTM0OTg4MCIsImF1dGhvcml0aWVzIjpbIlBBVElFTlRfUkVBRCIsIlBBVElFTlRfV1JJVEUiXSwianRpIjoiNjI1YjA2NjItN2FkYS00ZWVhLWE2MTYtNDkxMTU0Y2JhZTU3IiwiY2xpZW50X2lkIjoicGF0aWVudF9hcHAiLCJzY29wZSI6WyJQQVRJRU5UIl19.SNEGMM7WEsVvw_RTlLl_2SU3zXubLwZVYMMkPvFB3kwEZFfOzxkQe623KSOGYnBakoZ2UyAfgptmIja64KsKd4u-EU7tcONtGo-WZtXbY-VbQNjXeiMmC6P-x5chpoQNk2FqEEvF4uuwXxmuwpqDksikF_6T2Y721aQab0wXnDWKP9G4y7Ekh8_UDDtXnlrCbfziJQ6cWEOrmVMm06wANzqpuzvzTX3SahICGr7uWPzuXrpZip-IitLf2QrZNhoeh048I82300R7UE7boZcfEJVX5LvzmCiyVB6ZBD0oDG4ky7bxvH22Fik6LvUekYXFKwSluBL1m4l0yLE7FBlYpA",

//线上
 // "Authorization":
   //   "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJySjNvVmwiLCJ1c2VyX25hbWUiOiIxNzcxMDE4OTQ2NiIsImF1dGhvcml0aWVzIjpbIlBBVElFTlRfUkVBRCIsIlBBVElFTlRfV1JJVEUiXSwianRpIjoiODFkMDQ1OTMtZDYwOC00MWYwLTgwNWEtOWM1YjU1ODAzNjA1IiwiY2xpZW50X2lkIjoicGF0aWVudF9hcHAiLCJzY29wZSI6WyJQQVRJRU5UIl19.FMofoi-B_JrtF7KGzxBtuYzhk9rz1DmIAPAjgVybHN3IqMqo27J-ERKsxyC1figYxodNp1biEuwG8cf68r4uo1scb8rnkM8T-CkjV-m8SyxfAkRFk8x7aqz6SnW2KBmI-VwIUVjK5wXouKfdT1ZVmU3A-vT-Q8HNUcEpUvKRjBErcQcQnqbZyosDweKNvj7krsAdvd3orwsI7AEO5hBSGhAnOsKSVg_To8ZJSRVTwuLh0b7enoOe6TDme8Bjc4gQG2-A-8v4m_vbZJ8Vvtb4SFIXL7pIW2lakn93WjbnXL9dbjlSsX7AawUKUFOFPxX66RAZ1PF5mjcCeigRTXBUBQ",
};

class HttpUtil {
  static HttpUtil instance;
  Dio dio;
  BaseOptions options;

  CancelToken cancelToken = CancelToken();

  static HttpUtil getInstance() {
    if (null == instance) instance = HttpUtil();
    return instance;
  }

  /*
   * config it and create
   */
  HttpUtil() {
    //BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    options = BaseOptions(
      //请求基地址,可以包含子路径
      baseUrl: BASE_URL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10 * 1000,
      //响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 10 * 1000,
      //Http请求头.
      headers: httpHeaders,
      //请求的Content-Type，默认值是[ContentType.json].
      /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
      /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
      /// 就会自动编码请求体.
      // contentType: Headers.formUrlEncodedContentType,
      //表示期望以那种格式(方式)接受响应数据。接受四种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      responseType: ResponseType.json,
    );

    dio = Dio(options);

    //添加拦截器
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      print(
          "================================= 请求数据 开始=================================");
      print("method = ${options.method.toString()}");
      print("url = ${options.uri.toString()}");
      print("headers = ${options.headers}");
      print("params = ${options.data}");
      print("Content-Type = ${options.contentType}");
      print(
          "================================= 请求数据 结束=================================");
      // Do something before request is sent
      return options; //continue
    }, onResponse: (Response response) {
      print("响应之前");
      print(response.toString());
      return response; // continue
    }, onError: (DioError e) {
      print("错误之前");
      // Do something with response error
      return e; //continue
    }));
  }

  /*
   * get请求
   */
  get(url, {data, options, cancelToken}) async {
    Response response;
    //Cookie管理
    // 改为使用 PersistCookieJar，PersistCookieJar将cookie保留在文件中，
    // 因此，如果应用程序退出，则cookie始终存在，除非显式调用delete
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    var dir = new Directory("$documentsPath/cookies");
    await dir.create();
    dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));
    try {
      response = await dio.get(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
      return response;
    } on DioError catch (e) {
      print('get error---------$e');
      formatError(e);
      return Future.error(e);
    }
  }

  /*
   * post请求
   */
  post(url, {data, options, cancelToken}) async {
    Response response;
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    var dir = new Directory("$documentsPath/cookies");
    await dir.create();
    dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));
    try {
      response = await dio.post(url,
          data: data, options: options, cancelToken: cancelToken);
      // print('post success---------${response.data}');
      return response;
    } on DioError catch (e) {
      print('post error---------$e');
      formatError(e);
      return Future.error(e);
    }
  }

  /*
   * 下载文件
   */
  downloadFile(urlPath, savePath) async {
    Response response;
    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        //进度
        print("$count $total");
      });
      print('downloadFile success---------${response.data}');
    } on DioError catch (e) {
      print('downloadFile error---------$e');
      formatError(e);
    }
    return response.data;
  }

  /*
   * error统一处理
   */
  void formatError(DioError e) {
    // print('error统一处理');
    String msg;
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      msg = '连接超时';
      print(msg);
      // return Future.error('连接超时');
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      msg = '请求超时';
      // throw '请求超时';
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      msg = '响应超时';
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      msg = json.decode(e.response.toString())['error_description'] ?? "服务异常";
      // return throw msg;
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      msg = '请求取消';
      // throw '请求取消';
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      msg = "未知错误";
    }
    print(msg);
    FLToast.error(text: msg);
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  void setHeader<T>(T token) {
    Map<String, dynamic> _headers = new Map();
    if (token is String) {
      httpHeaders["Authorization"] = 'Bearer $token';
      _headers["Authorization"] = 'Bearer $token';
      dio.options.headers.addAll(_headers);
    } else {
      httpHeaders["Authorization"] = '';
      _headers["Authorization"] = '';
      dio.options.headers.addAll(_headers);
    }
  }
}
