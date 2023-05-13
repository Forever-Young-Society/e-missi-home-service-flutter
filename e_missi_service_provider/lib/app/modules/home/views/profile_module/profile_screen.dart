/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'dart:io';

import 'package:e_missi_service_provider/app/core/utils/image_picker.dart';
import 'package:e_missi_service_provider/export.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';

class ProfileScreen extends GetView<ProfileController> {
  final stateType = new GlobalKey(debugLabel: 'State Type');
  final genderType = new GlobalKey(debugLabel: 'gender');

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

/*========================================================_body============================================*/

  _body(BuildContext context) => GetBuilder<ProfileController>(
        init: ProfileController(),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    appBarView2(
                      title: strAddDependent,
                    ),
                    Container(
                      width: height_120,
                      child: Stack(alignment: Alignment.bottomRight, children: [
                        controller.documentFile2 != null
                            ? Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(radius_10),
                                        topLeft: Radius.circular(radius_10),
                                        bottomLeft: Radius.circular(radius_10),
                                        bottomRight:
                                            Radius.circular(radius_10))),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(radius_10),
                                  child: Image.file(File(controller.documentFile2.toString() ?? "",),
                                    fit: BoxFit.fill,
                                    height: height_120,
                                    width: height_120,
                                  ),
                                ),
                              )
                            : controller.loginResponseModel?.detail
                                            ?.profileFile !=
                                        null &&
                                    controller.loginResponseModel?.detail
                                        ?.profileFile.isNotEmpty
                                ? Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.only(
                                            topRight:
                                                Radius.circular(radius_10),
                                            topLeft: Radius.circular(radius_10),
                                            bottomLeft:
                                                Radius.circular(radius_10),
                                            bottomRight:
                                                Radius.circular(radius_10))),
                                    child: NetworkImageWidget(
                                      imageUrl:
                                          "${controller.loginResponseModel?.detail?.profileFile}",
                                      imageHeight: height_120,
                                      imageWidth: height_120,
                                      imageFitType: BoxFit.fill,
                                      radiusTopRight: radius_10,
                                      radiusTopLeft: radius_10,
                                      radiusBottomLeft: radius_10,
                                      radiusBottomRight: radius_10,
                                      errorImage: controller.loginResponseModel
                                                  ?.detail?.gender ==
                                              0
                                          ? ICON_avatar
                                          : ICON_avatar_female,
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.only(
                                            topRight:
                                                Radius.circular(radius_10),
                                            topLeft: Radius.circular(radius_10),
                                            bottomLeft:
                                                Radius.circular(radius_10),
                                            bottomRight:
                                                Radius.circular(radius_10))),
                                    child: AssetImageWidget(
                                      imageUrl: ic_user_default,
                                      imageHeight: height_120,
                                      imageWidth: height_120,
                                      imageFitType: BoxFit.fill,
                                      radiusTopRight: radius_10,
                                      radiusTopLeft: radius_10,
                                      radiusBottomLeft: radius_10,
                                      radiusBottomRight: radius_10,
                                    ),
                                  ),
                        InkWell(
                            onTap: () async {
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
                              // try {
                              //   FilePickerResult? result =
                              //       await FilePicker.platform.pickFiles(
                              //     allowedExtensions: ['png', "jpg"],
                              //     type: FileType.custom,
                              //   );
                              //   if (result != null) {
                              //     controller.sizeInMb =
                              //         (File(result.files.single.path.toString())
                              //                 .lengthSync() /
                              //             (1024 * 1024));
                              //     if (controller.sizeInMb! > 10) {
                              //       flashBar(message: strFilemaxlimitexceed);
                              //     } else {
                              //       controller.documentFile2 = File(
                              //         result.files.single.path.toString(),
                              //       );
                              //       controller.fileName2 = result
                              //           .files.single.path
                              //           .toString()
                              //           .split('/')
                              //           .last;
                              //       controller.update();
                              //     }
                              //   } else {
                              //     flashBar(message: strFilepickedCancel);
                              //   }
                              //
                              //   if (result != null) {
                              //     controller.extension2 = p.extension(controller
                              //             .documentFile2?.path
                              //             .toString() ??
                              //         "");
                              //   }
                              // } catch (e) {
                              //   Get.defaultDialog(
                              //       title: 'Permission Required!',
                              //       content: Column(
                              //         children: [
                              //           TextView(
                              //               text:
                              //                   'Please enable required permission !',
                              //               maxLine: 3,
                              //               textStyle: textStyleHeading2()
                              //                   .copyWith(fontSize: font_14)),
                              //           SizedBox(
                              //             height: height_20,
                              //           ),
                              //           Row(
                              //             children: [
                              //               Expanded(
                              //                   child: MaterialButtonWidget(
                              //                 buttonText: strNo,
                              //                 onPressed: () {
                              //                   Get.back();
                              //                 },
                              //                 textColor: Colors.white,
                              //               ).paddingSymmetric(
                              //                       horizontal: margin_20)),
                              //               Expanded(
                              //                   child: MaterialButtonWidget(
                              //                 buttonText: 'Allow',
                              //                 textColor: Colors.white,
                              //                 onPressed: () {
                              //                   Get.back();
                              //                   openAppSettings();
                              //                 },
                              //               ).paddingSymmetric(
                              //                       horizontal: margin_20)),
                              //             ],
                              //           )
                              //         ],
                              //       ));
                              // }
                            },
                            child: controller.isEdit == false
                                ? Container()
                                : AssetImageWidget(
                                    imageUrl: ic_Add,
                                    imageHeight: height_25,
                                  ).paddingAll(margin_5)),
                      ]).paddingOnly(bottom: margin_20),
                    ),
                    formWidget(context),
                  ],
                ).paddingOnly(
                    left: margin_20, right: margin_20, top: margin_10),
              ],
            ),
          );
        },
      );

  _firstButton() {
    return Expanded(
      child: InkWell(
        onTap: () {
          controller.isEdit = false;
          controller.update();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius_5),
            border: Border.all(color: Colors.grey),
          ),
          child: TextView(
                  text: strCancel,
                  textStyle: textStyleBody2().copyWith(color: Colors.grey))
              .paddingSymmetric(vertical: margin_10),
        ),
      ),
    );
  }

  _secondButton() {
    return Expanded(
      child: InkWell(
        onTap: () {
          validateData();
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius_5), color: darkPurple),
          child: TextView(
                  text: strSaveSubmit,
                  textStyle: textStyleBody2().copyWith(color: Colors.white))
              .paddingSymmetric(vertical: margin_10),
        ),
      ),
    );
  }

  formWidget(BuildContext context) {
    return Expanded(
      child: ListView(
        controller: controller.scrollController,
        children: [
          Form(
            key: controller.formGlobalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _nameTextField().paddingOnly(bottom: margin_20),
                _identificationNumber().paddingOnly(bottom: margin_20),
                _dob(context).paddingOnly(bottom: margin_20),
                _gender().paddingOnly(bottom: margin_20),
                _mobileNumber().paddingOnly(bottom: margin_20),
                _emailAddress().paddingOnly(bottom: margin_20),
                _address().paddingOnly(bottom: margin_20),
                _workingZone().paddingOnly(bottom: margin_10),
                _workingExperience().paddingOnly(bottom: margin_20),
                _headingTxt(title: strQualification.toUpperCase()),
                _commonList(list: controller.categoryList),
                _divider(),
                _serviceSkilled()
                    .paddingOnly(bottom: margin_20, top: margin_10),
                ExpandedSection(
                  child: _subCommonList(list: controller.subCategoryList),
                  expand: controller.joinVar!.length != 0 ||
                      controller.categoryList?.length != 0,
                ),
                _headingTxt(
                    title: strQualificationDocuments.toUpperCase(),
                    paddingBottom: margin_10),
                _chooseFileView(),
                ExpandedSection(
                  child: _uploadedCertificateView(),
                  expand: controller.fileName != null ||
                      controller.loginResponseModel?.detail?.files?.length !=
                          null,
                ),
                ExpandedSection(
                  child: _newUploadedCertificateView(
                      title: controller.fileNameNew),
                  expand: controller.fileNameNew != null,
                ),
                _headingTxt(
                    title: strLanguagesStar.toUpperCase(),
                    paddingTop: margin_10),
                _languageList(list: controller.languageList),
                ExpandedSection(
                  child: passwordView(),
                  expand: controller.isEdit == true,
                )
              ],
            ),
          ),
          controller.isEdit == true
              ? Row(
                  children: [
                    _firstButton(),
                    SizedBox(
                      width: margin_20,
                    ),
                    _secondButton()
                  ],
                ).paddingOnly(top: margin_10, bottom: margin_20)
              : Container(height: 0, width: 0),
        ],
      ),
    );
  }

  passwordView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _divider(),
        TextView(
                text: strChangePassword,
                textStyle:
                    TextStyle(fontSize: font_16, fontWeight: FontWeight.bold))
            .paddingOnly(top: margin_10, bottom: margin_5),
        _oldPasswordText().paddingOnly(bottom: margin_20, top: margin_10),
        _passwordText().paddingOnly(bottom: margin_20, top: margin_10),
        _confirmPasswordText().paddingOnly(bottom: margin_30),
      ],
    );
  }

  _subCommonList({list}) {
    return list?.length == null || list.length == 0
        ? Center(
            child: TextView(
              text: strNoSkilledAdded,
              textStyle: TextStyle(color: Colors.grey.shade400),
            ),
          ).paddingOnly(bottom: margin_10)
        : ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: list?.length ?? 0,
            itemBuilder: (context, index) {
              SkillDataModel item = list[index];
              return item.subSkills != null && item.subSkills!.length != 0
                  ? Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                          childrenPadding:
                              EdgeInsets.symmetric(horizontal: margin_20),
                          iconColor: appColor,
                          collapsedIconColor: appColor,
                          tilePadding: EdgeInsets.zero,
                          title: Text(item.title, style: textStyleHeading2()),
                          children: [
                            ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return checkTitleText(
                                    tick: item.subSkills![index].isSelected,
                                    title: item.subSkills![index].title,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: height_10);
                                },
                                itemCount: item.subSkills?.length ?? 0)
                          ]),
                    )
                  : checkTitleText(
                      tick: item.isSelected,
                      title: item.title,
                    );
            }).paddingOnly(bottom: margin_20);
  }

/* ============================================================= name edit text ========================================================*/

  TextFieldWidget _nameTextField() => TextFieldWidget(
        shadow: true,
        focusNode: controller.nameFocusNode,
        textController: controller.nameTextController,
        errorColor: Colors.white,
        labelText: strNameAsPerPass,
        hint: strNameAsPerPassSS,
        readOnly: !controller.isEdit,
        inputAction: TextInputAction.next,
        validate: (data) => Validator.fieldChecker(
          message: strNameAsPerPassSS,
          value: data,
        ),
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.identificationFocusNode),
        inputType: TextInputType.text,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_name_image,
            ),
          ),
        ),
      );

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget _identificationNumber() => TextFieldWidget(
        shadow: true,
        focusNode: controller.identificationFocusNode,
        textController: controller.identificationTextController,
        errorColor: Colors.white,
        readOnly: !controller.isEdit,
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp('[0-9-]+')),
          MaskedTextInputFormatter(separator: '-', mask: 'xxxxxx-xx-xxxx')
        ],
        labelText: strIdentificationNumber,
        hint: strIdentificationNumberSS,
        inputAction: TextInputAction.next,
        validate: (data) => Validator.fieldChecker(
          message: strIdentificationNumberSS,
          value: data,
        ),
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.mobileFocusNode),
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

  TextFieldWidget _mobileNumber() => TextFieldWidget(
        shadow: true,
        readOnly: true,
        focusNode: controller.mobileFocusNode,
        textController: controller.mobileTextController,
        errorColor: Colors.white,
        labelText: strMobileNumberStar,
        hint: strMobileNumberStarSS,
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        inputAction: TextInputAction.next,
        maxLength: 15,
        validate: (data) =>
            Validator.validatePhoneNumber(data.toString().replaceAll('-', '')),
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.addressFocusNode),
        inputType: TextInputType.number,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_mobile_image,
            ),
          ),
        ),
      );

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget _address() => TextFieldWidget(
        shadow: true,
        focusNode: controller.addressFocusNode,
        textController: controller.addressTextController,
        errorColor: Colors.white,
        readOnly: !controller.isEdit,
        labelText: strHomeAddressStar,
        hint: strHomeAddressStarSS,
        inputAction: TextInputAction.next,
        validate: (data) => Validator.fieldChecker(
          message: strHomeAddressStarSS,
          value: data,
        ),
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

  TextFieldWidget _workingZone() => TextFieldWidget(
        shadow: true,
        focusNode: controller.workZoneFocusNode,
        textController: controller.workZoneController,
        errorColor: Colors.white,
        readOnly: true,
        labelText: strWorkingZoneStar,
        hint: strWorkingZoneStarSS,
        inputAction: TextInputAction.next,
        onTap: () {
          if (controller.isEdit) {
            _inviteMembersDialog(controller);
          }
        },
        validate: (data) => Validator.fieldChecker(
          message: strWorkingZoneStar,
          value: data,
        ),
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.medicalConditionFocusNode),
        inputType: TextInputType.text,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_working_zone_image,
            ),
          ),
        ),
      );

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget _workingExperience() => TextFieldWidget(
        shadow: true,
        focusNode: controller.workExperienceFocusNode,
        textController: controller.workExperienceController,
        errorColor: Colors.white,
        readOnly: !controller.isEdit,
        hint: strWorkingExperience,
        labelText: strWorkingExperienceStar,
        inputAction: TextInputAction.next,
        validate: (data) => Validator.fieldChecker(
          message: strWorkingExperience,
          value: data,
        ),
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.medicalConditionFocusNode),
        inputType: TextInputType.text,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_working_experience_image,
            ),
          ),
        ),
      );

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget _serviceSkilled() => TextFieldWidget(
        shadow: true,
        focusNode: controller.serviceSkilledFocusNode,
        textController: controller.serviceSkilledTextController,
        errorColor: Colors.white,
        readOnly: true,
        labelText: strServiceSkilled,
        hint: strServiceSkilledSS,
        maxline: 5,
        inputAction: TextInputAction.next,
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.medicalConditionFocusNode),
        inputType: TextInputType.text,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_service_skilled_image,
            ),
          ),
        ),
      );

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget _dob(BuildContext context) => TextFieldWidget(
        shadow: true,
        readOnly: true,
        onTap: () async {
          if (controller.isEdit == true) {
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
        labelText: strDateOfBirth,
        hint: strDateOfBirthSS,
        inputAction: TextInputAction.next,
        validate: (data) =>
            Validator.fieldChecker(value: data, message: strDateOfBirthSS),
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
                if (controller.isEdit == true) {
                  openDropdown(genderType);
                }
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

  TextFieldWidget _emailAddress() => TextFieldWidget(
        shadow: true,
        focusNode: controller.emailFocusNode,
        textController: controller.emailTextController,
        errorColor: Colors.white,
        readOnly: true,
        labelText: strEmailAddresss,
        hint: strEmailAddresss,
        inputAction: TextInputAction.next,
        validate: (data) => Validator.validateEmail(data),
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.passwordFocusNode),
        inputType: TextInputType.emailAddress,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_mail_image,
            ),
          ),
        ),
      );

  /* ============================================================= old password edit text ========================================================*/

  TextFieldWidget _oldPasswordText() => TextFieldWidget(
        shadow: true,
        focusNode: controller.oldPasswordFocusNode,
        textController: controller.oldPasswordTextController,
        errorColor: Colors.white,
        labelText: strOldPassword,
        hint: strPasswordHint,
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
        obscureText: controller.isHideOld,
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
        suffixIcon: GestureDetector(
          onTap: () {
            controller.isHideOld = !controller.isHideOld;
            controller.update();
          },
          child: Transform.scale(
            scale: 0.4,
            child: AssetImageWidget(
              imageUrl: controller.isHideOld == false
                  ? ic_password_open
                  : ic_password_close,
            ),
          ),
        ),
      );

  /* ============================================================= password edit text ========================================================*/

  TextFieldWidget _passwordText() => TextFieldWidget(
        shadow: true,
        focusNode: controller.passwordFocusNode,
        textController: controller.passwordTextController,
        errorColor: Colors.white,
        labelText: strNewPasssword,
        hint: strPasswordHint,
        inputAction: TextInputAction.next,
        obscureText: controller.isHide,
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
        suffixIcon: GestureDetector(
          onTap: () {
            controller.isHide = !controller.isHide;
            controller.update();
          },
          child: Transform.scale(
            scale: 0.4,
            child: AssetImageWidget(
              imageUrl: controller.isHide == false
                  ? ic_password_open
                  : ic_password_close,
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
        labelText: strConfirmPass,
        hint: strPasswordHint,
        obscureText: controller.isHide2,
        inputAction: TextInputAction.next,
        inputFormatter: [FilteringTextInputFormatter.deny(' ')],
        validate: (data) => controller.isOldPassWord == true
            ? PasswordFormValidator.validatePasswordMatch(
                value: data,
                confirmPassword: controller.passwordTextController?.text)
            : null,
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!).unfocus(),
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
        suffixIcon: GestureDetector(
          onTap: () {
            controller.isHide2 = !controller.isHide2;
            controller.update();
          },
          child: Transform.scale(
            scale: 0.4,
            child: AssetImageWidget(
              imageUrl: controller.isHide2 == false
                  ? ic_password_open
                  : ic_password_close,
            ),
          ),
        ),
      );

  /* ============================================================validateData========================================================*/

  void validateData() {
    if (controller.formGlobalKey.currentState!.validate()) {
      alertDialog(
          alert: true,
          text: strProfileUpdatedPending,
          icon: ic_green_tick,
          onTap: () {
            Get.back();
            controller.isEdit = false;
            controller.hitUpdateAccountApi();
            controller.update();
          });
      controller.update();
    }
  }

  _headingTxt({title, paddingBottom, paddingTop}) {
    return TextView(
            text: title,
            textStyle: TextStyle(
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w500,
                fontSize: font_13))
        .paddingOnly(
            bottom: paddingBottom ?? margin_0, top: paddingTop ?? margin_0);
  }

  _commonList({list}) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: list?.length ?? 0,
        itemBuilder: (context, index) {
          CategoryDataModel item = list[index];
          return checkTitleText(
            tick: item.isSelected,
            title: item.title,
          );
        });
  }

  _languageList({list}) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: list?.length ?? 0,
        itemBuilder: (context, index) {
          var item = list[index];
          return checkTitleText(
              tick: item.isSelected,
              title: item.title,
              onTap: () {
                if (controller.isEdit == true) {
                  item.isSelected = !item.isSelected!;
                  controller.update();
                }
              });
        });
  }

  _divider() {
    return Divider(
      color: Colors.grey.shade400,
      height: margin_5,
    ).paddingSymmetric(vertical: margin_5);
  }

  _chooseFileView({paddingTop}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AssetImageWidget(imageUrl: ic_certificate, imageHeight: height_20)
                .paddingOnly(right: margin_10, left: margin_5),
            InkWell(
              onTap: () async {
                if (controller.isEdit == true) {
                  try {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      allowedExtensions: ['pdf', 'png', "jpg"],
                      type: FileType.custom,
                    );
                    if (result != null) {
                      controller.sizeInMbNew =
                          (File(result.files.single.path.toString())
                                  .lengthSync() /
                              (1024 * 1024));
                      if (controller.sizeInMbNew! > 10) {
                        flashBar(message: strFilemaxlimitexceed);
                      } else {
                        controller.documentFileNew = File(
                          result.files.single.path.toString(),
                        );
                        controller.fileNameNew =
                            result.files.single.path.toString().split('/').last;

                        if (result != null) {
                          if (controller.docList.contains(
                                  result.files.first.path.toString()) ==
                              false) {
                            controller.docList.add(
                                controller.documentFileNew?.path.toString());
                          }
                          controller.extensionNew = p.extension(
                              controller.documentFileNew?.path.toString() ??
                                  "");
                        }
                        controller.update();
                      }
                    } else {
                      flashBar(message: strFilepickedCancel);
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
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: darkkPurple,
                    borderRadius: BorderRadius.circular(radius_5)),
                padding: EdgeInsets.symmetric(
                    vertical: margin_3, horizontal: margin_20),
                child: TextView(
                  text: strViewUploadedFiles.toUpperCase(),
                  textStyle: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
        Divider(
          color: Colors.grey.shade400,
          height: margin_5,
        ).paddingSymmetric(vertical: margin_5),
        TextView(
            text: strLessDAta,
            textStyle:
                TextStyle(color: Colors.grey.shade400, fontSize: font_11))
      ],
    ).paddingOnly(bottom: margin_10, top: paddingTop ?? margin_0);
  }

  _uploadedCertificateView() {
    return Container(
      width: Get.width,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: controller.loginResponseModel?.detail?.files?.length ?? 0,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var item = controller.loginResponseModel?.detail?.files?[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: item?.isApprove == documentRejected ||
                          controller.isNotified == true
                      ? controller.colorState?.value
                      : Colors.transparent,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.to(PdfView(
                              "${imageBaseUrl.toString()}${item?.fileLink.toString()}",
                              isPDF: item!.fileLink.toString().endsWith('pdf')
                                  ? true
                                  : false,
                              isNetwork: true,
                            ));
                          },
                          child: TextView(
                            text: item?.fileName?.toString() ?? "",
                            textStyle: TextStyle(
                              fontSize: font_14,
                            ),
                            textAlign: TextAlign.start,
                            maxLine: 2,
                          ).paddingOnly(right: margin_5),
                        ),
                      ),
                      if (item?.isApprove == documentRejected) ...[
                        InkWell(
                          onTap: () {
                            item?.showRejectedItem = true;
                            controller.update();
                          },
                          child: TextView(
                                  text: strSeeInfo,
                                  textStyle: textStyleBody1().copyWith(
                                      color: appColor,
                                      fontSize: font_13,
                                      fontWeight: FontWeight.w600))
                              .paddingOnly(right: margin_5),
                        )
                      ],
                      AssetImageWidget(
                        imageUrl: item?.isApprove == documentPending
                            ? ic_pending
                            : item?.isApprove == documentApproved
                                ? ic_approve
                                : ic_reject,
                        imageWidth: width_20,
                      ),
                    ],
                  ).paddingOnly(bottom: margin_10, top: margin_10),
                ),
              ),
              if (item?.isApprove == documentRejected)
                ExpandedSection(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                              text: strRejectionReason,
                              textStyle: textStyleBody1().copyWith(
                                  color: appColor,
                                  fontSize: font_13,
                                  fontWeight: FontWeight.w600))
                          .paddingOnly(bottom: margin_5),
                      TextView(
                        text: item?.reason ?? "",
                        textStyle: textStyleBody1()
                            .copyWith(color: Colors.black, fontSize: font_12),
                        maxLine: 5,
                        textAlign: TextAlign.start,
                      ),
                      if (controller.isEdit == true) ...[
                        InkWell(
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
                                  flashBar(message: strFilemaxlimitexceed);
                                } else {
                                  controller.documentFile = File(
                                    result.files.single.path.toString(),
                                  );
                                  controller.fileName = result.files.single.path
                                      .toString()
                                      .split('/')
                                      .last;
                                  item?.uploadedDoc = controller.documentFile;
                                  item?.uploadedDocFileName =
                                      controller.fileName;
                                  controller.update();
                                }
                              } else {
                                flashBar(message: strFilepickedCancel);
                              }
                            } catch (e) {
                              Get.defaultDialog(
                                  title: 'Permission Required!',
                                  content: Column(
                                    children: [
                                      TextView(
                                          text:
                                              'Please enable required permission !',
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
                                          ).paddingSymmetric(
                                                  horizontal: margin_20)),
                                          Expanded(
                                              child: MaterialButtonWidget(
                                            buttonText: 'Allow',
                                            textColor: Colors.white,
                                            onPressed: () {
                                              Get.back();
                                              openAppSettings();
                                            },
                                          ).paddingSymmetric(
                                                  horizontal: margin_20)),
                                        ],
                                      )
                                    ],
                                  ));
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: darkkPurple,
                                borderRadius: BorderRadius.circular(radius_5)),
                            padding: EdgeInsets.symmetric(
                                vertical: margin_3, horizontal: margin_15),
                            child: TextView(
                              text: strChooseNewFile.toUpperCase(),
                              textStyle: TextStyle(color: Colors.white),
                            ),
                          ).paddingOnly(top: margin_10, bottom: margin_10),
                        ),
                      ],
                      item?.uploadedDocFileName == null ||
                              item?.uploadedDocFileName == ''
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(PdfView(
                                        "${item?.uploadedDoc?.path}",
                                        isPDF: item!.uploadedDoc!.path
                                                .toString()
                                                .endsWith('pdf')
                                            ? true
                                            : false,
                                      ));
                                    },
                                    child: TextView(
                                      text:
                                          "${item?.uploadedDocFileName.split('/').last ?? ''}",
                                      textStyle: TextStyle(
                                        fontSize: font_14,
                                      ),
                                      maxLine: 2,
                                      textAlign: TextAlign.start,
                                    ).paddingOnly(right: margin_5),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    item?.uploadedDocFileName = null;
                                    item?.uploadedDoc = null;
                                    controller.update();
                                  },
                                  child: AssetImageWidget(
                                    imageUrl: ic_delete_image,
                                    imageFitType: BoxFit.cover,
                                    imageHeight: height_20,
                                  ),
                                )
                              ],
                            ).paddingOnly(bottom: margin_25)
                    ],
                  ).paddingOnly(bottom: margin_10),
                  expand: item!.showRejectedItem == null
                      ? false
                      : item.showRejectedItem!,
                )
              else
                Container(
                  height: 0,
                  width: 0,
                )
            ],
          );
        },
      ),
    );
  }

  _newUploadedCertificateView({title}) {
    return title == null
        ? Container()
        : Container(
            width: Get.width,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: controller.docList.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var item = controller.docList[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(PdfView(
                            "${item.toString()}",
                            isPDF:
                                item.toString().endsWith('pdf') ? true : false,
                          ));
                        },
                        child: TextView(
                          text: item.toString().split('/').last,
                          textStyle: TextStyle(
                            fontSize: font_14,
                          ),
                          maxLine: 2,
                          textAlign: TextAlign.start,
                        ).paddingOnly(right: margin_5),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.docList.removeAt(index);
                        controller.update();
                      },
                      child: AssetImageWidget(
                        imageUrl: ic_delete_image,
                        imageFitType: BoxFit.cover,
                        imageHeight: height_20,
                      ),
                    )
                  ],
                ).paddingOnly(bottom: margin_10);
              },
            ),
          );
  }

  appBarView2({title}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextView(
              text: strMyProfile,
              textStyle: textStyleHeading().copyWith(color: appColor)),
          controller.isEdit == false
              ? InkWell(
                  onTap: () {
                    controller.isEdit = true;
                    controller.update();
                    controller.scrollController?.animateTo(Get.height * 5.0,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeIn);
                  },
                  child: TextView(
                          text: strEdit,
                          textAlign: TextAlign.center,
                          textStyle: textStyleHeading()
                              .copyWith(color: appColor, fontSize: font_14))
                      .paddingSymmetric(vertical: margin_3),
                )
              : Container()
        ],
      ),
    ).paddingOnly(bottom: margin_50, top: margin_20);
  }

  _inviteMembersDialog(ProfileController controller) {
    Get.dialog(GetBuilder<ProfileController>(builder: (controller) {
      return Container(
        margin: EdgeInsets.all(margin_30),
        height: Get.height * 0.7,
        child: Container(
          height: Get.height * 0.7,
          padding: EdgeInsets.all(margin_10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius_20),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: margin_10),
                          value: controller.locationList![index].isSelected,
                          onChanged: (value) {
                            controller.locationList!.forEach((element) {
                              element.isSelected = false;
                            });
                            controller.locationList![index].isSelected = true;
                            controller.update();
                          },
                          title: Text(
                              controller.locationList![index].title ?? "",
                              style: textStyleHeading2()));
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: height_10);
                    },
                    itemCount: controller.locationList?.length ?? 0),
              ),
              Row(
                children: [
                  Expanded(
                      child: MaterialButtonWidget(
                    fontsize: font_14,
                    onPressed: () {
                      List<String> address = [];

                      controller.selectedLocation.clear();
                      controller.commaSepratedLocationTitle.clear();
                      controller.commaSepratedLocationId.clear();
                      for (var i = 0;
                          i < controller.locationList!.length;
                          i++) {
                        controller.locationList![i].isSelected = false;
                        if (controller.loginResponseModel?.detail?.workZone
                                .toString()
                                .contains(controller.locationList![i].id
                                    .toString()) ==
                            true) {
                          address.add(controller.locationList![i].title);

                          controller.locationList![i].isSelected = true;
                        }
                        controller.workZoneController?.text =
                            address.join(', ');
                      }
                      controller.update();
                      Get.back();
                    },
                    buttonText: strCancel.toUpperCase(),
                  )),
                  SizedBox(width: width_10),
                  Expanded(
                      child: MaterialButtonWidget(
                    onPressed: () {
                      controller.selectedLocation.clear();
                      controller.commaSepratedLocationTitle.clear();
                      controller.commaSepratedLocationId.clear();
                      controller.locationList!.forEach((element) {
                        if (element.isSelected == true) {
                          controller.selectedLocation.add(element);
                        }
                      });
                      controller.selectedLocation.forEach((element) {
                        controller.commaSepratedLocationTitle
                            .add(element.title!);
                        controller.commaSepratedLocationId.add(element.id!);
                      });
                      controller.workZoneController?.text =
                          controller.commaSepratedLocationTitle.join(', ');
                      Get.back();
                      controller.update();
                    },
                    fontsize: font_14,
                    buttonText: strConfirm.toUpperCase(),
                  )),
                ],
              ).paddingOnly(top: margin_20)
            ],
          ),
        ),
      );
    }));
  }
}
