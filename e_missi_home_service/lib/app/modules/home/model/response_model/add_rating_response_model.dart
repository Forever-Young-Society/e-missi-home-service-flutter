import 'package:e_missi_home_service/app/modules/authentication/models/data_model/login_data_model.dart';

class AddRatingResponseModel {
  LoginDataModel? detail;
  String? message;
  String? copyrighths;

  AddRatingResponseModel({this.detail, this.message, this.copyrighths});

  AddRatingResponseModel.fromJson(Map<String, dynamic> json) {
    detail = json['detail'] != null
        ? new LoginDataModel.fromJson(json['detail'])
        : null;
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
