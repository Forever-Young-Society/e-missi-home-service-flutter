import 'package:e_missi_home_service/export.dart';

class SelectStateController extends GetxController {
  RxList title = [].obs;
  RxInt isSelected = 0.obs;

  @override
  void onInit() {
    title.value = [
      StateData(
        title: "Johor",
      ),
      StateData(title: "Kedah"),
      StateData(title: "Kelantan"),
      StateData(title: "Malacca"),
      StateData(title: "Negeri Sembilan"),
      StateData(title: "Pahang"),
      StateData(title: "Perak"),
      StateData(title: "Perlis"),
      StateData(title: "Selangor"),
      StateData(title: "Labuan"),
      StateData(title: "Putrajaya"),
    ];
    super.onInit();
  }
}

class StateData {
  String? title;

  StateData({this.title});
}
