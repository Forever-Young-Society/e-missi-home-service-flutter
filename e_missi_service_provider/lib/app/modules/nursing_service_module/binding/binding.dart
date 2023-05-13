

import 'package:e_missi_service_provider/app/modules/nursing_service_module/controllers/select_state_controller.dart';

import '../../../../export.dart';

class NursingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NursingServiceController());
    Get.lazyPut(() => AgeViewController());
    Get.lazyPut(() => SomeOneElseController());
    Get.lazyPut(() => SomeOneElseController());
    Get.lazyPut(() => SelectServiceController());
    Get.lazyPut(() => SelectStateController());
    Get.lazyPut(() => NursesListController());
    Get.lazyPut(() => NurseDetailController());
  }
}
