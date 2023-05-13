class NursesServicesDetailDataModel {
  var id;
  var fullName;
  var email;
  var dateOfBirth;
  var gender;
  var experience;
  var profileFile;
  var languageTitle;
  var qualificationTitle;
  var skillTitle;
  var workZoneTitle;

  NursesServicesDetailDataModel(
      {this.id,
      this.fullName,
      this.email,
      this.dateOfBirth,
      this.gender,
      this.experience,
      this.profileFile,
      this.languageTitle,
      this.qualificationTitle,
      this.skillTitle,
      this.workZoneTitle});

  NursesServicesDetailDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    experience = json['experience'];
    profileFile = json['profile_file'];
    languageTitle = json['language_title'];
    qualificationTitle = json['qualification_title'];
    skillTitle = json['skill_title'];
    workZoneTitle = json['work_zone_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['experience'] = this.experience;
    data['profile_file'] = this.profileFile;
    data['language_title'] = this.languageTitle;
    data['qualification_title'] = this.qualificationTitle;
    data['skill_title'] = this.skillTitle;
    data['work_zone_title'] = this.workZoneTitle;
    return data;
  }
}
