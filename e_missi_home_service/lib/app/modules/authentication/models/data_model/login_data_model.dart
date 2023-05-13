/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

class LoginDataModel {
  var id;
  var fullName;
  var identityNumber;
  var breifCondition;
  var email;
  var dateOfBirth;
  var gender;
  var countryCode;
  var contactNo;
  var otp;
  var otpAttempt;
  var isOtpVerify;
  var mobileOtp;
  var zipcode;
  var mobileOtpVerify;
  var address;
  var language;
  var profileFile;
  var tos;
  var roleId;
  var stateId;
  var typeId;
  var medicalReport;
  var step;
  var timezone;
  var createdOn;
  var skillTitle;
  var lastActionTime;
  var createdById;
  var workZoneTitle;
  var otpVerified;
  var isNotify;
  var experience;
  var rating;
  var languageTitle;
  var age;
  var qualificationTitle;
  var ratingCount;

  LoginDataModel({
    this.id,
    this.fullName,
    this.email,
    this.identityNumber,
    this.dateOfBirth,
    this.gender,
    this.countryCode,
    this.contactNo,
    this.otp,
    this.breifCondition,
    this.otpAttempt,
    this.isOtpVerify,
    this.mobileOtp,
    this.medicalReport,
    this.mobileOtpVerify,
    this.address,
    this.language,
    this.profileFile,
    this.tos,
    this.roleId,
    this.age,
    this.stateId,
    this.typeId,
    this.step,
    this.zipcode,
    this.timezone,
    this.createdOn,
    this.lastActionTime,
    this.createdById,
    this.otpVerified,
    this.experience,
    this.rating,
    this.isNotify,
    this.languageTitle,
    this.workZoneTitle,
    this.qualificationTitle,
    this.skillTitle,
    this.ratingCount,
  });

  LoginDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    countryCode = json['country_code'];
    contactNo = json['contact_no'];
    otp = json['otp'];
    medicalReport = json['medical_report'];
    breifCondition = json['about_me'];
    identityNumber = json['identity_number'];
    otpAttempt = json['otp_attempt'];
    isOtpVerify = json['is_otp_verify'];
    mobileOtp = json['mobile_otp'];
    zipcode = json['zipcode'];
    mobileOtpVerify = json['mobile_otp_verify'];
    address = json['address'];
    language = json['language'];
    profileFile = json['profile_file'];
    tos = json['tos'];
    roleId = json['role_id'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    step = json['step'];
    timezone = json['timezone'];
    createdOn = json['created_on'];
    step = json['step'];
    skillTitle = json['skill_title'];
    lastActionTime = json['last_action_time'];
    createdById = json['created_by_id'];
    otpVerified = json['otp_verified'];
    isNotify = json['is_notify'];
    experience = json['experience'];
    rating = json['rating'];
    languageTitle = json['language_title'];
    qualificationTitle = json['qualification_title'];
    workZoneTitle = json['work_zone_title'];
    skillTitle = json['skill_title'];
    age = json['age'];
    ratingCount = json['rating_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['email'] = email;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['experience'] = this.experience;

    data['country_code'] = countryCode;
    data['contact_no'] = contactNo;
    data['otp'] = otp;
    data['medical_report'] = medicalReport;
    data['about_me'] = breifCondition;
    data['otp_attempt'] = otpAttempt;
    data['zipcode'] = zipcode;
    data['is_otp_verify'] = isOtpVerify;
    data['mobile_otp'] = mobileOtp;
    data['identity_number'] = identityNumber;
    data['mobile_otp_verify'] = mobileOtpVerify;
    data['address'] = address;
    data['language'] = language;
    data['profile_file'] = profileFile;
    data['tos'] = tos;
    data['role_id'] = roleId;
    data['state_id'] = stateId;
    data['type_id'] = typeId;
    data['step'] = step;
    data['timezone'] = timezone;
    data['created_on'] = createdOn;
    data['last_action_time'] = this.lastActionTime;
    data['created_by_id'] = this.createdById;
    data['otp_verified'] = this.otpVerified;
    data['is_notify'] = this.isNotify;
    data['rating'] = this.rating;
    data['language_title'] = this.languageTitle;
    data['qualification_title'] = this.qualificationTitle;
    data['work_zone_title'] = this.workZoneTitle;
    data['skill_title'] = this.skillTitle;
    data['age'] = this.age;
    data['rating_count'] = this.ratingCount;
    return data;
  }
}
