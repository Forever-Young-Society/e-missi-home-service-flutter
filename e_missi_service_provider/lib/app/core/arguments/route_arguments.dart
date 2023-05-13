class AppArguments{

  static serviceReportAddScreenData({appointmentData,isCompleted}){
    Map<String,dynamic> data ={};
    data['appointmentData']=appointmentData;
    data['isCompleted']=isCompleted;
    return data;
  }

}