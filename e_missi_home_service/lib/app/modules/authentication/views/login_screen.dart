/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';
import 'package:upgrader/upgrader.dart';

class LoginScreen extends GetView<LoginController> {
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  var controller = Get.put<LoginController>(LoginController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return controller.onWillPop();
        },
        child: GetBuilder<LoginController>(
          init: LoginController(),
          builder: (controller) {
            return UpgradeAlert(
              child: Scaffold(
                  body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ic_background_image),
                        fit: BoxFit.cover)),
                child: _bodyWidget(),
              )),
            );
          },
        ));
  }

  /* ==================================================== build body of the screen =========================================================*/

  Widget _bodyWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appBarView(
              title: strSignIn,
              isHideBAck: Container(
                height: height_20,
              )),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _formWidget(),
                    _loginButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: margin_20, vertical: margin_10);

  /* ============================================================ form widget  ============================================================*/

  Widget _formWidget() => Form(
        key: formGlobalKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          _mobileEditText().paddingOnly(bottom: margin_30),
          _passwordEditText().paddingOnly(bottom: margin_15),
          _forgotTxt()
        ]),
      );

  _forgotTxt() {
    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.forgotRoute);
          formGlobalKey.currentState?.reset();
          controller.contactEditTextController!.clear();
          controller.passwordTextController!.clear();
        },
        child: Text(
          strForgotYourPassword,
        ),
      ),
    );
  }

  /* ============================================================= mobile edit text ========================================================*/

  TextFieldWidget _mobileEditText() => TextFieldWidget(
      shadow: true,
      maxLength: 15,
      focusNode: controller.mobileFocusNode,
      textController: controller.contactEditTextController,
      errorColor: Colors.white,
      hint: strMobileNumberHint,
      labelText: strMobileNumber,
      inputFormatter: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      inputAction: TextInputAction.next,
      prefixIcon: Text("+60").paddingOnly(right: margin_2),
      validate: (data) =>
          Validator.validatePhoneNumber(data.toString().replaceAll('-', '')),
      onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
          .requestFocus(controller.passwordFocusNode),
      inputType: TextInputType.number,
      contentPadding: EdgeInsets.zero);

  /* ============================================================= password edit text ========================================================*/

  TextFieldWidget _passwordEditText() => TextFieldWidget(
        shadow: true,
        labelText: strPassword,
        focusNode: controller.passwordFocusNode,
        textController: controller.passwordTextController,
        errorColor: Colors.white,
        hint: strPasswordHint,
        inputAction: TextInputAction.done,
        obscureText: !controller.isHide,
        inputFormatter: [FilteringTextInputFormatter.deny(' ')],
        validate: (data) =>
            Validator.fieldChecker(value: data, message: strPassword),
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!).dispose(),
        inputType: TextInputType.visiblePassword,
        contentPadding: EdgeInsets.only(top: margin_10),
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

  /* ============================================================validateData========================================================*/

  void validateData() {
    if (formGlobalKey.currentState!.validate()) {
      controller.hitLoginApi();
    }
  }

  /* ============================================================= login button ========================================================*/

  Widget _loginButton() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MaterialButtonWidget(
            onPressed: () {
              validateData();
            },
            buttonText: strSignIn.toUpperCase(),
          ).paddingOnly(top: margin_30),
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.registrationRoute);
              formGlobalKey.currentState?.reset();
              controller.contactEditTextController!.clear();
              controller.passwordTextController!.clear();
            },
            child: Text.rich(
              TextSpan(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: font_15,
                      fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                        text: strDontHaaveAccount,
                        style: TextStyle(
                            color: Colors.grey.shade400, fontSize: font_12)),
                    TextSpan(
                        text: strSignUp,
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
