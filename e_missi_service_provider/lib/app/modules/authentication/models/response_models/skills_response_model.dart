import 'package:e_missi_service_provider/app/modules/authentication/models/data_model/skills_data_model.dart';

class SkillSetResponseModel {
  List<SkillDataModel>? list;
  String? copyrighths;

  SkillSetResponseModel({this.list, this.copyrighths});

  SkillSetResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <SkillDataModel>[];
      json['list'].forEach((v) {
        list!.add(new SkillDataModel.fromJson(v));
      });
    }
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}
