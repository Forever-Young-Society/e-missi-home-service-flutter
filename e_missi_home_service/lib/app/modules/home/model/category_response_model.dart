import 'package:e_missi_home_service/model/links_meta.dart';

import 'data_model/category_data_model.dart';

class CategoryListResponse {
  List<CategoryDataModel>? list;
  Meta? mMeta;
  String? copyrighths;

  CategoryListResponse({this.list, this.mMeta, this.copyrighths});

  CategoryListResponse.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <CategoryDataModel>[];
      json['list'].forEach((v) {
        list!.add(new CategoryDataModel.fromJson(v));
      });
    }
    mMeta = json['_meta'] != null ? new Meta.fromJson(json['_meta']) : null;
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    if (this.mMeta != null) {
      data['_meta'] = this.mMeta!.toJson();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}
