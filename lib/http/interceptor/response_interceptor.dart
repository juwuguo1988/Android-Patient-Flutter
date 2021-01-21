import 'package:dio/dio.dart';
/*
 * 描述:
 * 创建者: wuxiaobo
 * 邮箱: wuxiaobo@xinzhili.cn
 * 日期: 2020/3/24 14:11
 */

class ResultData {
  var data;
  bool isSuccess;
  int code;
  var headers;

  ResultData(this.data, this.isSuccess, this.code, {this.headers});
}

class ResponseInterceptor extends InterceptorsWrapper{

  @override
  onResponse(Response response) async {
    RequestOptions option = response.request;
    try {

      if (option.contentType != null && option.contentType.contains("text")) {
        return new ResultData(response.data, true, 200);
      }

      ///一般只需要处理200的情况，300、400、500保留错误信息，外层为http协议定义的响应码
      if (response.statusCode == 200 || response.statusCode == 201) {
        ///内层需要根据公司实际返回结构解析，一般会有code，data，msg字段
        int code = response.data["code"];
        if (code == 0) {
          return new ResultData(response.data, true, 200,
              headers: response.headers);
        } else {
          return new ResultData(response.data, false, 200,
              headers: response.headers);
        }
      }
    } catch (e) {
      print(e.toString() + option.path);

      return new ResultData(response.data, false, response.statusCode,
          headers: response.headers);
    }

    return new ResultData(response.data, false, response.statusCode,
        headers: response.headers);
  }
}