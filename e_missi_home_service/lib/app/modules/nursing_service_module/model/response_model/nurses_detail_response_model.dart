import 'package:e_missi_home_service/app/modules/authentication/models/data_model/login_data_model.dart';

class NursesServicesDetailResponseModel {
  LoginDataModel? detail;
  var copyrighths;

  NursesServicesDetailResponseModel({this.detail, this.copyrighths});

  NursesServicesDetailResponseModel.fromJson(Map<String, dynamic> json) {
    detail = json['detail'] != null
        ? new LoginDataModel.fromJson(json['detail'])
        : null;
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
