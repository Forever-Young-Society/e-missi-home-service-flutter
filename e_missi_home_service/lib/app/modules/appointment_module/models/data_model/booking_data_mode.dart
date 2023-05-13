
class BookingDataModel {
 var id;
var startTime;
var endTime;
var providerId;
var dependantId;
var serviceId;
var slotId;
 var stateId;
var typeId;
var createdOn;
 var createdById;

  BookingDataModel(
      {this.id,
        this.startTime,
        this.endTime,
        this.providerId,
        this.dependantId,
        this.serviceId,
        this.slotId,
        this.stateId,
        this.typeId,
        this.createdOn,
        this.createdById});

  BookingDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    providerId = json['provider_id'];
    dependantId = json['dependant_id'];
    serviceId = json['service_id'];
    slotId = json['slot_id'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['provider_id'] = this.providerId;
    data['dependant_id'] = this.dependantId;
    data['service_id'] = this.serviceId;
    data['slot_id'] = this.slotId;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    return data;
  }
}
