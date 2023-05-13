class OtpResponseModel {
  var otp;
  var otpAttempt;
  var message;
  var copyrighths;

  OtpResponseModel({this.otp, this.otpAttempt, this.message, this.copyrighths});

  OtpResponseModel.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    otpAttempt = json['otp_attempt'];
    message = json['message'];
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['otp_attempt'] = this.otpAttempt;
    data['message'] = this.message;
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}
