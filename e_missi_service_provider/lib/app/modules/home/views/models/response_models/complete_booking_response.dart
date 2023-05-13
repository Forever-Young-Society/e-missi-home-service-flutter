import 'package:e_missi_service_provider/app/modules/home/views/models/data_models/service_report_data_model.dart';

class CompleteBookingResponseModel {
  ServiceReportDataModel? detail;
  String? message;
  String? copyrighths;

  CompleteBookingResponseModel({this.detail, this.message, this.copyrighths});

  CompleteBookingResponseModel.fromJson(Map<String, dynamic> json) {
    detail =
    json['detail'] != null ? new ServiceReportDataModel.fromJson(json['detail']) : null;
    message = json['message'];
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detail != null) {
      data['detail'] = this.detail!.toJson();
    }
    data['message'] = this.message;
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}