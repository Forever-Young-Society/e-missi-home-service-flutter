/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'dart:core';


import 'package:e_missi_home_service/export.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AppointmentCalendarController extends GetxController {
  DateTime? startDate;
  DateTime? lastDate;
  DateTime? minDate = DateTime.now();
  List selectedDays = [];
  List selectedDays1 = [];
  List<DateTime> blackoutDates = <DateTime>[];
  var selectedIndex;
  var date, selectedDate, selDate;
  var Datetime,
      providerId,
      serviceId,
      catId,
      typeId,
      dependentId,
      slotId,
      startTime,
      endTime,
      workingZoneID,
      zipcode,
      bookingId,
      type,
      bookingStartTime;
  final Repository _repository = Get.find<Repository>();
  MySlotsResponseModel? mySlotsResponseModel;
  List<MySlotsDataModel>? mySlotList;
  ProviderAvailabilityResponse? providerAvailabilityResponse;
  List<String>? availableList;
  List<String>? blockoutList = [];
  Set<DateTime>? availableSet;
  var isOk = false;
  var isFirst = false;
  bool isFirsts = false;
  List<DateTime> blackoutDateCollection = <DateTime>[];
  List<DateTime> activeDates = <DateTime>[];
  DateRangePickerController? dateRangePickerController =
      DateRangePickerController();

  @override
  void onInit() {
    getData();
    startDate = DateTime.now();
    lastDate = DateTime(DateTime.now().year + 1, 12, 31);

    super.onInit();
  }

  @override
  void onReady() {
    getData();
    hitInitialApi(dateMonth: date, providerId: providerId, serviceId: catId);
    super.onReady();
  }

  getData() {
    if (Get.arguments != null) {
      date = Get.arguments['date'];
      selDate = Get.arguments['date'];
      providerId = Get.arguments['providerId'];
      serviceId = Get.arguments['serviceId'];
      typeId = Get.arguments['typeId'];
      dependentId = Get.arguments['dependentId'];
      workingZoneID = Get.arguments['workingZoneId'];
      zipcode = Get.arguments['zipcode'];
      type = Get.arguments['type'];
      bookingId = Get.arguments['bookingId'];
      catId = Get.arguments['categoryId'];
      if (Get.arguments['isFirst'] != null) {
        isFirsts = Get.arguments['isFirst'];
      } else {
        isFirsts = false;
      }
      bookingStartTime = Get.arguments['bookingStartTime'];
      if (bookingStartTime != null) {
        minDate = DateTime.parse(bookingStartTime);
      }
      Datetime = DateFormat('dd-MMM-yyyy').format(DateTime.parse(date));
    }
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }

  hitInitialApi({dateMonth, providerId, serviceId}) async {
    getData();

    await _repository
        .providerAvailabilityApiCall(
            isLoading: false,
            providerI: providerId,
            serviceI: serviceId,
            date: dateMonth)
        .then((value) async {
      if (value != null) {
        providerAvailabilityResponse = value;
        availableList = providerAvailabilityResponse?.availableList ?? [];
        blockoutList = providerAvailabilityResponse?.blockoutList ?? [];
        if (blockoutList!.length != 0) {
          blockoutList!.forEach((element) {
            blackoutDates.add(DateTime.parse(element));
          });
        }
        if (providerAvailabilityResponse?.availableList != null) {
          availableSet = providerAvailabilityResponse?.availableList!
              .map((e) => DateTime.parse(e))
              .toSet();
        }
        for (var i = 0; i < availableList!.length; i++) {
          if (DateTime.parse(availableList![i]).year == DateTime.now().year &&
              DateTime.parse(availableList![i]).month == DateTime.now().month &&
              DateTime.parse(availableList![i]).day == DateTime.now().day) {
            selectedDate = DateTime.parse(availableList![i]);
            date = DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(availableList![i]));
            if (isFirsts == false) {
              hitProviderSlotApi(selectedDate);
            }
          }
        }

        if (bookingStartTime != null) {
          for (var i = 0; i < availableList!.length; i++) {
            if (DateTime.parse(availableList![i]).year ==
                    DateTime.parse(bookingStartTime).year &&
                DateTime.parse(availableList![i]).month ==
                    DateTime.parse(bookingStartTime).month &&
                DateTime.parse(availableList![i]).day ==
                    DateTime.parse(bookingStartTime).day) {
              selectedDate = DateTime.parse(availableList![i]);
              date = DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(availableList![i]));

              hitProviderSlotApi(selectedDate,
                  rescheduleTime: bookingStartTime);
            }
          }
        } else {
          for (var i = 0; i < availableList!.length; i++) {
            if (DateTime.parse(availableList![i]).year ==
                    DateTime.parse(date).year &&
                DateTime.parse(availableList![i]).month ==
                    DateTime.parse(date).month &&
                DateTime.parse(availableList![i]).day ==
                    DateTime.parse(date).day) {
              selectedDate = DateTime.parse(availableList![i]);
              date = DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(availableList![i]));
              if (selDate == availableList![i]) {
                hitProviderSlotApi(selectedDate,
                    rescheduleTime: bookingStartTime);
              }
            }
          }
        }
        isOk = true;

        update();
      }
    }).onError((error, stackTrace) {
      isOk = true;
      availableSet = [].toSet().cast<DateTime>();
      flashBar(message: error.toString());
    });
  }

  hitProviderAvailibilityListApi(
      {dateMonth, providerId, serviceId, isForward = false}) async {
    await _repository
        .providerAvailabilityApiCall(
            isLoading: false,
            providerI: providerId,
            serviceI: serviceId,
            date: dateMonth)
        .then((value) async {
      if (value != null) {
        providerAvailabilityResponse = value;
        if (providerAvailabilityResponse != null) {
          availableList = providerAvailabilityResponse?.availableList ?? [];
          blockoutList = providerAvailabilityResponse?.blockoutList ?? [];
          blockoutList!.forEach((element) {
            blackoutDates.add(DateTime.parse(element));
          });
          if (providerAvailabilityResponse?.availableList != null) {
            availableSet = providerAvailabilityResponse?.availableList!
                .map((e) => DateTime.parse(e))
                .toSet();
          }

          Future.delayed(
            Duration(milliseconds: 100),
            () {
              if (isForward == true) {
                dateRangePickerController!.forward!();
                if (bookingStartTime != null) {
                  for (var i = 0; i < availableList!.length; i++) {
                    if (DateTime.parse(availableList![i]).year ==
                            DateTime.parse(bookingStartTime).year &&
                        DateTime.parse(availableList![i]).month ==
                            DateTime.parse(bookingStartTime).month &&
                        DateTime.parse(availableList![i]).day ==
                            DateTime.parse(bookingStartTime).day) {
                      selectedDate = DateTime.parse(availableList![i]);
                      date = DateFormat('yyyy-MM-dd')
                          .format(DateTime.parse(availableList![i]));

                      hitProviderSlotApi(selectedDate,
                          rescheduleTime: bookingStartTime);
                    }
                  }
                } else {
                  for (var i = 0; i < availableList!.length; i++) {
                    if (DateTime.parse(availableList![i]).year ==
                            DateTime.parse(date).year &&
                        DateTime.parse(availableList![i]).month ==
                            DateTime.parse(date).month &&
                        DateTime.parse(availableList![i]).day ==
                            DateTime.parse(date).day) {
                      selectedDate = DateTime.parse(availableList![i]);
                      date = DateFormat('yyyy-MM-dd')
                          .format(DateTime.parse(availableList![i]));

                      hitProviderSlotApi(selectedDate,
                          rescheduleTime: bookingStartTime);
                    }
                  }
                }
              } else {
                dateRangePickerController!.backward!();
                if (bookingStartTime != null) {
                  for (var i = 0; i < availableList!.length; i++) {
                    if (DateTime.parse(availableList![i]).year ==
                            DateTime.parse(bookingStartTime).year &&
                        DateTime.parse(availableList![i]).month ==
                            DateTime.parse(bookingStartTime).month &&
                        DateTime.parse(availableList![i]).day ==
                            DateTime.parse(bookingStartTime).day) {
                      selectedDate = DateTime.parse(availableList![i]);
                      date = DateFormat('yyyy-MM-dd')
                          .format(DateTime.parse(availableList![i]));

                      hitProviderSlotApi(selectedDate,
                          rescheduleTime: bookingStartTime);
                    }
                  }
                } else {
                  for (var i = 0; i < availableList!.length; i++) {
                    if (DateTime.parse(availableList![i]).year ==
                            DateTime.parse(date).year &&
                        DateTime.parse(availableList![i]).month ==
                            DateTime.parse(date).month &&
                        DateTime.parse(availableList![i]).day ==
                            DateTime.parse(date).day) {
                      selectedDate = DateTime.parse(availableList![i]);
                      date = DateFormat('yyyy-MM-dd')
                          .format(DateTime.parse(availableList![i]));

                      hitProviderSlotApi(selectedDate,
                          rescheduleTime: bookingStartTime);
                    }
                  }
                }
              }
            },
          );

          isOk = true;
          update();
        }
      }
    }).onError((error, stackTrace) {
      isOk = true;
      update();
      availableSet = [].toSet().cast<DateTime>();
      flashBar(message: error.toString());
    });
  }

  void viewChanged(DateRangePickerViewChangedArgs args) {
    startDate = args.visibleDateRange.startDate;
  }

  hitProviderSlotApi(date, {rescheduleTime}) async {
    Map<String, dynamic> requestModel =
        AuthRequestModel.providerSlotsRequestModel(
            startTime: date.toString().replaceAll(".000", ""),
            endTime: date.toString().replaceAll("00:00:00.000", "23:59:59"),
            typeId: catId,
            providerId: providerId);
    _repository
        .providerSlotsApiCall(
            dataBody: requestModel, rescheduleTime: rescheduleTime)
        .then((value) async {
      if (value != null) {
        mySlotsResponseModel = value;
        mySlotList = mySlotsResponseModel?.list ?? [];
        bottomSheet(
            widget: SelectSlotScreen(
              type: type,
            ),
            textLabel: "",
            isSlotColor: appLightColor,
            isSlot: Container(
              height: 0,
              width: 0,
            ),
            slotHeight: margin_5);
        isFirst = false;
        update();
      }
    }).onError((error, stackTrace) {
      isFirst = false;
      update();
      flashBar(message: error.toString());
    });
  }

  hitApiToBookAppointment() {
    var data = AuthRequestModel.slotBookRequestModel(
        providerID: providerId,
        serviceID: serviceId,
        typeID: typeId,
        slotID: slotId,
        startTime: startTime,
        endTime: endTime,
        workingZoneId: workingZoneID,
        zipCode: zipcode,
        dependentID: dependentId);
    _repository.bookAppointmentApiCall(data).then((value) {
      AddBookingResponseModel addBookingResponseModel = value;
      Get.toNamed(
        AppRoutes.appointmentDetailConfirmationScreen,
        arguments: AppArguments.appointmentDetailConfirmationData(
            bookingId: addBookingResponseModel.details?.id,
            orderId: addBookingResponseModel.details?.orderId),
      );
      flashBar(message: addBookingResponseModel.message ?? "");
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  hitApiToUpdateBookAppointment(bookingId) {
    var data = AuthRequestModel.updateSlotBookRequestModel(
      slotID: slotId,
      startTime: startTime,
      endTime: endTime,
    );
    _repository.updateBookAppointmentApiCall(data, bookingId).then((value) {
      AddBookingResponseModel addBookingResponseModel = value;
      var controller = Get.put<AppointmentDetailConfirmationController>(
          AppointmentDetailConfirmationController());
      controller.onInit();
      Get.offAndToNamed(
        AppRoutes.appointmentDetailConfirmationScreen,
        arguments: AppArguments.appointmentDetailConfirmationData(
          bookingId: addBookingResponseModel.details?.id,
        ),
      );

      flashBar(message: addBookingResponseModel.message ?? "");
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  hitApiToRescheduleBookAppointment(bookingId) {
    var data = AuthRequestModel.updateSlotBookRequestModel(
      slotID: slotId,
      startTime: startTime,
      endTime: endTime,
    );
    _repository.rescheduleAppointmentApiCall(data, bookingId).then((value) {
      AddBookingResponseModel addBookingResponseModel = value;
      var controller =
          Get.put<AppointmentDetailController>(AppointmentDetailController());
      controller.onInit();
      Get.back(result: addBookingResponseModel.details);
      Get.back(result: addBookingResponseModel.details);

      flashBar(message: addBookingResponseModel.message ?? "");
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  getSlotID(id, starttime, endtime) {
    slotId = id;
    startTime = starttime;
    endTime = endtime;
    update();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
