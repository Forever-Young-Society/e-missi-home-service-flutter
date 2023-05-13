/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateAccountScreen extends GetView<CreateAccountController> {
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  final genderType = new GlobalKey(debugLabel: 'gender');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Get.offAllNamed(AppRoutes.logIn);
          Get.find<OTPController>().clearEditText();
          return Future.value(true);
        },
        child: GetBuilder<CreateAccountController>(
          init: CreateAccountController(),
          builder: (controller) {
            return Scaffold(
                body: Container(
              width: Get.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ic_background_image),
                      fit: BoxFit.cover)),
              child: _bodyWidget(context),
            ));
          },
        ));
  }

  /* ==================================================== build body of the screen =========================================================*/

  Widget _bodyWidget(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appBarView(
              onTap: () {
                Get.offAllNamed(AppRoutes.logIn);
              },
              title: strCreateAccount),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _formWidget(context),
                  _createAccountButton(),
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
            _mobileNumber().paddingOnly(bottom: margin_20),
            _address().paddingOnly(bottom: margin_20),
            _zipCodeaddress().paddingOnly(bottom: margin_20),
            _medicalCondition().paddingOnly(bottom: margin_20),
            _medicalReportView(),
            _dob(context).paddingOnly(bottom: margin_20),
            _gender().paddingOnly(bottom: margin_20),
            _emailAddress().paddingOnly(bottom: margin_20),
            _passwordText().paddingOnly(bottom: margin_20),
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

  _medicalReportView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          strLessDAta,
          style: TextStyle(fontSize: font_11, color: Colors.grey),
        ).paddingOnly(bottom: margin_5),
        InkWell(
          onTap: () async {
            requestPermissions([Permission.camera, Permission.storage], (data) {
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
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: appColor, borderRadius: BorderRadius.circular(radius_5)),
            padding:
                EdgeInsets.symmetric(vertical: margin_5, horizontal: margin_10),
            child: Text(
              strMedicalReportUpload,
              style: TextStyle(fontSize: font_14, color: Colors.white),
            ),
          ).paddingOnly(bottom: margin_10),
        ),
        controller.fileName == null || controller.fileName == ''
            ? Container()
            : InkWell(
                onTap: () {
                  Get.to(PdfView(
                    "${controller.documentFile?.path}",
                    isPDF:
                        controller.documentFile!.path.toString().endsWith('pdf')
                            ? true
                            : false,
                  ));
                },
                child: Text(
                  "${controller.fileName ?? ''}",
                  style: TextStyle(
                    fontSize: font_13,
                  ),
                ).paddingOnly(right: margin_10),
              )
      ],
    ).paddingOnly(bottom: margin_20);
  }

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget _nameTextField() => TextFieldWidget(
        shadow: true,
        maxLength: 25,
        focusNode: controller.nameFocusNode,
        textController: controller.nameTextController,
        errorColor: Colors.white,
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'))
        ],
        labelText: strNameAsPerPass,
        hint: strNameAsPerPassss,
        inputAction: TextInputAction.next,
        validate: (data) => FieldChecker.fieldChecker(data, strName),
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
        hint: strMobileNumber,
        inputAction: TextInputAction.next,
        validate: (data) => FieldChecker.fieldChecker(data, strMobileNumber),
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
        hint: strAddressStarss,
        labelText: strAddressStar,
        inputAction: TextInputAction.next,
        validate: (data) => FieldChecker.fieldChecker(data, strAddress),
        onFieldSubmitted: (String val) =>
            FocusScope.of(Get.context!).requestFocus(controller.zipFocusNode),
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

  TextFieldWidget _medicalCondition() => TextFieldWidget(
        shadow: true,
        focusNode: controller.medicalConditionFocusNode,
        textController: controller.medicalConditionTextController,
        errorColor: Colors.white,
        hint: strBriefMedical,
        inputAction: TextInputAction.next,
        onFieldSubmitted: (String val) =>
            FocusScope.of(Get.context!).requestFocus(controller.dobFocusNode),
        inputType: TextInputType.text,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_medical_condition_image,
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
        hint: strDateOfBirth,
        labelText: strDateOfBirthss,
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

  TextFieldWidget _emailAddress() => TextFieldWidget(
        shadow: true,
        focusNode: controller.emailFocusNode,
        textController: controller.emailTextController,
        errorColor: Colors.white,
        hint: strEmailAddres,
        labelText: strEmailAddresss,
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

  /* ============================================================= password edit text ========================================================*/

  TextFieldWidget _passwordText() => TextFieldWidget(
        shadow: true,
        focusNode: controller.passwordFocusNode,
        textController: controller.passwordTextController,
        errorColor: Colors.white,
        hint: strPasswordHint,
        labelText: strCreatePass,
        inputAction: TextInputAction.next,
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.confirmFocusNode),
        inputFormatter: [FilteringTextInputFormatter.deny(' ')],
        obscureText: !controller.isHide,
        validate: (data) => PasswordFormValidator.validate(data),
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
            )),
      );

  /* ============================================================= confirm password edit text ========================================================*/

  TextFieldWidget _confirmPasswordText() => TextFieldWidget(
      shadow: true,
      focusNode: controller.confirmFocusNode,
      textController: controller.confirmTextController,
      errorColor: Colors.white,
      hint: strPasswordHint,
      labelText: strConfirmPass,
      contentPadding: EdgeInsets.only(top: margin_10),
      obscureText: !controller.isConHide,
      inputAction: TextInputAction.next,
      inputFormatter: [FilteringTextInputFormatter.deny(' ')],
      validate: (data) => PasswordFormValidator.validatePasswordMatch(
          value: data,
          confirmPassword: controller.passwordTextController?.text),
      onFieldSubmitted: (String val) => FocusScope.of(Get.context!).unfocus(),
      inputType: TextInputType.visiblePassword,
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
            controller.isConHide = !controller.isConHide;
            controller.update();
          },
          child: Transform.scale(
            scale: 0.4,
            child: AssetImageWidget(
              imageUrl:
                  controller.isConHide == false ? ic_eye_hide : ic_eye_unhide,
            ),
          )));

  /* ============================================================validateData========================================================*/

  void validateData() {
    if (formGlobalKey.currentState!.validate()) {
      controller.hitCreateAccountApi();
    }
  }

  /* ============================================================= login button ========================================================*/

  Widget _createAccountButton() => Column(
        children: [
          MaterialButtonWidget(
            onPressed: () {
              validateData();
            },
            buttonText: strCreateAccount.toUpperCase(),
          ).paddingOnly(top: margin_10),
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.staticPageRoute,
                  arguments: {typeKey: termsCondtionType});
            },
            child: Text.rich(
              TextSpan(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: font_15,
                      fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                        text: strByProceeding,
                        style: TextStyle(
                            color: Colors.grey.shade400, fontSize: font_12)),
                    TextSpan(
                        text: strTermsOfUse,
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
}
