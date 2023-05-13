class ProviderAvailabilityResponse {
  List<String>? availableList;
  List<String>? blockoutList;
  String? copyrighths;

  ProviderAvailabilityResponse(
      {this.availableList, this.blockoutList, this.copyrighths});

  ProviderAvailabilityResponse.fromJson(Map<String, dynamic> json) {
    availableList = json['available_list'].cast<String>();
    blockoutList = json['blockout_list'].cast<String>();
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available_list'] = this.availableList;
    data['blockout_list'] = this.blockoutList;
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}
