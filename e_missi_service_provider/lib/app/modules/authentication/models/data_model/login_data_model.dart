/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/app/modules/authentication/models/data_model/files_data.dart';

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
  var isRestaurantDetail;
  var isMenuAdded;
  var timezone;
  var createdOn;
  var aboutMe;
  var latitude;
  var longitude;
  var city;
  var country;
  var zipcode;
  var experience;
  var otpVerified;
  var qualificationFile;
  var qualificationFileName;
  var languages;
  var qualifications;
  var skills;
  var workZone;
  List<Files>? files;
  var rating;
  var languageTitle;
  var age;
  var qualificationTitle;

  LoginDataModel(
      {this.id,
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
      this.qualificationFileName,
      this.mobileOtp,
      this.medicalReport,
      this.mobileOtpVerify,
      this.address,
      this.language,
      this.profileFile,
      this.tos,
      this.roleId,
      this.stateId,
      this.typeId,
      this.step,
      this.workZone,
      this.aboutMe,
      this.latitude,
      this.longitude,
      this.city,
      this.country,
      this.zipcode,
      this.experience,
      this.otpVerified,
      this.qualificationFile,
      this.languages,
      this.qualifications,
      this.skills,
      this.isRestaurantDetail,
      this.isMenuAdded,
      this.timezone,
      this.files,this.qualificationTitle,this.age,this.rating,this.languageTitle,
      this.createdOn});

  LoginDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    experience = json['experience'];
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
    mobileOtpVerify = json['mobile_otp_verify'];
    address = json['address'];
    language = json['language'];
    profileFile = json['profile_file'];
    tos = json['tos'];
    roleId = json['role_id'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    step = json['step'];
    isRestaurantDetail = json['is_restaurant_detail'];
    isMenuAdded = json['is_menu_added'];
    timezone = json['timezone'];
    createdOn = json['created_on'];
    qualificationFile = json['qualification_file'];
    qualificationFileName = json['qualification_file_name'];
    languages = json['languages'];
    qualifications = json['qualifications'];
    skills = json['skills'];
    experience = json['experience'];
    rating = json['rating'];
    languageTitle = json['language_title'];
    qualificationTitle = json['qualification_title'];
    age=json['age'];
    workZone = json['work_zone'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['email'] = email;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['country_code'] = countryCode;
    data['contact_no'] = contactNo;
    data['otp'] = otp;
    data['medical_report'] = medicalReport;
    data['experience'] = experience;
    data['about_me'] = breifCondition;
    data['otp_attempt'] = otpAttempt;
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
    data['work_zone'] = workZone;
    data['is_restaurant_detail'] = isRestaurantDetail;
    data['is_menu_added'] = isMenuAdded;
    data['timezone'] = timezone;
    data['created_on'] = createdOn;
    data['qualification_file'] = this.qualificationFile;
    data['qualification_file_name'] = this.qualificationFileName;
    data['languages'] = this.languages;
    data['qualifications'] = this.qualifications;
    data['skills'] = this.skills;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    data['rating'] = this.rating;
    data['language_title'] = this.languageTitle;
    data['qualification_title'] = this.qualificationTitle;
    data['age'] = this.age;
    return data;
  }
}




