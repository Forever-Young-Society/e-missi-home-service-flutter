import 'package:e_missi_home_service/app/modules/appointment_module/models/data_model/booking_detail_data_mode.dart';

class AddBookingResponseModel {
  BookingDetailDataModel? details;
  String? message;
  String? copyrighths;

  AddBookingResponseModel({this.details, this.message, this.copyrighths});

  AddBookingResponseModel.fromJson(Map<String, dynamic> json) {
    details =
    json['details'] != null ? new BookingDetailDataModel.fromJson(json['details']) : null;
    message = json['message'];
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    data['message'] = this.message;
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}
