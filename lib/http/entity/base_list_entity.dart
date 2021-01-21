import 'package:patient/utils/entity_factory.dart';
/*
 * 描述:
 * 创建者: wuxiaobo
 * 邮箱: wuxiaobo@xinzhili.cn
 * 日期: 2020/3/26 11:21
 */
class BaseListEntity<T> {
  String status;
  String result;
  List<T> data;

  BaseListEntity({this.status, this.result, this.data});

  factory BaseListEntity.fromJson(json) {
    List<T> mData = List();
    if (json['data'] != null) {
      //遍历data并转换为我们传进来的类型
      (json['data'] as List).forEach((v) {
        mData.add(EntityFactory.generateOBJ<T>(v));
      });
    }

    return BaseListEntity(
      status: json["status"],
      result: json["result"],
      data: mData,
    );
  }
}