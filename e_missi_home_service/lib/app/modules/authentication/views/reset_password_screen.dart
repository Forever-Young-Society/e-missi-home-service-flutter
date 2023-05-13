/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class ResetPasswordScreen extends GetView<ResetPassController> {
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          controller.onWillPop();
          return Future.value(true);
        },
        child: GetBuilder<ResetPassController>(
          init: ResetPassController(),
          builder: (controller) {
            return Scaffold(
                body: Container(
              height: Get.height,
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

  Widget _bodyWidget() => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appBarView(
                title: strResetPassword,
                onTap: () {
                  Get.offAllNamed(AppRoutes.logIn);
                }),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _formWidget(),
                    _loginButton(),
                  ],
                ),
              ),
            ).paddingOnly(top: margin_100),
          ],
        ).paddingSymmetric(horizontal: margin_20, vertical: margin_25),
      );

  /* ============================================================ form widget ============================================================*/

  Widget _formWidget() => Form(
        key: formGlobalKey,
        child: Column(
          children: [
            _passwordText().paddingOnly(bottom: margin_30),
            _confirmPasswordText().paddingOnly(bottom: margin_30),
          ],
        ),
      );

  /* ============================================================= password edit text ========================================================*/

  TextFieldWidget _passwordText() => TextFieldWidget(
        shadow: true,
        focusNode: controller.passwordFocusNode,
        textController: controller.passwordTextController,
        errorColor: Colors.white,
        hint: strPasswordHint,
        labelText: strNewPassword,
        inputAction: TextInputAction.next,
        obscureText: !controller.isHide,
        inputFormatter: [FilteringTextInputFormatter.deny(' ')],
        validate: (data) => PasswordFormValidator.validate(data),
        onFieldSubmitted: (String val) => FocusScope.of(Get.context!)
            .requestFocus(controller.confirmFocusNode),
        inputType: TextInputType.text,
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
      hint: strPasswordHint,
      labelText: strConfirmPassword,
      obscureText: !controller.isConHide,
      inputAction: TextInputAction.next,
      inputFormatter: [FilteringTextInputFormatter.deny(' ')],
      validate: (data) => PasswordFormValidator.validatePasswordMatch(
          value: data,
          confirmPassword: controller.passwordTextController?.text),
      onFieldSubmitted: (String val) => FocusScope.of(Get.context!).unfocus(),
      inputType: TextInputType.text,
      contentPadding: EdgeInsets.only(top: margin_5),
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
        ),
      ));

  // /* ============================================================validateData========================================================*/

  void validateData() {
    if (formGlobalKey.currentState!.validate()) {
      controller.hitLoginApi();
    }
  }

  /* ============================================================= login button ========================================================*/

  Widget _loginButton() => MaterialButtonWidget(
        onPressed: () {
          validateData();
        },
        buttonText: strResetPassword.toUpperCase(),
      ).paddingOnly(top: margin_10);
}
