class HomeServicesTermsDataModel {
  var id;
  var title;
  var description;
  var categoryId;
  var typeId;
  var stateId;
  var createdOn;
  var createdById;

  HomeServicesTermsDataModel(
      {this.id,
      this.title,
      this.description,
      this.categoryId,
      this.typeId,
      this.stateId,
      this.createdOn,
      this.createdById});

  HomeServicesTermsDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    categoryId = json['category_id'];
    typeId = json['type_id'];
    stateId = json['state_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    data['type_id'] = this.typeId;
    data['state_id'] = this.stateId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    return data;
  }
}
