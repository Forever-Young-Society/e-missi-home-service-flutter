import 'package:e_missi_service_provider/export.dart';

class AgeViewController extends GetxController {
  RxInt currentIndex = 0.obs;
  FixedExtentScrollController scrollController =
      new FixedExtentScrollController(initialItem: 0);

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(50);
    });
    super.onInit();
  }
}
