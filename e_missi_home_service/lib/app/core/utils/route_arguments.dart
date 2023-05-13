class AppArguments {
  static serviceReportAddScreenData({appointmentData, isCompleted}) {
    Map<String, dynamic> data = {};
    data['appointmentData'] = appointmentData;
    data['isCompleted'] = isCompleted;
    return data;
  }

  static appointmentDetailData({required bookingId,isNotified,rate}){
    Map<String,dynamic> data ={};
    data['bookingId']=bookingId;
    data['isNotified']=isNotified;
    data['rate']=rate;
    return data;
  }
  static appointmentDetailConfirmationData({required bookingId,orderId}){
    Map<String,dynamic> data ={};
    data['bookingId']=bookingId;
    data['orderId']=orderId;
    return data;
  }



}