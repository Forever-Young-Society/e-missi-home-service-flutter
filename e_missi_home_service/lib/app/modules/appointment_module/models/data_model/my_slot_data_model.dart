class MySlotsDataModel {
  int? id;
  String? startTime;
  String? endTime;
  bool? isSelected;
  bool? isBooked;
  var availabilitySlotId;
  var stateId;
  var typeId;
  var createdOn;
  var createdById;
  var slotShowtype;


  MySlotsDataModel(
      {this.id,
      this.startTime,
      this.endTime,
      this.isSelected,
      this.isBooked,
      this.availabilitySlotId,
      this.stateId,
      this.typeId,
      this.createdOn,
      this.slotShowtype,
      this.createdById});

  MySlotsDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    isSelected = json['is_selected'];
    isBooked = json['is_booked'];
    availabilitySlotId = json['availability_slot_id'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    slotShowtype = json['slot_show_type'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['is_selected'] = this.isSelected;
    data['is_booked'] = this.isBooked;
    data['availability_slot_id'] = this.availabilitySlotId;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['slot_show_type'] = this.slotShowtype;
    data['created_by_id'] = this.createdById;
    return data;
  }
}
