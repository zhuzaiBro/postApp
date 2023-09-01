

import 'package:flutter/cupertino.dart';

class BaseData<T> {

  List<T>? list = [];
  int? total = 0;

  int? page = 0;
  int? size = 5;
  bool? isMore = true;

  BaseData();

  reSetPage() {
    isMore = true;
    page = 0;
  }

  handleData(List<T> newList, int num) {

    /// 判断自身的page字段
    ///
    debugPrint("page${page}, length${newList.length}size$size");
    if(page == 0) {
      list = newList;
    } else if (page! > 0) {
      list!.addAll(newList);
    }
    if(newList.length < size!) {
      /// 数据请求完了
      debugPrint("数据请求完了");
      isMore = false;
    }
    total = num;
    page = page! + 1;
  }

  bool beforeQuery() {
    if(!isMore!) {
      return false;
    }
    return true;
  }
}