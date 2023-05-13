import '../data_model/home_services_terms_data_model.dart';

class HomeServicesTermsResponseModel {
  HomeServicesTermsDataModel? detail;
  var copyrighths;

  HomeServicesTermsResponseModel({this.detail, this.copyrighths});

  HomeServicesTermsResponseModel.fromJson(Map<String, dynamic> json) {
    detail = json['detail'] != null
        ? new HomeServicesTermsDataModel.fromJson(json['detail'])
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
