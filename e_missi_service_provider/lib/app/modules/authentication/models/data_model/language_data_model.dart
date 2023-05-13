class LanguageDataModel {
  int? id;
  String? title;
  String? code;
  int? stateId;
  String? createdOn;
  int? typeId;
  int? createdById;
  bool? isSelected = false;

  LanguageDataModel(
      {this.id,
      this.title,
      this.code,
      this.stateId,
      this.createdOn,
      this.typeId,
      this.isSelected,
      this.createdById});

  LanguageDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    code = json['code'];
    stateId = json['state_id'];
    createdOn = json['created_on'];
    typeId = json['type_id'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['code'] = this.code;
    data['state_id'] = this.stateId;
    data['created_on'] = this.createdOn;
    data['type_id'] = this.typeId;
    data['created_by_id'] = this.createdById;
    return data;
  }
}
