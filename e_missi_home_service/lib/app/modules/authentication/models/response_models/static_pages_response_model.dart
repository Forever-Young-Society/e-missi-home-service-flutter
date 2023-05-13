class StaticPagesResponseModel {
  StaticPagesDataModel? detail;
  var copyrighths;

  StaticPagesResponseModel({this.detail, this.copyrighths});

  StaticPagesResponseModel.fromJson(Map<String, dynamic> json) {
    detail = json['detail'] != null
        ? new StaticPagesDataModel.fromJson(json['detail'])
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

class StaticPagesDataModel {
  var id;
  var title;
  var url;
  var description;
  var stateId;
  var createdOn;
  var createdById;

  StaticPagesDataModel(
      {this.id,
      this.title,
      this.url,
      this.description,
      this.stateId,
      this.createdOn,
      this.createdById});

  StaticPagesDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    description = json['description'];
    stateId = json['state_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['description'] = this.description;
    data['state_id'] = this.stateId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    return data;
  }
}
