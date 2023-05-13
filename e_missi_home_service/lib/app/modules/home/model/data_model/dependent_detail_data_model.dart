class DependentDetailDataModel {
  var id;
  var fullName;
  var email;
  var dateOfBirth;
  var identityNumber;
  var age;
  var gender;
  var aboutMe;
  var contactNo;
  var address;
  var latitude;
  var longitude;
  var city;
  var country;
  var zipcode;
  var language;
  var roleId;
  var stateId;
  var typeId;
  var step;
  var lastActionTime;
  var timezone;
  var createdOn;
  var createdById;
  var otp;
  var otpVerified;
  var isNotify;
  var otpAttempt;
  var medicalReport;
  var profileFile;

  DependentDetailDataModel(
      {this.id,
      this.fullName,
      this.email,
      this.dateOfBirth,
      this.identityNumber,
      this.gender,
      this.aboutMe,
      this.contactNo,
      this.address,
      this.age,
      this.latitude,
      this.longitude,
      this.city,
      this.country,
      this.zipcode,
      this.language,
      this.roleId,
      this.stateId,
      this.typeId,
      this.step,
      this.lastActionTime,
      this.timezone,
      this.createdOn,
      this.createdById,
      this.otp,
      this.otpVerified,
      this.isNotify,
      this.otpAttempt,
      this.medicalReport,
      this.profileFile});

  DependentDetailDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    age = json['age'];
    identityNumber = json['identity_number'];
    gender = json['gender'];
    aboutMe = json['about_me'];
    contactNo = json['contact_no'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    city = json['city'];
    country = json['country'];
    zipcode = json['zipcode'];
    language = json['language'];
    roleId = json['role_id'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    step = json['step'];
    lastActionTime = json['last_action_time'];
    timezone = json['timezone'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
    otp = json['otp'];
    otpVerified = json['otp_verified'];
    isNotify = json['is_notify'];
    otpAttempt = json['otp_attempt'];
    medicalReport = json['medical_report'];
    profileFile = json['profile_file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['date_of_birth'] = this.dateOfBirth;
    data['identity_number'] = this.identityNumber;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['about_me'] = this.aboutMe;
    data['contact_no'] = this.contactNo;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['city'] = this.city;
    data['country'] = this.country;
    data['zipcode'] = this.zipcode;
    data['language'] = this.language;
    data['role_id'] = this.roleId;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['step'] = this.step;
    data['last_action_time'] = this.lastActionTime;
    data['timezone'] = this.timezone;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    data['otp'] = this.otp;
    data['otp_verified'] = this.otpVerified;
    data['is_notify'] = this.isNotify;
    data['otp_attempt'] = this.otpAttempt;
    data['medical_report'] = this.medicalReport;
    data['profile_file'] = this.profileFile;
    return data;
  }
}
