class AddRatingDataModel {
  var id;
  var modelId;
  var rating;
  var comment;
  var stateId;
  var createdOn;
  var createdById;
  var providerId;
  var userName;
  var userImage;

  AddRatingDataModel(
      {this.id,
      this.modelId,
      this.rating,
      this.comment,
      this.stateId,
      this.createdOn,
      this.createdById,
      this.providerId,
      this.userName,
      this.userImage});

  AddRatingDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelId = json['model_id'];
    rating = json['rating'];
    comment = json['comment'];
    stateId = json['state_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
    providerId = json['provider_id'];
    userName = json['user_name'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model_id'] = this.modelId;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['state_id'] = this.stateId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    data['provider_id'] = this.providerId;
    data['user_name'] = this.userName;
    data['user_image'] = this.userImage;
    return data;
  }
}
