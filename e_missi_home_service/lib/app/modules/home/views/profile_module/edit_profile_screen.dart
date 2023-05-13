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

class EditProfileScreen extends GetView<EditProfileController> {
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  final genderType = new GlobalKey(debugLabel: 'gender');

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

/*========================================================_body============================================*/

  _body(BuildContext context) => GetBuilder<EditProfileController>(
      init: EditProfileController(),
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: [
              AssetImageWidget(
                imageUrl: ic_maskGroup,
                imageWidth: Get.width,
                imageHeight: height_150,
                imageFitType: BoxFit.fill,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appBar(),
                  profileImage(),
                  formWidget(context),
                ],
              ).paddingSymmetric(horizontal: margin_20, vertical: margin_5),
            ],
          ),
        );
      });

  appBar() {
    return appBarView2(
      title: '',
      widget: controller.edit == false
          ? InkWell(
              onTap: () {
                controller.edit = true;
                debugPrint(
                    ' Files ${controller.profileImageFile} ${controller.loginResponseModel.detail?.profileFile} ${controller.loginResponseModel.detail?.medicalReport}');
                controller.update();
                debugPrint(controller.edit.toString());
              },
              child: TextView(
                  text: strEdit,
                  textStyle: textStyleHeading2().copyWith(color: Colors.black)),
            )
          : Container(),
    );
  }

  profileImage() {
    return Center(
      child: Stack(children: [
        controller.profileImageFile != null && controller.profileImageFile != ''
            ? _selectedImage()
            : controller.loginResponseModel.detail?.profileFile != null &&
                    controller.loginResponseModel.detail?.profileFile.isNotEmpty
                ? _networkImage()
                : _assetImage(),
        Positioned(
            bottom: 0,
            right: 0,
            child: controller.edit == false
                ? Container()
                : InkWell(
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
                      imageHeight: height_25,
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
      );

  _networkImage() => NetworkImageWidget(
        radiusAll: radius_100,
        imageHeight: height_90,
        placeHolder: controller.loginResponseModel.detail?.gender == 0
            ? ICON_avatar
            : ICON_avatar_female,
        imageUrl: "${controller.loginResponseModel.detail?.profileFile ?? ''}",
      );

  _assetImage() {
    return AssetImageWidget(
      radiusAll: radius_100,
      imageHeight: height_90,
      imageUrl: controller.loginResponseModel.detail?.gender == 0
          ? ICON_avatar
          : ICON_avatar_female,
    );
  }

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
                _identificationTextField().paddingOnly(bottom: margin_20),
                contactController().paddingOnly(bottom: margin_20),
                addressController().paddingOnly(bottom: margin_20),
                _zipCodeaddress().paddingOnly(bottom: margin_20),
                breifMdeicalConditionController()
                    .paddingOnly(bottom: margin_20),
                controller.loginResponseModel.detail?.medicalReport == '' &&
                        controller.edit == false
                    ? Container()
                    : pdfTxtView(),
                controller.edit == false
                    ? Container()
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
                                      controller
                                          .updateDocumentFile(imageFromCamera());
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
                          child: TextView(
                                  text: strMedicalReport,
                                  textStyle: textStyleBody2()
                                      .copyWith(color: Colors.white))
                              .paddingSymmetric(
                                  horizontal: margin_20, vertical: margin_5),
                          decoration: BoxDecoration(
                              color: darkPurple,
                              borderRadius: BorderRadius.circular(radius_5)),
                        ).paddingOnly(bottom: margin_10),
                      ),
                controller.fileName == null || controller.fileName == ''
                    ? Row(
                        children: [
                          controller.loginResponseModel.detail?.medicalReport ==
                                  ''
                              ? Container()
                              : InkWell(
                                  onTap: () {
                                    Get.to(PdfView(
                                      "${imageBaseUrl}${controller.loginResponseModel.detail?.medicalReport}",
                                      isNetwork: true,
                                      isPDF: controller.loginResponseModel
                                              .detail!.medicalReport
                                              .toString()
                                              .contains(".pdf")
                                          ? true
                                          : false,
                                    ));
                                  },
                                  child: TextView(
                                    text:
                                        "${controller.loginResponseModel.detail?.medicalReport.toString().split("_").last}",
                                    textStyle: textStyleBody2()
                                        .copyWith(color: Colors.black),
                                  ).paddingOnly(right: margin_10),
                                ),
                          controller.edit == false
                              ? Container()
                              : controller.documentFile == null
                                  ? Container()
                                  : InkWell(
                                      onTap: () {
                                        controller.loginResponseModel.detail
                                            ?.medicalReport = '';
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
                      ).paddingOnly(bottom: margin_20)
                    : Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(PdfView(
                                "${controller.documentFile?.path}",
                                isPDF: controller.documentFile!.path
                                        .contains(".pdf")
                                    ? true
                                    : false,
                              ));
                            },
                            child: Text(
                              "${controller.fileName}",
                              style: TextStyle(
                                fontSize: font_13,
                              ),
                            ).paddingOnly(right: margin_10),
                          ),
                          controller.edit == false
                              ? Container()
                              : InkWell(
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
                      ).paddingOnly(bottom: margin_20),
                _dob(context).paddingOnly(bottom: margin_20),
                _gender().paddingOnly(bottom: margin_20),
                emailController().paddingOnly(bottom: margin_20),
                controller.edit == false ? Container() : passwordColumn(),
                controller.edit == false ? Container() : rowButton()
              ],
            ),
          ),
        ],
      ),
    );
  }

  passwordColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
                text: strChangePassword,
                textStyle: textStyleHeading2().copyWith(color: Colors.black))
            .paddingOnly(bottom: margin_20),
        _oldPasswordText().paddingOnly(bottom: margin_20),
        _newPasswordText().paddingOnly(bottom: margin_20),
        _confirmPasswordText().paddingOnly(bottom: margin_20),
      ],
    );
  }

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget _nameTextField() => TextFieldWidget(
        shadow: true,
        maxLength: 25,
        readOnly: controller.edit == false ? true : false,
        focusNode: controller.nameFocusNode,
        textController: controller.nameTextController,
        errorColor: Colors.white,
        labelText: strNameAsPerPass,
        hint: strNameAsPerPassss,
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'))
        ],
        validate: (data) => FieldChecker.fieldChecker(data, strName),
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.identificationFocusNode),
        inputAction: TextInputAction.next,
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

  TextFieldWidget _zipCodeaddress() => TextFieldWidget(
        shadow: true,
        focusNode: controller.zipFocusNode,
        textController: controller.zipTextController,
        errorColor: Colors.white,
        maxLength: 15,
        hint: strPostCodeStarss,
        readOnly: controller.edit == false ? true : false,
        labelText: strPostCodeStar,
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]'))
        ],
        inputAction: TextInputAction.next,
        validate: (data) => FieldChecker.fieldChecker(data, strZipCode),
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.medicalConditionFocusNode),
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

  TextFieldWidget _identificationTextField() => TextFieldWidget(
        shadow: true,
        readOnly: controller.edit == false ? true : false,
        focusNode: controller.identificationFocusNode,
        textController: controller.identificationTextController,
        errorColor: Colors.white,
        validate: (data) =>
            FieldChecker.fieldChecker(data, strIdentificatioNumber),
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.mobileFocusNode),
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp('[0-9-]+')),
          MaskedTextInputFormatter(separator: '-', mask: 'xxxxxx-xx-xxxx')
        ],
        hint: strIdentificationNumberss,
        labelText: strIdentificationNumber,
        inputAction: TextInputAction.next,
        inputType: TextInputType.number,
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

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget addressController() => TextFieldWidget(
        shadow: true,
        readOnly: controller.edit == false ? true : false,
        focusNode: controller.addressFocusNode,
        textController: controller.addressTextController,
        errorColor: Colors.white,
        hint: strAddressStarss,
        labelText: strAddressStar,
        validate: (data) => FieldChecker.fieldChecker(data, strAddress),
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.medicalConditionFocusNode),
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

  TextFieldWidget _dob(BuildContext context) => TextFieldWidget(
        shadow: true,
        readOnly: true,
        onTap: () async {
          if (controller.edit == true) {
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
              controller.update();
            }
          }
        },
        focusNode: controller.dobFocusNode,
        textController: controller.dobTextController,
        errorColor: Colors.white,
        hint: strDateOfBirth,
        labelText: strDateOfBirthss,
        inputAction: TextInputAction.next,
        validate: (data) =>
            Validator.fieldChecker(value: data, message: strDateOfBirth),
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
              labelText: strGender + "*",
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
                  scale: 0.6,
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
        readOnly: true,
        focusNode: controller.emailFocusNode,
        textController: controller.emailTextController,
        errorColor: Colors.white,
        hint: strEmailAddres,
        labelText: strEmailAddresss,
        validate: (data) => Validator.validateEmail(data),
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.passwordFocusNode),
        inputAction: TextInputAction.next,
        inputType: TextInputType.text,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_mail,
            ),
          ),
        ),
      );

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget contactController() => TextFieldWidget(
        shadow: true,
        readOnly: true,
        focusNode: controller.mobileFocusNode,
        textController: controller.mobileTextController,
        errorColor: Colors.white,
        inputFormatter: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        labelText: strMobileNumberStar,
        hint: strMobileNumber,
        validate: (data) => FieldChecker.fieldChecker(data, strMobileNumber),
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.addressFocusNode),
        inputAction: TextInputAction.next,
        inputType: TextInputType.text,
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
        readOnly: controller.edit == false ? true : false,
        focusNode: controller.medicalConditionFocusNode,
        textController: controller.medicalConditionTextController,
        errorColor: Colors.white,
        hint: strBriefMedicalCondition,
        inputAction: TextInputAction.next,
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

  pdfTxtView() {
    return TextView(
            text: strLessThanMb,
            textStyle: textStyleBody2().copyWith(color: Colors.grey))
        .paddingOnly(bottom: margin_10);
  }

  /* ============================================================= password edit text ========================================================*/

  TextFieldWidget _oldPasswordText() => TextFieldWidget(
      shadow: true,
      focusNode: controller.passwordFocusNode,
      textController: controller.passwordTextController,
      errorColor: Colors.white,
      inputFormatter: [FilteringTextInputFormatter.deny(' ')],
      labelText: strOldPassword,
      hint: strPasswordHint,
      obscureText: !controller.isOldHide,
      onChange: (value) {
        if (value.isNotEmpty == true) {
          controller.isOldPassWord = true;
        } else {
          controller.isOldPassWord = false;
        }
        controller.update();
      },
      validate: (data) {
        var pattern = r'^(?=.*?[a-z])(?=.*?[0-9])';
        RegExp regExp = RegExp(pattern);
        if (data.isNotEmpty) {
          if (data.length < 8) {
            return strInvalidPassword;
          } else if (!regExp.hasMatch(data)) {
            return strIInvalidPassword;
          }
          return null;
        }
      },
      inputAction: TextInputAction.next,
      onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
          .requestFocus(controller.newPasswordFocusNode),
      inputType: TextInputType.visiblePassword,
      contentPadding: EdgeInsets.only(top: margin_10),
      prefixIcon: Center(
        child: Transform.scale(
          scale: 0.6,
          child: AssetImageWidget(
            imageUrl: ic_password_image,
          ),
        ),
      ),
      suffixIcon: InkWell(
        onTap: () {
          controller.isOldHide = !controller.isOldHide;
          controller.update();
        },
        child: Transform.scale(
          scale: 0.4,
          child: AssetImageWidget(
            imageUrl:
                controller.isOldHide == false ? ic_eye_hide : ic_eye_unhide,
          ),
        ),
      ));

  /* ============================================================= new password edit text ========================================================*/

  TextFieldWidget _newPasswordText() => TextFieldWidget(
        shadow: true,
        focusNode: controller.newPasswordFocusNode,
        textController: controller.newPasswordTextController,
        errorColor: Colors.white,
        labelText: strNewPasssword,
        hint: strPasswordHint,
        inputAction: TextInputAction.next,
        obscureText: !controller.isHide,
        inputFormatter: [FilteringTextInputFormatter.deny(' ')],
        validate: (data) => controller.isOldPassWord == true
            ? PasswordFormValidator.validate(data)
            : null,
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.confirmFocusNode),
        inputType: TextInputType.visiblePassword,
        contentPadding: EdgeInsets.only(top: margin_10),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_password_image,
            ),
          ),
        ),
        suffixIcon: InkWell(
          onTap: () {
            controller.isHide = !controller.isHide;
            controller.update();
          },
          child: Transform.scale(
            scale: 0.4,
            child: AssetImageWidget(
              imageUrl:
                  controller.isHide == false ? ic_eye_hide : ic_eye_unhide,
            ),
          ),
        ),
      );

  /* ============================================================= confirm password edit text ========================================================*/

  TextFieldWidget _confirmPasswordText() => TextFieldWidget(
        shadow: true,
        focusNode: controller.confirmFocusNode,
        textController: controller.confirmTextController,
        errorColor: Colors.white,
        labelText: strConfirmPassword,
        hint: strPasswordHint,
        inputAction: TextInputAction.next,
        inputFormatter: [FilteringTextInputFormatter.deny(' ')],
        obscureText: !controller.isComHide,
        validate: (data) => controller.isOldPassWord == true
            ? PasswordFormValidator.validatePasswordMatch(
                value: data,
                confirmPassword: controller.newPasswordTextController?.text)
            : null,
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!).dispose(),
        inputType: TextInputType.visiblePassword,
        contentPadding: EdgeInsets.only(top: margin_10),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_password_image,
            ),
          ),
        ),
        suffixIcon: InkWell(
          onTap: () {
            controller.isComHide = !controller.isComHide;
            controller.update();
          },
          child: Transform.scale(
            scale: 0.4,
            child: AssetImageWidget(
              imageUrl:
                  controller.isComHide == false ? ic_eye_hide : ic_eye_unhide,
            ),
          ),
        ),
      );

  rowButton() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              child: TextView(
                      text: strCancel,
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
                if (controller.edit == true) {
                  controller.hitUpdateAccountApi();
                }
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
    ).paddingOnly(bottom: margin_40);
  }
}
