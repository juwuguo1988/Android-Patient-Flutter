import 'package:patient/utils/array_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("测试Array_Util方法", () {
    List<int> int_list;

    setUpAll(() {
      int_list = [1,2,4,5,5,7,8,99];
    });
    tearDownAll(() {
      int_list = null;
    });

    test("获取最小值", () {
      int min = ArrayUtil.getArrMinNum(int_list);
      expect(min, 1);
    });
    test("获取最大值", () {
      int max = ArrayUtil.getArrMaxNum(int_list);
      expect(max, 99);
    });
  });
}