class LocationListDataModel {
  var id;
  var title;
  var secondaryLocation;
  var typeId;
  var stateId;
  var createdOn;
  var createdById;

  LocationListDataModel(
      {this.id,
      this.title,
      this.secondaryLocation,
      this.typeId,
      this.stateId,
      this.createdOn,
      this.createdById});

  LocationListDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    secondaryLocation = json['secondary_location'];
    typeId = json['type_id'];
    stateId = json['state_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['secondary_location'] = this.secondaryLocation;
    data['type_id'] = this.typeId;
    data['state_id'] = this.stateId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    return data;
  }
}
