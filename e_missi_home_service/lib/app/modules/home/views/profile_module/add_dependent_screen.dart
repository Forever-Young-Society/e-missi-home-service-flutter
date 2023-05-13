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
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class AddDependentScreen extends GetView<AddDependentController> {
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  final genderType = new GlobalKey(debugLabel: 'gender');

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

/*========================================================_body============================================*/

  _body(BuildContext context) => GetBuilder<AddDependentController>(
      init: AddDependentController(),
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                width: Get.width,
                height: height_150,
                color: lightPink,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appBarView2(title: strAddDependent),
                  profileImage(),
                  formWidget(context),
                ],
              ).paddingSymmetric(horizontal: margin_20, vertical: margin_5),
            ],
          ),
        );
      });

  profileImage() {
    return Center(
      child: Stack(children: [
        controller.profileImageFile != null && controller.profileImageFile != ''
            ? _selectedImage()
            : AssetImageWidget(imageUrl: ic_defaultUser, imageHeight: height_90)
                .paddingOnly(top: margin_15),
        Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                Get.bottomSheet(ImagePickerDialogWidget(
                  galleryFunction: () {
                    Get.back();
                    controller.updateImageFile(imageFromGallery());
                    controller.update();
                  },
                  cameraFunction: () {
                    Get.back();
                    controller.updateImageFile(imageFromCamera());
                    controller.update();
                  },
                  title: strProfileImage,
                  voidCallback: (data) {
                    debugPrint("data");
                  },
                  recordId: 0,
                  action: strProfileImage,
                ));
              },
              child: AssetImageWidget(
                imageUrl: ic_Add,
                imageHeight: height_30,
              ),
            )),
      ]).paddingOnly(bottom: margin_5),
    );
  }

  _selectedImage() => ClipRRect(
        borderRadius: BorderRadius.circular(radius_100),
        child: Image.file(
          File('${controller.profileImageFile.toString()}'),
          height: height_90,
          fit: BoxFit.cover,
        ),
      ).paddingOnly(top: margin_15);

  formWidget(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Form(
            key: formGlobalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _nameTextField().paddingOnly(bottom: margin_20),
                _identificationNumber().paddingOnly(bottom: margin_20),
                dobController(context).paddingOnly(bottom: margin_20),
                ageController().paddingOnly(bottom: margin_20),
                _gender().paddingOnly(bottom: margin_20),
                addressController().paddingOnly(bottom: margin_20),
                _zipCodeaddress().paddingOnly(bottom: margin_20),
                contactController().paddingOnly(bottom: margin_20),
                emailController().paddingOnly(bottom: margin_20),
                breifMdeicalConditionController()
                    .paddingOnly(bottom: margin_10),
                lessThanThreemMbText(),
                _medicalReportView(),
                rowBottuon(),
              ],
            ),
          ),
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
                        isPDF: controller.documentFile!.path
                                .toString()
                                .endsWith("pdf")
                            ? true
                            : false,
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
                  requestPermissions([Permission.camera, Permission.storage],
                    (data) {
                      Get.bottomSheet(ImagePickerDialogWidget(
                        galleryFunction: () {
                          Get.back();
                          controller.updateDocumentFilePDF();
                          controller.update();
                        },
                        cameraFunction: () {
                          Get.back();
                          controller.updateDocumentFile(imageFromCamera());
                          controller.update();
                        },
                        title: strProfileImage,
                        voidCallback: (data) {
                          debugPrint("data");
                        },
                        recordId: 0,
                        action: strProfileImage,
                      ));
                    },
                  );
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
                        isPDF: false,
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

  lessThanThreemMbText() {
    return TextView(
            text: strLessDAta,
            textStyle: textStyleBody2().copyWith(color: Colors.grey))
        .paddingOnly(bottom: margin_10);
  }

  rowBottuon() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              if (controller.isEdit == true) {
                logoutDialog(
                    textfeild: false,
                    text: strConfirmRemoveDependent,
                    confirmText: strConfirm,
                    onTap: () {
                      Get.back();
                    });
              } else {
                controller.clearEditText();
              }
            },
            child: Container(
              child: TextView(
                      text: controller.isEdit == true ? strRemove : strCancel,
                      textStyle: textStyleBody2().copyWith(color: Colors.grey))
                  .paddingSymmetric(horizontal: margin_20, vertical: margin_13),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radius_5)),
            ).paddingOnly(bottom: margin_5, right: margin_20),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              if (formGlobalKey.currentState!.validate()) {
                controller.hitAddDependentAccountApi();
              }
            },
            child: Container(
              child: TextView(
                      text: strSave,
                      textStyle: textStyleBody2().copyWith(color: Colors.white))
                  .paddingSymmetric(horizontal: margin_20, vertical: margin_15),
              decoration: BoxDecoration(
                  color: darkPurple,
                  borderRadius: BorderRadius.circular(radius_5)),
            ).paddingOnly(bottom: margin_5),
          ),
        ),
      ],
    ).paddingOnly(bottom: margin_20);
  }

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget _nameTextField() => TextFieldWidget(
        shadow: true,
        focusNode: controller.nameFocusNode,
        textController: controller.nameTextController,
        errorColor: Colors.white,
        hint: strNameIcPassport,
        inputAction: TextInputAction.next,
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'))
        ],
        validate: (data) => FieldChecker.fieldChecker(data, strName),
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.identificationFocusNode),
        inputType: TextInputType.text,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_user,
            ),
          ),
        ),
      );

  /* ============================================================= _identificationNumber edit text ========================================================*/

  TextFieldWidget _identificationNumber() => TextFieldWidget(
        shadow: true,
        focusNode: controller.identificationFocusNode,
        textController: controller.identificationTextController,
        errorColor: Colors.white,
        maxLength: 15,
        hint: strIdentificationNumberss,
        labelText: strIdentificationNumber,
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp('[0-9-]+')),
          MaskedTextInputFormatter(separator: '-', mask: 'xxxxxx-xx-xxxx')
        ],
        inputAction: TextInputAction.next,
        validate: (data) =>
            FieldChecker.fieldChecker(data, strIdentificatioNumber),
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.addressFocusNode),
        inputType: TextInputType.number,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_identification_image,
            ),
          ),
        ),
      );

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget ageController() => TextFieldWidget(
        shadow: true,
        readOnly: true,
        focusNode: controller.ageFocusNode,
        textController: controller.ageTextController,
        errorColor: Colors.white,
        hint: strAges,
        maxLength: 2,
        inputFormatter: [FilteringTextInputFormatter.digitsOnly],
        validate: (data) => FieldChecker.fieldChecker(data, strAges),
        inputAction: TextInputAction.next,
        inputType: TextInputType.text,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_Age,
            ),
          ),
        ),
      );

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
    return controller.ageTextController!.text = age.toString();
  }

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget addressController() => TextFieldWidget(
        shadow: true,
        validate: (data) => FieldChecker.fieldChecker(data, strAddress),
        focusNode: controller.addressFocusNode,
        textController: controller.addressTextController,
        errorColor: Colors.white,
        hint: strAddress,
        inputAction: TextInputAction.next,
        inputType: TextInputType.text,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_address,
            ),
          ),
        ),
      );

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget _zipCodeaddress() => TextFieldWidget(
        shadow: true,
        focusNode: controller.zipFocusNode,
        textController: controller.zipTextController,
        errorColor: Colors.white,
        maxLength: 15,
        hint: strPostCodeStarss,
        labelText: strPostCodeStar,
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]'))
        ],
        inputAction: TextInputAction.next,
        validate: (data) => FieldChecker.fieldChecker(data, strZipCode),
        onFieldSubmitted: (String val) =>
            FocusScope.of(Get.context!).requestFocus(controller.emailFocusNode),
        inputType: TextInputType.text,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_address_image,
            ),
          ),
        ),
      );

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget dobController(BuildContext context) => TextFieldWidget(
        shadow: true,
        focusNode: controller.dobFocusNode,
        textController: controller.dobTextController,
        errorColor: Colors.white,
        labelText: strDob + "*",
        hint: strDob,
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
            controller.update();
          }
        },
        inputAction: TextInputAction.next,
        validate: (data) =>
            Validator.fieldChecker(value: data, message: strDateOfBirt),
        onFieldSubmitted: (String val) =>
            FocusScope.of(Get.context!).requestFocus(controller.emailFocusNode),
        inputType: TextInputType.number,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_dob_image,
            ),
          ),
        ),
      );

  /* ============================================================= Gender edit text ========================================================*/

  Widget _gender() {
    return Stack(
      children: [
        Padding(
            padding: EdgeInsets.only(
              top: margin_0,
              bottom: margin_5,
            ),
            child: TextFieldWidget(
              shadow: true,
              readOnly: true,
              focusNode: controller.genderFocusNode,
              textController: controller.genderTextController,
              errorColor: Colors.white,
              hint: strGender,
              labelText: strGender,
              onTap: () {
                openDropdown(genderType);
              },
              inputAction: TextInputAction.next,
              validate: (data) =>
                  Validator.fieldChecker(value: data, message: strGender),
              onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
                  .requestFocus(controller.genderFocusNode),
              inputType: TextInputType.number,
              contentPadding: EdgeInsets.only(top: margin_5),
              prefixIcon: Center(
                child: Transform.scale(
                  scale: 0.55,
                  child: AssetImageWidget(
                    imageUrl: controller.genderId.toString() == "0"
                        ? ic_male
                        : controller.genderId.toString() == "1"
                            ? ic_female
                            : ic_gender_image,
                  ),
                ),
              ),
            )),
        Positioned(
          bottom: -34,
          left: 20,
          right: 25,
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
            ),
          ),
        ),
      ],
    );
  }

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget emailController() => TextFieldWidget(
        shadow: true,
        focusNode: controller.emailFocusNode,
        textController: controller.emailTextController,
        errorColor: Colors.white,
        labelText: strEmailAddressStar,
        hint: strEmailAddress,
        inputAction: TextInputAction.next,
        validate: (data) => Validator.validateEmail(data),
        inputType: TextInputType.text,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.7,
            child: AssetImageWidget(
              imageUrl: ic_mail,
            ),
          ),
        ),
      );

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget contactController() => TextFieldWidget(
        shadow: true,
        maxLength: 15,
        focusNode: controller.mobileFocusNode,
        textController: controller.mobileTextController,
        errorColor: Colors.white,
        hint: strMobileNumber,
        inputFormatter: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        validate: (data) =>
            Validator.validatePhoneNumber(data.toString().replaceAll('-', '')),
        inputAction: TextInputAction.next,
        inputType: TextInputType.phone,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_mobile,
            ),
          ),
        ),
      );

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget breifMdeicalConditionController() => TextFieldWidget(
        shadow: true,
        focusNode: controller.medicalConditionFocusNode,
        textController: controller.medicalConditionTextController,
        errorColor: Colors.white,
        hint: strBriefMedicalCondition,
        inputAction: TextInputAction.done,
        inputType: TextInputType.text,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_mediclegry,
            ),
          ),
        ),
      );
}
