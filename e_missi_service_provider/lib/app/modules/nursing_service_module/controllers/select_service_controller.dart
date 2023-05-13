import 'package:e_missi_service_provider/export.dart';

class SelectServiceController extends GetxController {
  RxList title = [].obs;

  @override
  void onInit() {
    title.value = [
      StateData(
          title: "Home & environmental assessment for elderly",
          isSelected: false),
      StateData(title: "General Health assessment", isSelected: false),
      StateData(title: "Bed sore dressing - Procedure only", isSelected: false),
      StateData(
          title: "Bed sore dressing - with dressing set and normal saline",
          isSelected: false),
      StateData(
          title: "Wound/Ulcer Dressing - Procedure only", isSelected: false),
      StateData(
          title: "Wound/Ulcer Dressing - with dressing set and normal saline",
          isSelected: false),
      StateData(
          title: "Naso gastric tube insetion and care", isSelected: false),
      StateData(
          title: "Naso gastric tube insetion and care,include noraml NG Tube",
          isSelected: false),
    ];
    super.onInit();
  }

  getCallback(index, value) {
    title.value[index].isSelected = !value;
    update();
  }
}

class StateData {
  bool? isSelected;
  String? title;

  StateData({this.isSelected, this.title});
}
