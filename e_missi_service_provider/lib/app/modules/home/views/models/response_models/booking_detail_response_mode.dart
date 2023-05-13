
import 'package:e_missi_service_provider/app/modules/home/views/models/data_models/booking_detail_data_mode.dart';

class BookingDetailResponseModel {
  BookingDetailDataModel? detail;
  String? copyrighths;
  String? message;

  BookingDetailResponseModel({this.detail, this.copyrighths,this.message});

  BookingDetailResponseModel.fromJson(Map<String, dynamic> json) {
    detail =
    json['detail'] != null ? new BookingDetailDataModel.fromJson(json['detail']) : null;
    copyrighths = json['copyrighths'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detail != null) {
      data['detail'] = this.detail!.toJson();
    }
    data['copyrighths'] = this.copyrighths;
    data['message'] = this.message;
    return data;
  }
}