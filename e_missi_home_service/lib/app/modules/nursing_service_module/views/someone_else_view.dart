import 'dart:io';

import 'package:e_missi_home_service/export.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class SomeOneElseViewScreen extends GetView<SomeOneElseController> {
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SomeOneElseController>(
      init: SomeOneElseController(),
      builder: (controller) {
        return Expanded(
          child: Container(
            height: Get.height,
            child: Column(
              children: [
                Divider(
                  color: Colors.grey.shade300,
                  thickness: margin_2,
                ),
                _form(context)
              ],
            ),
          ),
        );
      },
    );
  }

  _form(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          SingleChildScrollView(
            child: Form(
                key: formGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizeBox(height: height_10),
                    _name(),
                    _identificationNumber(),
                    _dob(context),
                    _age(),
                    _address(),
                    _postCodeaddress(),
                    _mobile(),
                    _email(),
                    _medicalCondition(),
                    Text(strmedicalReportFormat,
                        style: textStyleBody1()
                            .copyWith(fontSize: font_12, color: Colors.grey)),
                    sizeBox(height: height_10),
                    _medicalReportView(),
                    sizeBox(height: height_80),
                  ],
                )).paddingSymmetric(horizontal: margin_25),
          ),
          _cancelAdd(),
        ],
      ),
    );
  }

  _medicalReportView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        controller.isEdit == true
            ? Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(PdfView(
                        "${controller.documentFile?.path}",
                        isPDF: controller.extension == ".pdf" ? true : false,
                      ));
                    },
                    child: Text(
                      "${controller.fileName ?? 'Blank.pdf'}",
                      style: TextStyle(
                        fontSize: font_13,
                      ),
                    ).paddingOnly(right: margin_10),
                  ),
                  InkWell(
                    onTap: () {
                      controller.fileName = null;
                      controller.documentFile = null;
                      controller.update();
                    },
                    child: AssetImageWidget(
                      imageUrl: ic_delete_image,
                      imageFitType: BoxFit.cover,
                      imageHeight: height_20,
                    ),
                  )
                ],
              )
            : InkWell(
                onTap: () async {
                  try {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      allowedExtensions: ['pdf', 'png', "jpg"],
                      type: FileType.custom,
                    );
                    if (result != null) {
                      controller.sizeInMb =
                          (File(result.files.single.path.toString())
                                  .lengthSync() /
                              (1024 * 1024));
                      if (controller.sizeInMb! > 10) {
                        flashBar(message: strFileMaxLimit);
                      } else {
                        controller.documentFile = File(
                          result.files.single.path.toString(),
                        );
                        controller.fileName =
                            result.files.single.path.toString().split('/').last;
                        controller.update();
                      }
                    } else {
                      flashBar(message: strFilePickedCancelled);
                    }
                  } catch (e) {
                    Get.defaultDialog(
                        title: 'Permission Required!',
                        content: Column(
                          children: [
                            TextView(
                                text: 'Please enable required permission !',
                                maxLine: 3,
                                textStyle: textStyleHeading2()
                                    .copyWith(fontSize: font_14)),
                            SizedBox(
                              height: height_20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: MaterialButtonWidget(
                                  buttonText: strNo,
                                  onPressed: () {
                                    Get.back();
                                  },
                                  textColor: Colors.white,
                                ).paddingSymmetric(horizontal: margin_20)),
                                Expanded(
                                    child: MaterialButtonWidget(
                                  buttonText: 'Allow',
                                  textColor: Colors.white,
                                  onPressed: () {
                                    Get.back();
                                    openAppSettings();
                                  },
                                ).paddingSymmetric(horizontal: margin_20)),
                              ],
                            )
                          ],
                        ));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: appColor,
                      borderRadius: BorderRadius.circular(radius_5)),
                  padding: EdgeInsets.symmetric(
                      vertical: margin_5, horizontal: margin_10),
                  child: Text(
                    strMedicalReportUpload,
                    style: TextStyle(fontSize: font_14, color: Colors.white),
                  ),
                ).paddingOnly(bottom: margin_10),
              ),
        controller.fileName == null || controller.fileName == ''
            ? Container()
            : Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(PdfView(
                        "${controller.documentFile?.path}",
                        isPDF: controller.extension == ".pdf" ? true : false,
                      ));
                    },
                    child: Text(
                      "${controller.fileName ?? 'Blank.pdf'}",
                      style: TextStyle(
                        fontSize: font_13,
                      ),
                    ).paddingOnly(right: margin_10),
                  ),
                  InkWell(
                    onTap: () {
                      controller.fileName = null;
                      controller.documentFile = null;
                      controller.update();
                    },
                    child: AssetImageWidget(
                      imageUrl: ic_delete_image,
                      imageFitType: BoxFit.cover,
                      imageHeight: height_20,
                    ),
                  )
                ],
              )
      ],
    ).paddingOnly(bottom: margin_20);
  }

  _name() {
    return TextFieldWidget(
      textController: controller.nameTextController,
      focusNode: controller.nameFocusNode,
      hint: strNamePassport,
      inputFormatter: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'))],
      inputAction: TextInputAction.next,
      validate: (data) => FieldChecker.fieldChecker(data, strName),
      onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
          .requestFocus(controller.identificationFocusNode),
      inputType: TextInputType.text,
      contentPadding: EdgeInsets.only(top: margin_10),
      prefixIcon: AssetImageWidget(
        imageUrl: ic_user,
        imageHeight: height_20,
        imageWidth: height_20,
      ).paddingOnly(top: margin_10, right: margin_10),
    ).paddingSymmetric(vertical: margin_15);
  }

  _age() {
    return TextFieldWidget(
      textController: controller.ageTextController,
      focusNode: controller.ageFocusNode,
      hint: strAge,
      readOnly: true,
      contentPadding: EdgeInsets.only(top: margin_10),
      prefixIcon: AssetImageWidget(
        imageUrl: ic_age,
        imageHeight: height_20,
        imageWidth: height_20,
      ).paddingOnly(top: margin_10, right: margin_10),
    ).paddingSymmetric(vertical: margin_15);
  }

  _address() {
    return TextFieldWidget(
      textController: controller.addressTextController,
      focusNode: controller.addressFocusNode,
      hint: strAddress.toUpperCase(),
      labelText: strAddress.toUpperCase() + "*",
      onFieldSubmitted: (String val) =>
          FocusScope.of(Get.context!).requestFocus(controller.zipFocusNode),
      validate: (data) => FieldChecker.fieldChecker(data, strAddress),
      inputAction: TextInputAction.next,
      inputType: TextInputType.text,
      contentPadding: EdgeInsets.only(top: margin_10),
      prefixIcon: AssetImageWidget(
        imageUrl: ic_address,
        imageHeight: height_20,
        imageWidth: height_20,
      ).paddingOnly(top: margin_10, right: margin_10),
    ).paddingSymmetric(vertical: margin_15);
  }

  _postCodeaddress() {
    return TextFieldWidget(
      textController: controller.zipTextController,
      focusNode: controller.zipFocusNode,
      hint: strZipCode.toUpperCase(),
      labelText: strZipCode.toUpperCase() + "*",
      maxLength: 6,
      inputFormatter: [
        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]'))
      ],
      inputAction: TextInputAction.next,
      validate: (data) => FieldChecker.fieldChecker(data, strZipCode),
      onFieldSubmitted: (String val) =>
          FocusScope.of(Get.context!).requestFocus(controller.mobileFocusNode),
      inputType: TextInputType.text,
      contentPadding: EdgeInsets.only(top: margin_10),
      prefixIcon: AssetImageWidget(
        imageUrl: ic_address,
        imageHeight: height_20,
        imageWidth: height_20,
      ).paddingOnly(top: margin_10, right: margin_10),
    ).paddingSymmetric(vertical: margin_15);
  }

  _identificationNumber() {
    return TextFieldWidget(
      maxLength: 15,
      textController: controller.identificationTextController,
      focusNode: controller.identificationFocusNode,
      hint: strIdentificationNumber,
      inputFormatter: [
        FilteringTextInputFormatter.allow(RegExp('[0-9-]+')),
        MaskedTextInputFormatter(separator: '-', mask: 'xxxxxx-xx-xxxx')
      ],
      inputAction: TextInputAction.next,
      validate: (data) =>
          FieldChecker.fieldChecker(data, strIdentificatioNumber),
      onFieldSubmitted: (String val) =>
          FocusScope.of(Get.context!).requestFocus(controller.addressFocusNode),
      inputType: TextInputType.number,
      contentPadding: EdgeInsets.only(top: margin_10),
      prefixIcon: AssetImageWidget(
        imageUrl: ic_usercircle,
        imageHeight: height_20,
        imageWidth: height_20,
      ).paddingOnly(top: margin_10, right: margin_10),
    ).paddingSymmetric(vertical: margin_15);
  }

  _dob(BuildContext context) {
    return TextFieldWidget(
      textController: controller.dobTextController,
      focusNode: controller.dobFocusNode,
      hint: strDateOfBirth,
      labelText: strDob + "*",
      inputAction: TextInputAction.next,
      validate: (data) =>
          Validator.fieldChecker(value: data, message: strDateOfBirt),
      onFieldSubmitted: (String val) =>
          FocusScope.of(Get.context!).requestFocus(controller.addressFocusNode),
      inputType: TextInputType.number,
      readOnly: true,
      onTap: () async {
        var datePicked = await DatePicker.showSimpleDatePicker(
          context,
          initialDate: DateTime(1994),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          dateFormat: "dd-MMM-yyyy",
          locale: DateTimePickerLocale.en_us,
          looping: true,
        );
        if (datePicked != null) {
          final DateFormat formatter = DateFormat('yyyy-MM-dd');
          final DateFormat display = DateFormat('dd MMMM yyyy');
          controller.formatted = formatter.format(datePicked);
          final String displayDate = display.format(datePicked);
          controller.dobTextController?.text = displayDate.toString();
          calculateAge(datePicked);
          debugPrint('${displayDate.toString()}');
          controller.update();
        }
      },
      contentPadding: EdgeInsets.only(top: margin_10),
      prefixIcon: AssetImageWidget(
        imageUrl: ic_caldrgry,
        imageHeight: height_20,
        imageWidth: height_20,
      ).paddingOnly(top: margin_10, right: margin_10),
    ).paddingSymmetric(vertical: margin_15);
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return controller.ageTextController?.text = age.toString();
  }

  _email() {
    return TextFieldWidget(
      textController: controller.emailTextController,
      focusNode: controller.emailFocusNode,
      hint: strEmailAddress.toUpperCase(),
      labelText: strEmailAddress.toUpperCase() + "*",
      onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
          .requestFocus(controller.medicalConditionFocusNode),
      inputAction: TextInputAction.next,
      validate: (data) => Validator.validateEmail(data),
      inputType: TextInputType.text,
      contentPadding: EdgeInsets.only(top: margin_10),
      prefixIcon: AssetImageWidget(
        imageUrl: ic_mail,
        imageHeight: height_20,
        imageWidth: height_20,
      ).paddingOnly(top: margin_10, right: margin_10),
    ).paddingSymmetric(vertical: margin_15);
  }

  _mobile() {
    return TextFieldWidget(
      textController: controller.mobileTextController,
      focusNode: controller.mobileFocusNode,
      hint: strMobileNumberHint,
      labelText: strMobileNumber.toUpperCase() + "*",
      inputFormatter: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      validate: (data) =>
          Validator.validatePhoneNumber(data.toString().replaceAll('-', '')),
      inputAction: TextInputAction.next,
      inputType: TextInputType.phone,
      onFieldSubmitted: (String val) =>
          FocusScope.of(Get.context!).requestFocus(controller.emailFocusNode),
      contentPadding: EdgeInsets.only(top: margin_10),
      prefixIcon: AssetImageWidget(
        imageUrl: ic_mobile,
        imageHeight: height_20,
        imageWidth: height_20,
      ).paddingOnly(top: margin_10, right: margin_10),
    ).paddingSymmetric(vertical: margin_15);
  }

  _medicalCondition() {
    return TextFieldWidget(
      textController: controller.medicalConditionTextController,
      focusNode: controller.medicalConditionFocusNode,
      hint: strMedicalCondition,
      contentPadding: EdgeInsets.only(top: margin_10),
      prefixIcon: AssetImageWidget(
        imageUrl: ic_mediclegry,
        imageHeight: height_20,
        imageWidth: height_20,
      ).paddingOnly(top: margin_10, right: margin_10),
    ).paddingSymmetric(vertical: margin_15);
  }

  _cancelAdd() {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
              child: MaterialButtonWidget(
            onPressed: () {
              Get.back();
            },
            borderColor: Colors.grey,
            buttonText: strCancel,
            textColor: Colors.grey,
            buttonColor: Colors.white,
          )),
          sizeBox(width: width_20),
          Expanded(
              child: MaterialButtonWidget(
            onPressed: () {
              if (formGlobalKey.currentState!.validate()) {
                controller.hitAddDependentAccountApi();
              }
            },
            borderColor: appColor,
            buttonText: strAdd,
            textColor: Colors.white,
            buttonColor: appColor,
          )),
        ],
      ).paddingSymmetric(horizontal: margin_15, vertical: margin_15),
    );
  }
}
