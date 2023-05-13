/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class ForgotPasswordScreen extends GetView<ForgotPassController> {
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          controller.onWillPop();
          return Future.value(true);
        },
        child: GetBuilder<ForgotPassController>(
          init: ForgotPassController(),
          builder: (controller) {
            return Scaffold(
                body: Container(
              width: Get.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ic_background_image),
                      fit: BoxFit.cover)),
              child: _bodyWidget(),
            ));
          },
        ));
  }

  /* ==================================================== build body of the screen =========================================================*/

  Widget _bodyWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appBarView(title: strForgotPassword),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _headingTxt(),
                _formWidget(),
                _loginButton(),
              ],
            ),
          ).paddingOnly(top: margin_50),
        ],
      ).paddingSymmetric(horizontal: margin_20, vertical: margin_25);

  _headingTxt() {
    return Text.rich(
      TextSpan(
          style: TextStyle(
              color: Colors.black,
              fontSize: font_15,
              fontWeight: FontWeight.w500),
          children: [
            TextSpan(
                text: strEnterNumberAssociated,
                style:
                    TextStyle(color: Colors.grey.shade400, fontSize: font_14)),
            TextSpan(
                text: strOneTimePassword,
                style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: font_14)),
            TextSpan(
                text: strToResetPassword,
                style: TextStyle(
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                    fontSize: font_14)),
          ]),
      maxLines: 3,
    ).paddingOnly(bottom: margin_50);
  }

  /* ============================================================ form widget  ============================================================*/

  Widget _formWidget() => Form(
        key: formGlobalKey,
        child: _mobileEditText().paddingOnly(bottom: margin_30),
      );

  /* ============================================================= mobile edit text ========================================================*/

  TextFieldWidget _mobileEditText() => TextFieldWidget(
      shadow: true,
      maxLength: 15,
      focusNode: controller.mobileFocusNode,
      textController: controller.contactEditTextController,
      errorColor: Colors.white,
      prefixWidth: width_60,
      hint: strMobileNumberHint,
      labelText: strMobileNumber,
      inputFormatter: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      inputAction: TextInputAction.next,
      prefixIcon: Text("+60").paddingOnly(right: margin_2),
      validate: (data) =>
          Validator.validatePhoneNumber(data.toString().replaceAll('-', '')),
      onFieldSubmitted: (String val) =>
          FocusScope.of(Get.context!).requestFocus(controller.mobileFocusNode),
      inputType: TextInputType.number,
      contentPadding: EdgeInsets.zero);

  /* ============================================================validateData========================================================*/

  void validateData() {
    if (formGlobalKey.currentState!.validate()) {
      controller.hitforgotApiCall();
    }
  }

  /* ============================================================= login button ========================================================*/

  Widget _loginButton() => MaterialButtonWidget(
        onPressed: () {
          validateData();
        },
        buttonText: strSendOTP.toUpperCase(),
      ).paddingOnly(top: margin_10);
}
