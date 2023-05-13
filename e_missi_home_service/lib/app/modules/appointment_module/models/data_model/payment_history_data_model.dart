class PaymentHistoryDataModel {
  int? id;
  String? orderId;
  String? startTime;
  String? endTime;
  String? createdOn;
  int? paymentStatus;
  String? serviceName;
  String? skillName;
  var userAmount;

  PaymentHistoryDataModel(
      {this.id,
        this.orderId,
        this.startTime,
        this.endTime,
        this.createdOn,
        this.paymentStatus,
        this.serviceName,
        this.userAmount,
        this.skillName});

  PaymentHistoryDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    createdOn = json['created_on'];
    paymentStatus = json['payment_status'];
    serviceName = json['service_name'];
    skillName = json['skill_name'];
    userAmount = json['user_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['created_on'] = this.createdOn;
    data['payment_status'] = this.paymentStatus;
    data['service_name'] = this.serviceName;
    data['skill_name'] = this.skillName;
    data['user_amount'] = this.userAmount;
    return data;
  }
}