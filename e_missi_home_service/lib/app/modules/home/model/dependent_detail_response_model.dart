import 'data_model/dependent_detail_data_model.dart';

class DependentDetailResponseModel {
  DependentDetailDataModel? detail;
  var copyrighths;
  String? message;

  DependentDetailResponseModel({this.detail, this.copyrighths});

  DependentDetailResponseModel.fromJson(Map<String, dynamic> json) {
    detail = json['detail'] != null
        ? new DependentDetailDataModel.fromJson(json['detail'])
        : null;
    copyrighths = json['copyrighths'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detail != null) {
      data['detail'] = this.detail!.toJson();
    }
    data['copyrighths'] = this.copyrighths;
    data['message'] = message;
    return data;
  }
}
