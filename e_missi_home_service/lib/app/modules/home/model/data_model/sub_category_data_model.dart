import 'package:e_missi_home_service/app/modules/home/model/data_model/sub_services_Data.dart';

class SubCategoryDataModel {
  var id;
  var title;
  var imageFile;
  var categoryId;
  var typeId;
  var stateId;
  var createdOn;
  var createdById;
  var userPrice;
  var providerPrice;
  var isSelected;
  List<SubServices>? subServices;

  SubCategoryDataModel(
      {this.id,
      this.title,
      this.imageFile,
      this.categoryId,
      this.typeId,
      this.stateId,
      this.createdOn,
      this.isSelected,
      this.userPrice,
      this.providerPrice,
      this.subServices,
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
    if (json['sub_services'] != null) {
      subServices = <SubServices>[];
      json['sub_services'].forEach((v) {
        subServices!.add(new SubServices.fromJson(v));
      });
    }
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
    if (this.subServices != null) {
      data['sub_services'] = this.subServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
