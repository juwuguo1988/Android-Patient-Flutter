/*
 * 描述:
 * 创建者: wuxiaobo
 * 邮箱: wuxiaobo@xinzhili.cn
 * 日期: 2020/3/23 15:53
 */
import 'package:patient/utils/entity_factory.dart';

class BaseEntity<T>{
  String status;//注意当status为success和fail时，都是在请求响应成功的回调中
  String result;//
  T data;

  BaseEntity({this.status, this.result, this.data});

  factory BaseEntity.fromJson(json) {
    return BaseEntity(
      status: json["status"],
      result: json["result"],
      // data值需要经过工厂转换为我们传进来的类型
      data: EntityFactory.generateOBJ<T>(json["data"]),
    );
  }
}