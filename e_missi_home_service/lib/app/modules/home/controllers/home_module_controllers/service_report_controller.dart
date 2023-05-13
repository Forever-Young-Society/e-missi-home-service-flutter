/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'dart:io';

import 'package:e_missi_home_service/export.dart';

class ServiceAddController extends BaseController {
  TextEditingController? patientNameTextController;
  TextEditingController? identityTextController;
  TextEditingController? emailTextController;
  TextEditingController? genderTextController;
  TextEditingController? ageTextController;
  TextEditingController? addressTextController;
  TextEditingController? cityTextController;
  TextEditingController? stateTextController;
  TextEditingController? postCodeTextController;

  TextEditingController? serviceProvidedTextController;
  TextEditingController? encounterDateTextController;
  TextEditingController? encounterTimeTextController;
  TextEditingController? spNameTextController;
  TextEditingController? serviceReportTextController;

  FocusNode? patientNameFocusNode;
  FocusNode? identityFocusNode;
  FocusNode? emailFocusNode;
  FocusNode? genderFocusNode;
  FocusNode? ageFocusNode;
  FocusNode? addressFocusNode;
  FocusNode? cityFocusNode;
  FocusNode? stateFocusNode;
  FocusNode? postCodeFocusNode;

  FocusNode? serviceProvidedFocusNode;
  FocusNode? encounterDateFocusNode;
  FocusNode? encounterTimeFocusNode;
  FocusNode? spNameFocusNode;
  FocusNode? serviceReportFocusNode;

  int isActive = 0;
  bool isHide = false;
  bool isConfirmHide = false;
  ServiceReportDataModel? bookingDetailDataModel;
  final Repository _repository = Get.find<Repository>();

  var genderId;

  List<AreaType> genderList = [
    AreaType(
      id: 0,
      type: strMale,
    ),
    AreaType(
      id: 1,
      type: strFeMale,
    ),
  ];
  double? sizeInMb;
  File? documentFile;
  bool isCompleted = false;
  @override
  void onInit() {
    if (Get.arguments != null) {
      bookingDetailDataModel = Get.arguments['appointmentData'];
      isCompleted = Get.arguments['isCompleted'];
      initializeTextEditingController();
    }
    super.onInit();
  }

  initializeTextEditingController() {
    patientNameTextController =
        TextEditingController(text: bookingDetailDataModel?.userName ?? "");
    identityTextController =
        TextEditingController(text: bookingDetailDataModel?.icNumber ?? "");
    emailTextController =
        TextEditingController(text: bookingDetailDataModel?.email ?? "");
    genderTextController = TextEditingController(
        text: bookingDetailDataModel?.gender == 0 ? strMale : strFeMale);
    ageTextController = TextEditingController(
        text: bookingDetailDataModel?.age?.toString() ?? "");
    addressTextController =
        TextEditingController(text: bookingDetailDataModel?.address ?? "");
    cityTextController = TextEditingController();
    stateTextController = TextEditingController();
    postCodeTextController =
        TextEditingController(text: bookingDetailDataModel?.zipcode ?? "");
    serviceProvidedTextController = TextEditingController(
        text: "${bookingDetailDataModel?.serviceProvided ?? ""}");
    encounterDateTextController = TextEditingController(
        text: getDateString(
            bookingDetailDataModel?.bookingDate?.toString() ?? ""));
    encounterTimeTextController = TextEditingController(
        text: bookingDetailDataModel?.bookingTime?.toString() ?? "");
    spNameTextController =
        TextEditingController(text: bookingDetailDataModel?.providerName ?? "");
    serviceReportTextController =
        TextEditingController(text: bookingDetailDataModel?.description ?? "");

    patientNameFocusNode = FocusNode();
    identityFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    genderFocusNode = FocusNode();
    ageFocusNode = FocusNode();
    addressFocusNode = FocusNode();
    cityFocusNode = FocusNode();
    stateFocusNode = FocusNode();
    postCodeFocusNode = FocusNode();

    serviceProvidedFocusNode = FocusNode();
    encounterDateFocusNode = FocusNode();
    encounterTimeFocusNode = FocusNode();
    spNameFocusNode = FocusNode();
    serviceReportFocusNode = FocusNode();
  }
}
