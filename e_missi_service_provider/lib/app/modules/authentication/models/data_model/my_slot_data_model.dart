class MySlotsDataModel {
  int? id;
  String? startTime;
  String? endTime;
  bool? isSelected;

  MySlotsDataModel({this.id, this.startTime, this.endTime, this.isSelected});

  MySlotsDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    isSelected = json['is_selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['is_selected'] = this.isSelected;
    return data;
  }
}