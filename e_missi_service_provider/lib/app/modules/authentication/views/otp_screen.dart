/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */




import '../../../../export.dart';

class OTPScreen extends GetView<OTPController> {
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Get.offNamed(AppRoutes.logIn);
          return Future.value(true);
        },
        child: GetBuilder<OTPController>(
          init: OTPController(),
          builder: (controller) {
            return Scaffold(
                body: Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ic_background_image),
                          fit: BoxFit.cover)
                  ),
                  child: _bodyWidget(),
                ));
          },
        ));
  }

  /* ==================================================== build body of the screen =========================================================*/

  Widget _bodyWidget() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      appBarView(title: strOTPVerification),
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _imageView(),
              _textView(),
              _profile_fields(),
            ],
          ),
        ).paddingOnly(top: margin_50),
      ),
    ],
  ).paddingSymmetric(horizontal: margin_20, vertical: margin_25);

  _imageView() {
    return AssetImageWidget(
      imageUrl: ic_otp_image,
      imageFitType: BoxFit.cover,
      imageHeight: height_60,
    ).paddingOnly(bottom: margin_20);
  }

  _textView() {
    return Column(
      children: [
        Text(strEnterOneTime,
            style: TextStyle(color: Colors.grey, fontSize: font_18))
            .paddingOnly(bottom: margin_10),
        Text("XXX-XXX${controller.contactFour}",
            style: TextStyle(fontSize: font_18)),
      ],
    );
  }

  /* ============================================================ form widget  ============================================================*/
  _profile_fields() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child:
      FirebasePhoneAuthHandler(
        phoneNumber: "+60${controller.contactNo}",
        recaptchaVerifierForWebProvider:null ,
        signOutOnSuccessfulVerification: false,
        linkWithExistingUser: false,
        builder: (context, controller) {
          return Column(
            children: [
              _formWidget(controller),
              _loginButton(controller),
            ],
          );
        },
        otpExpirationDuration:Duration(minutes: 3),
        onLoginSuccess: (userCredential, autoVerified) {
          customLoader.hide();
          controller.hitOtpVerifyApi(otpVer: 1);
          debugPrint("autoVerified: $autoVerified");
          debugPrint("Login success UID: ${userCredential.user?.uid}");
        },
        onLoginFailed: (authException, stackTrace) {
          customLoader.hide();
          controller.hitOtpVerifyApi(otpVer: 0, message:authException.message?.toString()??"" );
          debugPrint("An error occurred: ${authException.message}");
        },
        onError: (error, stackTrace) {
          customLoader.hide();
          flashBar(message: strSomethingWorg);
          debugPrint("Login success fail ${error.toString()}");
        },
      ),
    );
  }


  Widget _formWidget(FirebasePhoneAuthController controllers) => Form(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    key: formGlobalKey,
    child: Pinput(
      crossAxisAlignment: CrossAxisAlignment.center,
      separator: Container(width: width_10),
      controller: controller.otpFieldOneEditTextController,
      mainAxisAlignment: MainAxisAlignment.center,
      defaultPinTheme: controller.defaultPinTheme,
      focusedPinTheme: controller.defaultPinTheme,
      submittedPinTheme: controller.defaultPinTheme,
      disabledPinTheme: controller.defaultPinTheme,
      errorPinTheme: controller.errorPinTheme,
      followingPinTheme: controller.defaultPinTheme,
      validator: (pin) {
        if (pin?.isEmpty == true)
          return strEnterOtp;
        else
          return null;
      },
      showCursor: true,
      preFilledWidget: controller.preFilledWidget,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      onCompleted: (pin) => print(pin),
      length:6 ,
    ).paddingOnly(top: margin_30),
  );

  /* ============================================================validateData========================================================*/

  void validateData(FirebasePhoneAuthController controllers) {
    if (formGlobalKey.currentState!.validate()) {
      customLoader.show(Get.context);
      controllers.verifyOtp(controller.otpFieldOneEditTextController!.text.toString());
    }
  }

  /* ============================================================= login button ========================================================*/

  Widget _loginButton(FirebasePhoneAuthController controllers) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      MaterialButtonWidget(
        onPressed: () {

          validateData(controllers);
        },
        buttonText: strVerifyProceed.toUpperCase(),
      ).paddingOnly(top: margin_40),
      controller.otpAttempt == 4
          ? Container()
          : InkWell(
        onTap: () {
          if (controller.time == 0) {
            controller.otpFieldOneEditTextController!.clear();
            controllers.sendOTP().then((value) {
              controller.hitresendOtpApi();

            });
          }
          debugPrint('otp Attempt${controller.otpAttempt}');
        },
        child: Text.rich(
          TextSpan(
              style: TextStyle(
                  color: Colors.black,
                  fontSize: font_15,
                  fontWeight: FontWeight.w500),
              children: [
                TextSpan(
                    text: strDontRecieve,
                    style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: font_13)),
                TextSpan(
                    text: strResend,
                    style: TextStyle(
                        color: controller.time == 0
                            ? appColor
                            : Colors.grey.shade400,
                        height: 2.5,
                        fontWeight: FontWeight.w500,
                        fontSize: font_13))
              ]),
          maxLines: 3,
        ).paddingOnly(left: margin_5),
      ).paddingOnly(bottom: margin_10),
      controller.otpAttempt == 4
          ? Container()
          : TextView(
          text: controller.formatedTime(timeInSecond: controller.time),
          textStyle: textStyleHeading2().copyWith(color: appColor))
    ],
  );
}