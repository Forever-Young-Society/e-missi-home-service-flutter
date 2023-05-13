import 'package:e_missi_home_service/export.dart';
import 'package:intl/intl.dart';

class NursingServiceScreen extends StatelessWidget {
  var controller =Get.put(NursingServiceController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NursingServiceController>(
      init: NursingServiceController(),
      builder: (controller) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AssetImageWidget(
                imageUrl: ic_tech_bg,
                imageFitType: BoxFit.cover,
              ),
              Column(
                children: [
                  appBarView2(
                    onTap: () {
                      Get.back();
                    },
                    title: controller.titleOfService ?? strNursingServices,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        sizeBox(height: margin_20),
                        _forWhom(),
                        sizeBox(height: margin_30),
                        _typeOfServiceForm(),
                        sizeBox(height: margin_30),
                        _findNurseForm(context),
                        sizeBox(height: margin_30),
                        _next()
                      ],
                    ).paddingSymmetric(horizontal: margin_5),
                  ))
                ],
              ).paddingAll(margin_15),
            ],
          ),
        );
      },
    );
  }

  _forWhom() {
    return getContainer(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(strIsThisForYou, style: textStyleBody1()), _personList()],
    ).paddingOnly(
        top: margin_20, left: margin_20, right: margin_20, bottom: margin_0));
  }

  _personList() {
    return Container(
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.dependentList.length + 2,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.6,
              crossAxisSpacing: margin_20),
          itemBuilder: (context, index) {
            return index == 0
                ? Obx(() => inkWell(
                    ontap: () {
                      controller.updateIndex(0);
                      controller.updateType(TYPE_SELF);
                      controller.stateTextEditingController?.text =
                          controller.loginResponseModel.detail?.address;
                      controller.areaTextEditingController?.text =
                          controller.loginResponseModel.detail?.zipcode;
                    },
                    child: PersonViewScreen(
                      image: ic_user,
                      name: 'You',
                      isSelected:
                          controller.currentIndex.value == 0 ? true : false,
                    )))
                : index == 1
                    ? Obx(() => inkWell(
                        ontap: () async {
                          controller.updateIndex(1);
                          var data = await bottomSheet(
                              widget: SomeOneElseViewScreen(),
                              textLabel: strAddProfile);
                          if (data != null) {
                            controller.hitdepedentListApi();
                          }
                          controller.stateTextEditingController?.text = "";
                          controller.areaTextEditingController?.text = "";
                        },
                        child: PersonViewScreen(
                          image: ic_outlineduser,
                          name: strSomeoneElse,
                          isSelected:
                              controller.currentIndex.value == 1 ? true : false,
                        )))
                    : Obx(() => inkWell(
                          ontap: () {
                            controller.getDependentID(
                                controller.dependentList[index - 2].id);
                            controller.updateType(typeDependent);
                            controller.updateIndex(index);
                            controller.stateTextEditingController?.text =
                                controller.dependentList[index - 2].address;
                            controller.areaTextEditingController?.text =
                                controller.dependentList[index - 2].zipcode;
                          },
                          child: PersonViewScreen(
                            image: ic_user,
                            name: controller.dependentList[index - 2].fullName,
                            isSelected: controller.currentIndex.value == index
                                ? true
                                : false,
                          ),
                        ));
          }),
    );
  }

  _findNurseForm(BuildContext context) {
    return getContainer(
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(strFindTheNurse, style: textStyleBody1())
          .paddingOnly(bottom: margin_20),
      _AddressSelect(),
      sizeBox(height: height_20),
      _postCodeSelect(),
      _date(context),
    ]).paddingAll(margin_20));
  }

  _date(BuildContext context) {
    return TextFieldWidget(
      hint: strDateMonthYear,
      textController: controller.dateTextEditingController,
      alignLabelWithHint: false,
      labels: false,
      readOnly: true,
      onTap: () async {
        var datePicked = await DatePicker.showSimpleDatePicker(
          context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 5),
          dateFormat: "dd-MMM-yyyy",
          locale: DateTimePickerLocale.en_us,
        );
        if (datePicked != null) {
          final DateFormat formatter = DateFormat('yyyy-MM-dd');
          final DateFormat display = DateFormat('dd MMMM yyyy');
          controller.formatted = formatter.format(datePicked);
          controller.displayDate = display.format(datePicked);
          controller.dateTextEditingController?.text =
              controller.displayDate.toString();
          controller.update();
        }
      },
      prefixIcon: AssetImageWidget(
        imageUrl: ic_prplecal,
        imageHeight: height_30,
        imageWidth: height_30,
        color: Colors.purple,
      ).paddingOnly(left: margin_10, right: margin_5, bottom: margin_3),
      hintStyle: textStyleBody1()
          .copyWith(fontSize: font_14, color: Colors.grey.shade400),
      contentPadding:
          EdgeInsets.symmetric(horizontal: margin_10, vertical: margin_15),
      borders: OutlineInputBorder(
          borderRadius: BorderRadius.circular(margin_10),
          borderSide: BorderSide(color: Colors.grey)),
    ).paddingOnly(bottom: margin_20, top: margin_20);
  }

  _typeOfServiceForm() {
    return getContainer(
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(strTypeOfServices, style: textStyleBody1()),
      sizeBox(height: margin_20),
      _service(),
    ]).paddingAll(margin_20));
  }

  _service() {
    return TextFieldWidget(
      hint: strPleaseSelect,
      alignLabelWithHint: false,
      labels: false,
      readOnly: true,
      textController: controller.serviceTextEditingController,
      onTap: () async {
        bottomSheet(
            widget: Get.find<NursingServiceController>()
                        .subCategoryList!
                        .length ==
                    0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Center(
                          child: Text(
                            strNoServicesFound,
                            style: textStyleBody2().copyWith(
                                color: Colors.black, fontSize: font_15),
                          ),
                        ).paddingOnly(bottom: margin_200)
                      ])
                : SelectServiceTypsScreen(
                    onTap: () {
                      if (controller.selectedSubServices.isNotEmpty) {
                        var list = controller.subCategoryList
                            ?.map((e) => e.subServices?.where(
                                (element) => element.isSelected == true))
                            .toList();
                        list!.removeWhere((element) => element!.length == 0);

                        var finalList = list
                            .map((e) => e!.length)
                            .toString()
                            .replaceAll("(", "")
                            .replaceAll(")", "");
                        debugPrint("combination count length ${finalList}");
                        debugPrint(
                            "combination count length ${controller.combinationCount}");

                        if (finalList ==
                            controller.combinationCount.toString()) {
                          controller.serviceTextEditingController!.text =
                              strMultipleSubServices;
                          controller.subCategoryId = controller
                              .selectedSubServices
                              .join(',')
                              .toString();
                          Get.back();
                        } else {
                          flashBar(message: strmaxAdd);
                        }
                      } else {
                        Get.back();
                        controller.serviceTextEditingController!.text =
                            controller
                                .subCategoryList![controller.selectedIndex]
                                .title!;
                        controller.subCategoryId = controller
                            .subCategoryList![controller.selectedIndex].id!;
                      }
                      controller.update();
                    },
                  ),
            textLabel: strSelectTypeOfService);
      },
      hintStyle: textStyleBody1()
          .copyWith(fontSize: font_14, color: Colors.grey.shade400),
      contentPadding:
          EdgeInsets.symmetric(horizontal: margin_10, vertical: margin_15),
      borders: OutlineInputBorder(
          borderRadius: BorderRadius.circular(margin_10),
          borderSide: BorderSide(color: Colors.grey)),
      suffixIcon: AssetImageWidget(
        imageUrl: ic_dropdown,
        imageHeight: height_15,
        imageWidth: height_15,
        color: Colors.purple,
      ).paddingAll(margin_12),
    );
  }

  _AddressSelect() {
    return TextFieldWidget(
      hint: strPleaseSelectAddress,
      alignLabelWithHint: false,
      labels: false,
      readOnly: controller.addressBool,
      textController: controller.stateTextEditingController,
      hintStyle: textStyleBody1()
          .copyWith(fontSize: font_14, color: Colors.grey.shade400),
      contentPadding:
          EdgeInsets.symmetric(horizontal: margin_10, vertical: margin_15),
      borders: OutlineInputBorder(
          borderRadius: BorderRadius.circular(margin_10),
          borderSide: BorderSide(color: Colors.grey)),
    );
  }

  _postCodeSelect() {
    return TextFieldWidget(
      hint: strPleaseSelectPostCodes,
      alignLabelWithHint: false,
      labels: false,
      readOnly: controller.addressBool,
      textController: controller.areaTextEditingController,
      hintStyle: textStyleBody1()
          .copyWith(fontSize: font_14, color: Colors.grey.shade400),
      contentPadding:
          EdgeInsets.symmetric(horizontal: margin_10, vertical: margin_15),
      borders: OutlineInputBorder(
          borderRadius: BorderRadius.circular(margin_10),
          borderSide: BorderSide(color: Colors.grey)),
    );
  }

  _next() {
    return MaterialButtonWidget(
      onPressed: () {
        if (controller.serviceTextEditingController!.text == null ||
            controller.serviceTextEditingController!.text.isEmpty) {
          flashBar(message: strPleaseSelectServiceCategory);
        } else if (controller.areaTextEditingController!.text == null ||
            controller.areaTextEditingController!.text.isEmpty) {
          flashBar(message: strPleaseSelectPostCode);
        } else if (controller.dateTextEditingController!.text == null ||
            controller.dateTextEditingController!.text.isEmpty) {
          flashBar(message: strPleaseSelectDate);
        } else {
          logoutDialog(
              text: strAddressDetails,
              confirmText: strOk,
              controller: controller,
              onTap: () {
                controller.addressBool = true;

                Get.back();
                controller.hitMatchesServicesLstApi();
              },
              onCancel: () {
                Get.back();
                controller.addressBool = false;
                controller.update();
              });
        }
      },
      buttonText: strNext.toUpperCase(),
    );
  }

  logoutDialog({
    text,
    confirmText,
    onTap,
    onCancel,
    controller,
    bool textfeild = false,
  }) {
    return Get.dialog(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: Get.height,
          width: Get.width,
          color: Colors.white10,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: margin_30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(margin_10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height_30),
                    TextView(
                      text: text,
                      maxLine: 5,
                      textStyle: textStyleBody2().copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: font_18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TextView(
                      text:
                          "Address:\n${controller.stateTextEditingController.text.toString()}",
                      maxLine: 5,
                      textStyle: textStyleBody1().copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: font_16,
                          color: Colors.grey),
                      textAlign: TextAlign.start,
                    ).paddingOnly(top: margin_10, left: margin_10),
                    TextView(
                      text:
                          "Post Code:\n${controller.areaTextEditingController.text.toString()}",
                      maxLine: 5,
                      textStyle: textStyleBody2().copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: font_16,
                          color: Colors.grey),
                      textAlign: TextAlign.start,
                    ).paddingOnly(top: margin_10, left: margin_10),
                    SizedBox(height: height_30),
                    Container(
                      color: Colors.grey,
                      height: 1,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: () {
                              if (onCancel != null) {
                                onCancel();
                              } else {
                                Get.back();
                              }
                            },
                            child: TextView(
                              text: strChanges,
                              textStyle: textStyleBody2().copyWith(
                                  color: Colors.black,
                                  fontSize: font_18,
                                  fontWeight: FontWeight.w500),
                            )),
                        Container(
                          width: 1,
                          height: height_45,
                          color: Colors.grey,
                        ),
                        InkWell(
                          onTap: () {
                            onTap();
                          },
                          child: TextView(
                            text: confirmText,
                            textStyle: textStyleBody2().copyWith(
                                color: purple,
                                fontSize: font_18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
