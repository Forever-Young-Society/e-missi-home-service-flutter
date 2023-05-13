

import 'package:e_missi_home_service/export.dart';


class NursingServiceController extends GetxController {
  SubCategoryListResponse? subCategoryListResponse;
  LocationListResponseModel? locationListResponseModel =
      LocationListResponseModel();
  LocationZipCodeResponseModel? locationZipCodeResponseModel =
      LocationZipCodeResponseModel();

  ServicesMatchListResponseModel? servicesMatchListResponseModel =
      ServicesMatchListResponseModel();

  List<SubCategoryDataModel>? subCategoryList = [];
  List<LocationListDataModel>? locationList = [];
  List<LocationZipCodeDataModel>? locationZipCodeList = [];

  final Repository _repository = Get.find<Repository>();
  var currentIndex = 0.obs;
  TextEditingController? stateTextEditingController;
  TextEditingController? areaTextEditingController;
  TextEditingController? dateTextEditingController;
  TextEditingController? serviceTextEditingController;
  var selectedIndex;
  var selectedAddressIndex;
  var selectedZipCodeIndex;
  String? formatted;
  String? displayDate;
  var categoryId;
  var locationId;
  var zipCodeNumber;
  var subCategoryId;
  var typeID = TYPE_SELF;
  var dependentID;
  List selectedSubServices = [];
  var selectedSubCatId = -1;
  bool addressBool = true;
  var combinationCount;

  DependentListResponseModel dependentListResponseModel =
      DependentListResponseModel();

  LoginResponseModel loginResponseModel = LoginResponseModel();

  List<DependentListDataModel> dependentList = [];
  @override
  void onInit() {
    stateTextEditingController = new TextEditingController();
    areaTextEditingController = new TextEditingController();
    dateTextEditingController = new TextEditingController();
    serviceTextEditingController = new TextEditingController();

    if (Get.arguments != null) {
      categoryId = Get.arguments[catKey];
      titleOfService = Get.arguments[serviceTitle];
    }

    super.onInit();
  }

  var titleOfService;
  @override
  void onReady() {
    hitServiceSubCategoryAPI(catId: categoryId);
    hitdepedentListApi();
    hitCheckAPI();
    super.onReady();
  }

  hitServiceSubCategoryAPI({catId}) {
    _repository.serviceSubCategoryApiCall(catId: catId).then((value) async {
      if (value != null) {
        subCategoryListResponse = value;
        subCategoryList = subCategoryListResponse!.list;
        update();
      }
    }).onError((error, stackTrace) {
      showInSnackBar(message: error.toString());
    });
  }

  updateIndex(index) {
    currentIndex.value = index;
    update();
  }

  hitdepedentListApi() {
    _repository.dependentListApiCall(isLoading: false).then((value) async {
      if (value != null) {
        dependentListResponseModel = value;
        dependentList = dependentListResponseModel.list!;
        update();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  hitCheckAPI() {
    _repository.checkApiCall(isLoading: false).then((value) async {
      if (value != null) {
        loginResponseModel = value;
        stateTextEditingController?.text = loginResponseModel.detail?.address;
        areaTextEditingController?.text = loginResponseModel.detail?.zipcode;
        update();
      }
    });
  }

  hitMatchesServicesLstApi() async {
    Map<String, dynamic> requestModel =
        AuthRequestModel.servicesMatchListRequestModel(
            servicesId: subCategoryId.toString(),
            zipCode: areaTextEditingController?.text.toString() ?? "");
    _repository
        .matchesListApiCall(dataBody: requestModel, page: 0)
        .then((value) async {
      if (value != null) {
        servicesMatchListResponseModel = value;
        Get.toNamed(AppRoutes.nursesService, arguments: {
          modelKey: servicesMatchListResponseModel,
          'date': formatted,
          'serviceId': subCategoryId,
          'categoryId': categoryId,
          'dependentId': dependentID,
          'workingZoneId': stateTextEditingController?.text.toString(),
          'zipcode': areaTextEditingController?.text.toString(),
          'typeId': typeID,
          'titleOfService': titleOfService
        });
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  getDependentID(id) {
    dependentID = id;
    update();
  }

  updateType(id) {
    typeID = id;
    update();
  }
}