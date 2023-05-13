import 'package:e_missi_home_service/app/modules/appointment_module/models/data_model/booking_detail_data_mode.dart';

class BookingDetailResponseModel {
  BookingDetailDataModel? detail;
  String? copyrighths;

  BookingDetailResponseModel({this.detail, this.copyrighths});

  BookingDetailResponseModel.fromJson(Map<String, dynamic> json) {
    detail =
    json['detail'] != null ? new BookingDetailDataModel.fromJson(json['detail']) : null;
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detail != null) {
      data['detail'] = this.detail!.toJson();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}