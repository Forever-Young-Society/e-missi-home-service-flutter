import 'package:e_missi_home_service/export.dart';

class NursesListController extends GetxController {
  ServicesMatchListResponseModel servicesMatchListResponseModel =
      ServicesMatchListResponseModel();

  List<LoginDataModel>? servicesList = [];
  ScrollController? scrollController;
  var age;
  var date;
  var serviceId;
  var catId;
  var dependentID;
  var typeID;
  var workingzoneID, zipcode, titleOfService;
  @override
  void onInit() {
    scrollController = ScrollController();
    if (Get.arguments != null) {
      servicesMatchListResponseModel = Get.arguments[modelKey];
      date = Get.arguments['date'];
      serviceId = Get.arguments['serviceId'];
      catId = Get.arguments['categoryId'];
      dependentID = Get.arguments['dependentId'];
      typeID = Get.arguments['typeId'];
      workingzoneID = Get.arguments['workingZoneId'];
      zipcode = Get.arguments['zipcode'];
      titleOfService = Get.arguments['titleOfService'];
      servicesList = servicesMatchListResponseModel.list;
    }
    super.onInit();
  }
}
