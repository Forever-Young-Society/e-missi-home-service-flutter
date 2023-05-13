
import 'package:e_missi_home_service/export.dart';

class BookingDetailDataModel {
 var id;
 var orderId;
  var startTime;
  var endTime;
 var providerId;
 var dependantId;
 var serviceId;
 var serviceName;
  var slotId;
 var stateId;
 var typeId;
  var createdOn;
 var createdById;
 var paymentStatus;
  LoginDataModel? providerDetail;
  LoginDataModel? patientDetail;
  SubCategoryDataModel? skillDetail;
 var userReschedule;
 var skillName;
 var isRating;

 BookingDetailDataModel(
      {this.id,
        this.startTime,
        this.endTime,
        this.providerId,
        this.dependantId,
        this.serviceId,
        this.serviceName,
        this.slotId,
        this.stateId,
        this.typeId,
        this.createdOn,
        this.orderId,
        this.createdById,
        this.providerDetail,
        this.patientDetail,
        this.skillDetail,
        this.paymentStatus,
        this.userReschedule,
        this.skillName ,
        this.isRating ,

      });

 BookingDetailDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    providerId = json['provider_id'];
    dependantId = json['dependant_id'];
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    slotId = json['slot_id'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    orderId = json['order_id'];
    createdById = json['created_by_id'];
    skillName = json['skill_name'];
    isRating = json['is_rating'];
    providerDetail = json['provider_detail'] != null
        ? new LoginDataModel.fromJson(json['provider_detail'])
        : null;
    patientDetail = json['patient_detail'] != null
        ? new LoginDataModel.fromJson(json['patient_detail'])
        : null;
    skillDetail = json['skill_detail'] != null
        ? new SubCategoryDataModel.fromJson(json['skill_detail'])
        : null;
    userReschedule=json['user_reschedule'];
    paymentStatus=json['payment_status'];

 }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['provider_id'] = this.providerId;
    data['dependant_id'] = this.dependantId;
    data['service_id'] = this.serviceId;
    data['service_name'] = this.serviceName;
    data['order_id'] = this.orderId;
    data['slot_id'] = this.slotId;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['is_rating'] = this.isRating;
    data['created_by_id'] = this.createdById;
    data['payment_status'] = this.paymentStatus;
    if (this.providerDetail != null) {
      data['provider_detail'] = this.providerDetail!.toJson();
    }
    if (this.patientDetail != null) {
      data['patient_detail'] = this.patientDetail!.toJson();
    }
    if (this.skillDetail != null) {
      data['skill_detail'] = this.skillDetail!.toJson();
    }
    data['user_reschedule'] = this.userReschedule;
    data['skill_name'] = this.skillName;

    return data;
  }
}