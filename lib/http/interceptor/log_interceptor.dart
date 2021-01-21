import 'package:dio/dio.dart';
/*
 * 描述:
 * 创建者: wuxiaobo
 * 邮箱: wuxiaobo@xinzhili.cn
 * 日期: 2020/3/24 14:11
 */

class LogInterceptors extends InterceptorsWrapper{

  @override
  Future onRequest(RequestOptions options) {
    print("================================= 请求数据 开始=================================");
    print("method = ${options.method.toString()}");
    print("url = ${options.uri.toString()}");
    print("headers = ${options.headers}");
    print("params = ${options.data}");
    print("Content-Type = ${options.contentType}");
    print("================================= 请求数据 结束=================================");
    return super.onRequest(options);
  }
}