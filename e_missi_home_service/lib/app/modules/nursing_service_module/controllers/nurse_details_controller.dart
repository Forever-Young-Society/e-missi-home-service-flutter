import 'package:e_missi_home_service/app/modules/nursing_service_module/model/response_model/nurses_detail_response_model.dart';
import 'package:e_missi_home_service/export.dart';

class NurseDetailController extends GetxController {
  final Repository _repository = Get.find<Repository>();
  NursesServicesDetailResponseModel nursesServicesDetailResponseModel =
      NursesServicesDetailResponseModel();
  var catId;
  var skill;
  var date;
  var servicesId, serviceId;
  var dependentID;
  var typeID, workingzoneId, zipcode, titleOfService;
  var age;
  List<String> stringList = [];

  @override
  void onInit() {
    if (Get.arguments != null) {
      servicesId = Get.arguments['id'];
      date = Get.arguments['date'];
      serviceId = Get.arguments['serviceId'];
      dependentID = Get.arguments['dependentId'];
      typeID = Get.arguments['typeId'];
      workingzoneId = Get.arguments['workingZoneId'];
      zipcode = Get.arguments['zipcode'];
      catId = Get.arguments['categoryId'];
      titleOfService = Get.arguments['titleOfService'];
    }

    super.onInit();
  }

  @override
  void onReady() {
    hitservicesDetailsAPI(id: servicesId);

    super.onReady();
  }

  hitservicesDetailsAPI({id}) {
    _repository.servicesDtailsApiCall(id: id).then((value) async {
      if (value != null) {
        nursesServicesDetailResponseModel = value;
        skill = nursesServicesDetailResponseModel.detail?.skillTitle ?? '';
        stringList = skill.split(",,");
        debugPrint('${skill}');
        debugPrint('${stringList.toString()}');
        update();
      }
    }).onError((error, stackTrace) {});
  }
}
