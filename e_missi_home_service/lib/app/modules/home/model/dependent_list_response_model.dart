import 'package:e_missi_home_service/model/links_meta.dart';

import 'data_model/dependent_list_data_model.dart';

class DependentListResponseModel {
  List<DependentListDataModel>? list;
  Links? lLinks;
  Meta? mMeta;
  var copyrighths;

  DependentListResponseModel(
      {this.list, this.lLinks, this.mMeta, this.copyrighths});

  DependentListResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <DependentListDataModel>[];
      json['list'].forEach((v) {
        list!.add(new DependentListDataModel.fromJson(v));
      });
    }
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
    mMeta = json['_meta'] != null ? new Meta.fromJson(json['_meta']) : null;
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    if (this.lLinks != null) {
      data['_links'] = this.lLinks!.toJson();
    }
    if (this.mMeta != null) {
      data['_meta'] = this.mMeta!.toJson();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}
