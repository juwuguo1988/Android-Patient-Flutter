import 'package:flutter/material.dart';

class ArrayUtil {
  static List<int> sortedNumArray(List<int> arr, { String type = 'asc' }) {
    arr.sort((int prev, int next) {
      if (type == 'asc') {
        return prev - next;
      } else {
        return next - prev;
      }
    });
    return arr;
  }

  static int getArrMinNum(List<int> arr) {
    return sortedNumArray(arr, type: "asc")[0];
  }

  static int getArrMaxNum(List<int> arr) {
    return sortedNumArray(arr, type: "desc")[0];
  }
}