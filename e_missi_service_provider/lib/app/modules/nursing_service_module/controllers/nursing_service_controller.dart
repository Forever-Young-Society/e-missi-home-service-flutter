import 'package:e_missi_service_provider/export.dart';

class NursingServiceController extends GetxController {
  List<PersonDataModel> personList = [];
  var currentIndex = 0.obs;
  TextEditingController? stateTextEditingController;
  TextEditingController? areaTextEditingController;
  TextEditingController? dateTextEditingController;
  TextEditingController? serviceTextEditingController;

  @override
  void onInit() {
    stateTextEditingController = new TextEditingController();
    areaTextEditingController = new TextEditingController();
    dateTextEditingController = new TextEditingController();
    serviceTextEditingController = new TextEditingController();
    personList = [
      PersonDataModel(image: ic_user, name: "You"),
      PersonDataModel(image: ic_user, name: "Kira"),
    ];
    super.onInit();
  }

  updateIndex(index) {
    currentIndex.value = index;
    if (currentIndex.value == 1) {
      stateTextEditingController?.text = "Selangor";
      areaTextEditingController?.text = "Section 17";
      dateTextEditingController?.text = "12/10/2022";
      serviceTextEditingController?.text = "General Health Assessment";
    } else {
      stateTextEditingController?.clear();
      areaTextEditingController?.clear();
      dateTextEditingController?.clear();
      serviceTextEditingController?.clear();
    }
    update();
  }
}

class PersonDataModel {
  String? image;
  String? name;

  PersonDataModel({this.name, this.image});
}
