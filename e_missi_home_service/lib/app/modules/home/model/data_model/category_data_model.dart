class CategoryDataModel {
  var id;
  var title;
  var imageFile;
  var termAccepted;
  var stateId;
  var typeId;
  var createdOn;
  var createdById;
  bool? isSelected = false;

  CategoryDataModel(
      {this.id,
      this.title,
      this.imageFile,
      this.stateId,
      this.termAccepted,
      this.typeId,
      this.isSelected = false,
      this.createdOn,
      this.createdById});

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageFile = json['image_file'];
    termAccepted = json['term_accepted'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image_file'] = this.imageFile;
    data['state_id'] = this.stateId;
    data['term_accepted'] = this.termAccepted;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    return data;
  }
}
