class ServiceReportDataModel {
  int? id;
  String? userName;
  String? icNumber;
  int? gender;
  String? bookingDate;
  String? bookingTime;
  String? zipcode;
  String? city;
  String? state;
  String? address;
  String? serviceProvided;
  String? description;
  int? age;
  int? bookingId;
  int? serviceId;
  int? userId;
  int? dependantId;
  int? stateId;
  int? typeId;
  String? createdOn;
  String? email;
  String? providerName;
  int? createdById;

  ServiceReportDataModel(
      {this.id,
      this.userName,
      this.icNumber,
      this.gender,
      this.bookingDate,
      this.bookingTime,
      this.zipcode,
      this.city,
      this.state,
      this.address,
      this.serviceProvided,
      this.description,
      this.age,
      this.bookingId,
      this.serviceId,
      this.userId,
      this.dependantId,
      this.stateId,
      this.email,
      this.typeId,
      this.createdOn,
      this.providerName,
      this.createdById});

  ServiceReportDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    icNumber = json['ic_number'];
    gender = json['gender'];
    bookingDate = json['booking_date'];
    bookingTime = json['booking_time'];
    zipcode = json['zipcode'];
    city = json['city'];
    state = json['state'];
    address = json['address'];
    email = json['email'];
    serviceProvided = json['service_provided'];
    description = json['description'];
    age = json['age'];
    bookingId = json['booking_id'];
    serviceId = json['service_id'];
    userId = json['user_id'];
    dependantId = json['dependant_id'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    providerName = json['provider_name'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['ic_number'] = this.icNumber;
    data['gender'] = this.gender;
    data['booking_date'] = this.bookingDate;
    data['booking_time'] = this.bookingTime;
    data['zipcode'] = this.zipcode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['address'] = this.address;
    data['service_provided'] = this.serviceProvided;
    data['description'] = this.description;
    data['age'] = this.age;
    data['email'] = this.email;
    data['booking_id'] = this.bookingId;
    data['service_id'] = this.serviceId;
    data['user_id'] = this.userId;
    data['dependant_id'] = this.dependantId;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['provider_name'] = this.providerName;
    data['created_by_id'] = this.createdById;
    return data;
  }
}
