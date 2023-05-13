/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class RegistrationScreen extends GetView<RegistrationController> {
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          controller.onWillPop();
          return Future.value(true);
        },
        child: GetBuilder<RegistrationController>(
          init: RegistrationController(),
          builder: (controller) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: _bodyWidget(),
            );
          },
        ));
  }

  /* ==================================================== build body of the screen =========================================================*/

  Widget _bodyWidget() => Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ic_background_image), fit: BoxFit.cover)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBarView(title: strSignUp),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _formWidget(),
                    _loginButton(),
                  ],
                ),
              ).paddingOnly(top: margin_50),
            ],
          ).paddingSymmetric(horizontal: margin_20, vertical: margin_10),
        ],
      );

  /* ============================================================ form widget  ============================================================*/

  Widget _formWidget() => Form(
        key: formGlobalKey,
        child: _mobileEditText().paddingOnly(bottom: margin_30),
      );

  /* ============================================================= mobile edit text ========================================================*/

  TextFieldWidget _mobileEditText() => TextFieldWidget(
      shadow: true,
      focusNode: controller.mobileFocusNode,
      textController: controller.contactEditTextController,
      errorColor: Colors.white,
      hint: strMobileNumberHint,
      labelText: strMobileNumber,
      inputFormatter: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      maxLength: 10,
      inputAction: TextInputAction.done,
      prefixIcon: Text("+60").paddingOnly(right: margin_2),
      validate: (data) => Validator.validatePhoneNumber(data.toString()),
      // onFieldSubmitted: (String val) => FocusScope.of(Get.context!).dispose(),
      inputType: TextInputType.number,
      contentPadding: EdgeInsets.zero);

  /* ============================================================validateData========================================================*/

  void validateData(GlobalKey<FormState> formGlobalKey) {
    if (formGlobalKey.currentState!.validate()) {
      if (controller.contactEditTextController?.text
              .toString()
              .startsWith("0") ==
          true) {
        flashBar(message: strRemoveZero);
      } else {
        controller.hitSignUpApi(formGlobalKey);
      }
    }
  }

  /* ============================================================= login button ========================================================*/

  Widget _loginButton() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MaterialButtonWidget(
            onPressed: () {
              validateData(formGlobalKey);
            },
            buttonText: strSignUp.toUpperCase(),
          ).paddingOnly(top: margin_10),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Text.rich(
              TextSpan(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: font_15,
                      fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                        text: strAlreadyAccount,
                        style: TextStyle(
                            color: Colors.grey.shade400, fontSize: font_13)),
                    TextSpan(
                        text: strSignIn,
                        style: TextStyle(
                            color: appColor,
                            height: 2.5,
                            fontWeight: FontWeight.w500,
                            fontSize: font_13))
                  ]),
              maxLines: 3,
            ).paddingOnly(left: margin_5),
          )
        ],
      );
}
