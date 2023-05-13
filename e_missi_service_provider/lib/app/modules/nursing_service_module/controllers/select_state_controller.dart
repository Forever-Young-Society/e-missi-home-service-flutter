import 'package:e_missi_service_provider/export.dart';

class SelectStateController extends GetxController {
  RxList title = [].obs;

  @override
  void onInit() {
    title.value = [
      StateData(title: "Johor", isSelected: false),
      StateData(title: "Kedah", isSelected: false),
      StateData(title: "Kelantan", isSelected: false),
      StateData(title: "Malacca", isSelected: false),
      StateData(title: "Negeri Sembilan", isSelected: false),
      StateData(title: "Pahang", isSelected: false),
      StateData(title: "Perak", isSelected: false),
      StateData(title: "Perlis", isSelected: false),
      StateData(title: "Selangor", isSelected: false),
      StateData(title: "Labuan", isSelected: false),
      StateData(title: "Putrajaya", isSelected: false),
    ];
    super.onInit();
  }
}

class StateData {
  bool? isSelected;
  String? title;

  StateData({this.isSelected, this.title});
}
