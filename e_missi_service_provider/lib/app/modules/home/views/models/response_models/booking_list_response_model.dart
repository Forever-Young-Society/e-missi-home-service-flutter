

import 'package:e_missi_service_provider/app/data/repository/links_meta.dart';
import 'package:e_missi_service_provider/app/modules/home/views/models/data_models/booking_detail_data_mode.dart';

class BookingListResponseModel {
  List<BookingDetailDataModel>? list;
  Links ?lLinks;
  Meta? mMeta;
  String? copyrighths;

  BookingListResponseModel(
      {this.list, this.lLinks, this.mMeta, this.copyrighths});

  BookingListResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <BookingDetailDataModel>[];
      json['list'].forEach((v) {
        list!.add(new BookingDetailDataModel.fromJson(v));
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