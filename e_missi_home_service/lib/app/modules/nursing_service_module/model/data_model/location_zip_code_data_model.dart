class LocationZipCodeDataModel {
  var id;
  var title;
  var postCode;
  var locationId;
  var typeId;
  var stateId;

  LocationZipCodeDataModel(
      {this.id,
      this.title,
      this.postCode,
      this.locationId,
      this.typeId,
      this.stateId});

  LocationZipCodeDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    postCode = json['post_code'];
    locationId = json['location_id'];
    typeId = json['type_id'];
    stateId = json['state_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['post_code'] = this.postCode;
    data['location_id'] = this.locationId;
    data['type_id'] = this.typeId;
    data['state_id'] = this.stateId;
    return data;
  }
}
