import 'dart:convert';

class Utils {

  static String getImgPath(String name, {String format: 'png'}) {

    return 'assets/images/$name.$format';
  }
  static T getListObjByKey<T>( List<T> list, String key, String target) {
    T obj = list.firstWhere((item) {
      return json.decode(item.toString())[key] == target;
    });
    return obj;
  }
}
