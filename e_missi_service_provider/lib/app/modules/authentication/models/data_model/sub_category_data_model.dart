class SubCategoryDataModel {
  var id;
  var title;
  var imageFile;
 var categoryId;
 var typeId;
 var stateId;
  var createdOn;
 var createdById;
  bool? isSelected = false;
  var userPrice;
  var providerPrice;
  SubCategoryDataModel(
      {this.id,
      this.title,
      this.imageFile,
      this.categoryId,
      this.typeId,
      this.stateId,
      this.createdOn,
        this.userPrice,
        this.providerPrice,
      this.isSelected = false,
      this.createdById});

  SubCategoryDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageFile = json['image_file'];
    categoryId = json['category_id'];
    typeId = json['type_id'];
    stateId = json['state_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
    providerPrice = json['provider_price'];
    userPrice = json['user_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image_file'] = this.imageFile;
    data['category_id'] = this.categoryId;
    data['type_id'] = this.typeId;
    data['state_id'] = this.stateId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    data['user_price'] = this.userPrice;
    data['provider_price'] = this.providerPrice;
    return data;
  }
}
