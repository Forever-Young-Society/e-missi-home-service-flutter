



import '../../../../export.dart';
import 'package:e_missi_home_service/app/modules/nursing_service_module/controllers/select_state_controller.dart';

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
