/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'dart:io';
import 'package:e_missi_service_provider/export.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';

class CreateAccountScreen extends StatelessWidget {
  final controller = Get.put(CreateAccountController());
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  final stateType = new GlobalKey(debugLabel: 'State Type');
  final genderType = new GlobalKey(debugLabel: 'gender');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateAccountController>(
      init: CreateAccountController(),
      builder: (controller) {
        return Scaffold(
            body: Container(
          width: Get.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ic_background_image), fit: BoxFit.cover)),
          child: _bodyWidget(context),
        ));
      },
    );
  }

  /* ==================================================== build body of the screen =========================================================*/

  Widget _bodyWidget(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appBarView(title: strCreateAccount),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _formWidget(context),
                  _loginButton(),
                ],
              ),
            ).paddingOnly(top: margin_50),
          ),
        ],
      ).paddingSymmetric(horizontal: margin_20, vertical: margin_25);

  /* ============================================================ form widget  ============================================================*/

  Widget _formWidget(BuildContext context) => Form(
        key: formGlobalKey,
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
            _workingZone().paddingOnly(bottom: margin_20),
            _workingExperience().paddingOnly(bottom: margin_20),
            _headingTxt(title: strQualification.toUpperCase()),
            _commonList(list: controller.categoryList),
            _divider(),
            _serviceSkilled().paddingOnly(bottom: margin_20, top: margin_10),
            ExpandedSection(
              child: _subCommonList(list: controller.subCategoryList),
              expand: controller.joinVar!.length != 0,
            ),
            _headingTxt(
                title: strQualificationDocuments.toUpperCase(),
                paddingBottom: margin_10),
            _chooseFileView(),
            ExpandedSection(
              child: _uploadedCertificateView(title: controller.fileName),
              expand: controller.fileName != null,
            ),
            _headingTxt(
                title: strLanguagesStar.toUpperCase(), paddingTop: margin_10),
            _languageList(list: controller.languageList),
            _divider(),
            _headingTxt(
                title: strPersonalPhoto.toUpperCase(),
                paddingBottom: margin_10,
                paddingTop: margin_10),
            _choosePersonalPhotoView(),
            ExpandedSection(
              child: _personalPhotoView(title: controller.fileName2),
              expand: controller.fileName2 != null,
            ),
            _passwordText().paddingOnly(bottom: margin_8, top: margin_10),
            TextView(
                    text: strIInvalidPassword,
                    textStyle: TextStyle(
                        color: Colors.grey.shade400, fontSize: font_12),
                    maxLine: 2,
                    textAlign: TextAlign.start)
                .paddingOnly(bottom: margin_20),
            _confirmPasswordText().paddingOnly(bottom: margin_30),
          ],
        ),
      );

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget _nameTextField() => TextFieldWidget(
        shadow: true,
        focusNode: controller.nameFocusNode,
        textController: controller.nameTextController,
        errorColor: Colors.white,
        labelText: strNameAsPerPass,
        hint: strNameAsPerPassSS,
        inputAction: TextInputAction.next,
        validate: (data) => Validator.fieldChecker(
          message: strNameAsPerPassSS,
          value: data,
        ),
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.identificationFocusNode),
        // inputType: TextInputType.text,
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
        labelText: strIdentificationNumber,
        hint: strIdentificationNumberSS,
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp('[0-9-]+')),
          MaskedTextInputFormatter(separator: '-', mask: 'xxxxxx-xx-xxxx')
        ],
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
        hint: strMobileNumberHint,
        labelText: strMobileNumberStar,
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
        labelText: strHomeAddressStar,
        hint: strHomeAddressStarSS,
        inputAction: TextInputAction.next,
        validate: (data) => Validator.fieldChecker(
          message: strHomeAddressStarSS,
          value: data,
        ),
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.workZoneFocusNode),
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
        readOnly: true,
        focusNode: controller.workZoneFocusNode,
        textController: controller.workZoneController,
        errorColor: Colors.white,
        onTap: () {
          _inviteMembersDialog(controller);
        },
        labelText: strWorkingZoneStar,
        hint: strWorkingZoneStarSS,
        inputAction: TextInputAction.next,
        validate: (data) => Validator.fieldChecker(
          message: strWorkingZoneStarSS,
          value: data,
        ),
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.workExperienceFocusNode),
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

  _addMoreSection() {
    return InkWell(
      onTap: () {
        commonDialog(
            text: strLogoutHeading,
            confirmText: strOk,
            onTap: () {
              Get.back();
            });
      },
      child: Row(
        children: [
          AssetImageWidget(imageUrl: ic_add_more, imageHeight: height_20)
              .paddingOnly(right: margin_5),
          TextView(
              text: strAddMore,
              textStyle: TextStyle(fontSize: font_13, color: Colors.grey)),
        ],
      ).paddingOnly(bottom: margin_20),
    );
  }

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget _workingExperience() => TextFieldWidget(
        shadow: true,
        focusNode: controller.workExperienceFocusNode,
        textController: controller.workExperienceController,
        errorColor: Colors.white,
        hint: strWorkingExperience,
        labelText: strWorkingExperienceStar,
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        maxLength: 2,
        inputAction: TextInputAction.next,
        validate: (data) => Validator.fieldChecker(
          message: strWorkingExperience,
          value: data,
        ),
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.passwordFocusNode),
        inputType: TextInputType.number,
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
        validate: (data) => Validator.fieldChecker(
          message: strServiceSkilledSS,
          value: data,
        ),
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
                  scale: 0.5,
                  child: AssetImageWidget(
                    imageUrl: controller.genderId == 0
                        ? ic_male
                        : controller.genderId == 1
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
        hint: strEmailAddress,
        labelText: strEmailAddressStar,
        inputAction: TextInputAction.next,
        validate: (data) => Validator.validateEmail(data),
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.addressFocusNode),
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

  /* ============================================================= password edit text ========================================================*/

  TextFieldWidget _passwordText() => TextFieldWidget(
        shadow: true,
        focusNode: controller.passwordFocusNode,
        textController: controller.passwordTextController,
        errorColor: Colors.white,
        hint: strPasswordHint,
        labelText: strCreatePass,
        inputAction: TextInputAction.next,
        obscureText: controller.isHide,
        inputFormatter: [FilteringTextInputFormatter.deny(' ')],
        validate: (data) => PasswordFormValidator.validate(data),
        onChange: (value) {
          controller.passwordData = value;
          PasswordFormValidator.validate(controller.passwordData ?? "aa") ==
                  null
              ? controller.checkPass = false
              : controller.checkPass = true;
          controller.update();
        },
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
        validate: (data) => PasswordFormValidator.validatePasswordMatch(
            value: data,
            confirmPassword: controller.passwordTextController?.text),
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
        suffixIcon: InkWell(
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
    String? data = controller.languageList
        ?.where((element) => element.isSelected == true)
        .toList()
        .map((e) => e.id)
        .join(",");
    if (formGlobalKey.currentState!.validate()) {
      if (controller.docList.length == 0) {
        flashBar(message: strPleaseUploadDocuments);
      } else {
        controller.hitCreateAccountApi();
      }
    }
  }

  /* ============================================================= login button ========================================================*/

  Widget _loginButton() => Column(
        children: [
          MaterialButtonWidget(
            onPressed: () {
              validateData();
            },
            buttonText: strCreateAccount.toUpperCase(),
          ).paddingOnly(top: margin_10),
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.staticPageRoute);
            },
            child: Text.rich(
              TextSpan(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: font_15,
                      fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                        text: "By proceeding, I agree to the, ",
                        style: TextStyle(
                            color: Colors.grey.shade400, fontSize: font_12)),
                    TextSpan(
                        text: "Terms of Use.",
                        style: TextStyle(
                            color: appColor,
                            height: 2.5,
                            fontWeight: FontWeight.w500,
                            fontSize: font_12))
                  ]),
              maxLines: 3,
            ).paddingOnly(left: margin_5),
          )
        ],
      );

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

  _commonList({List<CategoryDataModel>? list}) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: list?.length ?? 0,
        itemBuilder: (context, index) {
          CategoryDataModel item = list![index];
          return checkTitleText(
              tick: item.isSelected,
              title: item.title,
              onTap: () {
                list.forEach((element) {
                  element.isSelected = false;
                  controller.joinVar?.clear();
                  controller.selectedSubCategory?.clear();
                  controller.selectedSubCategoryId?.clear();
                  controller.serviceSkilledTextController?.clear();
                  controller.update();
                });
                item.isSelected = !item.isSelected!;
                if (item.isSelected == true) {
                  if (controller.joinVar?.contains(item.id) == false) {
                    controller.joinVar?.add(item.id);
                  }
                } else {
                  controller.joinVar?.remove(item.id);
                  controller.selectedSubCategory?.clear();
                  controller.selectedSubCategoryId?.clear();
                  controller.serviceSkilledTextController?.clear();
                  controller.update();
                }
                debugPrint("ddj ${controller.joinVar.toString()}");
                controller.hitServiceSubCategoryAPI(catId: controller.joinVar);

                controller.update();
              });
        });
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
                                      onTap: () {
                                        item.subSkills![index].isSelected =
                                            !item.subSkills![index].isSelected!;
                                        if (item.subSkills![index].isSelected ==
                                            true) {
                                          if (controller.selectedSubCategory
                                                  ?.contains(item
                                                      .subSkills![index].id) ==
                                              false) {
                                            controller.selectedSubCategory?.add(
                                                item.subSkills![index].title ??
                                                    "");
                                            controller.selectedSubCategoryId
                                                ?.add(
                                                    item.subSkills![index].id);
                                          }
                                        } else {
                                          controller.selectedSubCategory
                                              ?.remove(
                                                  item.subSkills![index].title);
                                          controller.selectedSubCategoryId
                                              ?.remove(
                                                  item.subSkills![index].id);
                                        }

                                        controller.serviceSkilledTextController
                                                ?.text =
                                            controller.selectedSubCategory!
                                                .join(",")
                                                .toString();
                                        controller.update();
                                      });
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
                      onTap: () {
                        item.isSelected = !item.isSelected!;
                        if (item.isSelected == true) {
                          if (controller.selectedSubCategory
                                  ?.contains(item.id) ==
                              false) {
                            controller.selectedSubCategory
                                ?.add(item.title ?? "");
                            controller.selectedSubCategoryId?.add(item.id);
                          }
                        } else {
                          controller.selectedSubCategory?.remove(item.title);
                          controller.selectedSubCategoryId?.remove(item.id);
                        }

                        controller.serviceSkilledTextController?.text =
                            controller.selectedSubCategory!
                                .join(",")
                                .toString();
                        controller.update();
                      });
            }).paddingOnly(bottom: margin_20);
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
                item.isSelected = !item.isSelected!;
                controller.update();
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
                try{
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    allowedExtensions: ['pdf', 'png', "jpg"],
                    type: FileType.custom,
                  );
                  if (result != null) {
                    controller.sizeInMb =
                    (File(result.files.single.path.toString()).lengthSync() /
                        (1024 * 1024));
                    if (controller.sizeInMb! > 10) {
                      flashBar(message: strFilemaxlimitexceed);
                    } else {
                      controller.documentFile = File(
                        result.files.single.path.toString(),
                      );
                      controller.fileName =
                          result.files.single.path.toString().split('/').last;

                      if (result != null) {
                        if (controller.docList
                            .contains(result.files.first.path.toString()) ==
                            false) {
                          controller.docList
                              .add(controller.documentFile?.path.toString());
                        }
                        controller.extension = p.extension(
                            controller.documentFile?.path.toString() ?? "");
                      }
                      controller.update();
                    }
                  } else {
                    flashBar(message: strFilepickedCancel);
                  }
                }catch(e){
                  Get.defaultDialog(
                      title: 'Permission Required!',
                      content: Column(
                        children: [
                          TextView(
                              text: 'Please enable required permission !',
                              maxLine: 3,
                              textStyle: textStyleHeading2().copyWith(fontSize: font_14)),
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
                    color: darkkPurple,
                    borderRadius: BorderRadius.circular(radius_5)),
                padding: EdgeInsets.symmetric(
                    vertical: margin_3, horizontal: margin_20),
                child: TextView(
                  text: strChooseFile.toUpperCase(),
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

  _choosePersonalPhotoView({paddingTop}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AssetImageWidget(imageUrl: ic_certificate, imageHeight: height_20)
                .paddingOnly(right: margin_10, left: margin_5),
            InkWell(
              onTap: () async {
             try{

               FilePickerResult? result = await FilePicker.platform.pickFiles(
                 allowedExtensions: ['png', "jpg"],
                 type: FileType.custom,
               );
               if (result != null) {
                 controller.sizeInMb =
                 (File(result.files.single.path.toString()).lengthSync() /
                     (1024 * 1024));
                 if (controller.sizeInMb! > 10) {
                   flashBar(message: strFilemaxlimitexceed);
                 } else {
                   controller.documentFile2 = File(
                     result.files.single.path.toString(),
                   );
                   controller.fileName2 =
                       result.files.single.path.toString().split('/').last;
                   controller.update();
                 }
               } else {
                 flashBar(message: strFilepickedCancel);
               }

               if (result != null) {
                 controller.extension2 = p.extension(
                     controller.documentFile2?.path.toString() ?? "");
                 debugPrint("file path extension ${controller.extension2}");
               }
             }catch(e){
               Get.defaultDialog(
                   title: 'Permission Required!',
                   content: Column(
                     children: [
                       TextView(
                           text: 'Please enable required permission !',
                           maxLine: 3,
                           textStyle: textStyleHeading2().copyWith(fontSize: font_14)),
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
                    color: darkkPurple,
                    borderRadius: BorderRadius.circular(radius_5)),
                padding: EdgeInsets.symmetric(
                    vertical: margin_3, horizontal: margin_20),
                child: TextView(
                  text: strChooseFile.toUpperCase(),
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

  _uploadedCertificateView({title}) {
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
                            isNetwork: false,
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

  _personalPhotoView({title}) {
    return title == null
        ? Container()
        : Container(
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.to(PdfView(
                        "${controller.documentFile2?.path}",
                        isPDF: controller.extension2 == ".pdf" ? true : false,
                      ));
                    },
                    child: TextView(
                      text: title ?? "blank.PDF",
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
                    controller.fileName2 = null;
                    controller.documentFile2 = null;
                    controller.update();
                  },
                  child: AssetImageWidget(
                    imageUrl: ic_delete_image,
                    imageFitType: BoxFit.cover,
                    imageHeight: height_20,
                  ),
                )
              ],
            ).paddingOnly(bottom: margin_10),
          );
  }

  commonDialog({
    text,
    confirmText,
    onTap,
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
                margin: EdgeInsets.symmetric(horizontal: margin_10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(margin_10)),
                child: Column(
                  children: [
                    TextView(
                            text: strSelectArea,
                            textStyle: TextStyle(fontSize: font_14))
                        .paddingSymmetric(vertical: margin_10),
                    Column(
                      children: [
                        _area(),
                        _area(),
                        areaTypeDropDown(),
                      ],
                    ).paddingSymmetric(horizontal: margin_10),
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
                              Get.back();
                            },
                            child: TextView(
                              text: strCancel,
                              textStyle: textStyleBody2().copyWith(
                                  color: Colors.black,
                                  fontSize: font_15,
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
                                color: darkkPurple,
                                fontSize: font_15,
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

  Widget areaTypeDropDown() {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: margin_0,
            bottom: margin_5,
          ),
          child: TextFieldWidget(
            hint: strArea,
            alignLabelWithHint: false,
            labels: false,
            onTap: () {
              openDropdown(stateType);
            },
            readOnly: true,
            hintStyle: textStyleBody1()
                .copyWith(fontSize: font_14, color: Colors.grey.shade400),
            contentPadding: EdgeInsets.symmetric(
                horizontal: margin_10, vertical: margin_15),
            borders: OutlineInputBorder(
                borderRadius: BorderRadius.circular(margin_10),
                borderSide: BorderSide(color: Colors.grey)),
            suffixIcon: AssetImageWidget(
              imageUrl: ic_dropdown,
              imageHeight: height_15,
              imageWidth: height_15,
              color: Colors.purple,
            ).paddingAll(margin_12),
          ),
        ),
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
                key: stateType,
                iconEnabledColor: Colors.transparent,
                items: (controller.areTypeList).map((AreaType value) {
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
                onChanged: (temp) {},
              ),
            ),
          ),
        ),
      ],
    );
  }

  _area() {
    return TextFieldWidget(
      hint: strArea,
      alignLabelWithHint: false,
      labels: false,
      onTap: () {},
      readOnly: true,
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
        color: appColor,
      ).paddingAll(margin_12),
    ).paddingOnly(bottom: margin_20);
  }

  _inviteMembersDialog(CreateAccountController controller) {
    Get.dialog(GetBuilder<CreateAccountController>(builder: (controller) {
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
              Text("Select Working Zone", style: textStyleHeading()),
              SizedBox(height: height_20),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                          activeColor: appColor,
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
                      controller.locationList!.forEach((element) {
                        element.isSelected = false;
                      });
                      controller.workZoneController!.clear();
                      controller.selectedLocation.clear();
                      controller.commaSepratedLocationTitle.clear();
                      controller.commaSepratedLocationId.clear();
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
          ).paddingAll(margin_20),
        ),
      );
    }));
  }
}
