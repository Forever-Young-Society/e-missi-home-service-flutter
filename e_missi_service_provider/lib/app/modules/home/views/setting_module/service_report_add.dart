/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';
class ServiceReportAddScreen extends GetView<ServiceAddController> {
  final genderType = new GlobalKey(debugLabel: 'gender');
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return _body();
  }

/*========================================================_body============================================*/

  _body() => GetBuilder<ServiceAddController>(
        init: ServiceAddController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () {
              Get.back(result: "data");
              return Future.value();
            },
            child: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                        left: margin_10,
                      ),
                      child: appBarView2(
                          title: strServiceReport,
                          onTap: () {
                            Get.back(result: "data");
                          })),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _patientDetails(),
                          _formWidget(),
                        ],
                      ),
                    ),
                  )
                ],
              ).paddingSymmetric(vertical: margin_5),
            ),
          );
        },
      );

  _patientDetails({title}) {
    return Container(
      width: Get.width,
      color: appColor,
      child: TextView(
              text: title ?? strPatientDetails,
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: font_16,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.start)
          .paddingOnly(left: margin_10, top: margin_8, bottom: margin_8),
    ).paddingSymmetric(vertical: margin_10);
  }

  _formWidget() {
    return Form(
        key: formGlobalKey,
        child: Column(
          children: [
            _commonField(
                title: strFullNameStar,
                suffix: Container(height: 0, width: 0),
                controller: controller.patientNameTextController,
                focusNode: controller.patientNameFocusNode,
                readOnly: true),
            _commonField(
                title: strICNO,
                suffix: Container(height: 0, width: 0),
                controller: controller.identityTextController,
                focusNode: controller.identityFocusNode,
                readOnly: true),
            _commonField(
                title: strEmailAddressStar,
                suffix: Container(height: 0, width: 0),
                controller: controller.emailTextController,
                focusNode: controller.emailFocusNode,
                readOnly: true),
            _gender(),
            _commonField(
                title: strageStar,
                hint: strPleaseSelect,
                suffix: Container(height: 0, width: 0),
                controller: controller.ageTextController,
                focusNode: controller.ageFocusNode,
                readOnly: true),
            _commonField(
                title: strAddressStars,
                suffix: Container(height: 0, width: 0),
                controller: controller.addressTextController,
                focusNode: controller.addressFocusNode,
                readOnly: true),
            _commonField(
                title: strPostCodeStars,
                suffix: Container(height: 0, width: 0),
                controller: controller.postCodeTextController,
                focusNode: controller.postCodeFocusNode,
                readOnly: true),
            _patientDetails(title: strServiceReport),
            _commonField(
                title: strServiceProvidedStars,
                suffix: Container(height: 0, width: 0),
                maxline: 5,
                controller: controller.serviceProvidedTextController,
                focusNode: controller.serviceProvidedFocusNode,
                readOnly: true),
            _commonField(
                title: strEncounterDate,
                hint: strDateFormates,
                readOnly: true,
                suffix: Container(height: 0, width: 0),
                prefix: AssetImageWidget(
                  imageUrl: ic_date_time,
                  imageHeight: height_20,
                  imageWidth: height_20,
                  color: Colors.purple,
                ).paddingOnly(left: margin_10, right: margin_5),
                controller: controller.encounterDateTextController,
                focusNode: controller.encounterDateFocusNode),
            _commonField(
                title: strEncounterTime,
                hint: strTimeFormates,
                suffix: Container(height: 0, width: 0),
                prefix: AssetImageWidget(
                  imageUrl: ic_duty_icon,
                  imageHeight: height_20,
                  imageWidth: height_20,
                  color: Colors.purple,
                ).paddingOnly(left: margin_10, right: margin_5),
                controller: controller.encounterTimeTextController,
                focusNode: controller.encounterTimeFocusNode,
                readOnly: true),
            _commonField(
                title: strServiceProviderNameStars,
                suffix: Container(height: 0, width: 0),
                controller: controller.spNameTextController,
                focusNode: controller.spNameFocusNode,
                readOnly: true),
            _commonField(
                title: strServiceReportStar,
                suffix: Container(height: 0, width: 0),
                maxline: 5,
                controller: controller.serviceReportTextController,
                focusNode: controller.serviceReportFocusNode,
                validate: (data) => Validator.fieldChecker(
                      message: strServiceReport,
                      value: data,
                    ),
                readOnly: controller.isCompleted),
            controller.isCompleted == true ? Container() : finalButton(),
          ],
        ));
  }

  finalButton() {
    return MaterialButtonWidget(
      onPressed: () {
        if (formGlobalKey.currentState!.validate()) {
          controller.hitAddServiceReportApi();
        }
      },
      buttonText: strSaveSubmit.toUpperCase(),
    ).paddingOnly(
        top: margin_10, right: margin_30, left: margin_30, bottom: margin_30);
  }

  _commonField(
      {hint,
      title,
      controller,
      suffix,
      focusNode,
      readOnly,
      maxline,
      prefix,
      onTap,
      validate}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
                text: title,
                textStyle:
                    TextStyle(fontSize: font_14, fontWeight: FontWeight.w400))
            .paddingOnly(bottom: margin_5),
        TextFieldWidget(
          hint: hint ?? "",
          maxline: maxline ?? 1,
          minLine: maxline ?? 1,
          focusNode: focusNode,
          textController: controller,
          alignLabelWithHint: false,
          labels: false,
          onTap: onTap ?? () {},
          readOnly: readOnly ?? false,
          validate: validate,
          hintStyle: textStyleBody1()
              .copyWith(fontSize: font_14, color: Colors.grey.shade400),
          contentPadding:
              EdgeInsets.symmetric(horizontal: margin_10, vertical: margin_15),
          borders: OutlineInputBorder(
              borderRadius: BorderRadius.circular(margin_10),
              borderSide: BorderSide(color: Colors.grey)),
          suffixIcon: suffix ??
              AssetImageWidget(
                imageUrl: ic_dropdown,
                imageHeight: height_15,
                imageWidth: height_15,
                color: Colors.purple,
              ).paddingAll(margin_12),
          prefixIcon: prefix,
        ).paddingOnly(bottom: margin_20),
      ],
    ).paddingSymmetric(horizontal: margin_10);
  }

  Widget _gender() {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: margin_0,
            bottom: margin_5,
          ),
          child: _commonField(
              title: strGenderStar,
              readOnly: true,
              hint: strPleaseSelect,
              controller: controller.genderTextController,
              focusNode: controller.genderFocusNode),
        ),
        Positioned(
          bottom: -10,
          left: 20,
          right: 20,
          child: Container(
            width: margin_50,
            height: margin_0,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<AreaType>(
                menuMaxHeight: 200,
                borderRadius: BorderRadius.circular(radius_10),
                key: genderType,
                iconEnabledColor: Colors.transparent,
                items: (controller.genderList).map((AreaType value) {
                  return DropdownMenuItem<AreaType>(
                    value: value,
                    child: Container(
                        child: Text(
                      value.type.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey.shade400),
                    )),
                  );
                }).toList(),
                onChanged: (temp) {
                  controller.genderTextController?.text = temp!.type;
                  controller.genderId = temp!.id;
                  controller.update();
                },
              ),
            ).paddingSymmetric(horizontal: margin_10),
          ),
        ),
      ],
    );
  }
}
