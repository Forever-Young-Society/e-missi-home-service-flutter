/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */


import '../../../../export.dart';

class OTPController extends GetxController {
  TextEditingController? otpFieldTwoTextController;
  TextEditingController? otpFieldOneEditTextController;
  TextEditingController? otpFieldThreeTextController;
  TextEditingController? otpFieldFourTextController;
  FocusNode? otpFieldOneFocusNode;
  var otp;
  var otpAttempt;

  var incorrectOtp = false;
  Timer? timerr;
  FocusNode? otpFieldTwoFocusNode;
  FocusNode? otpFieldThreeFocusNode;
  FocusNode? otpFieldFourFocusNode;
  final FocusScopeNode node = FocusScopeNode();
  FocusNode? passwordFocusNode;
  final Repository _repository = Get.find<Repository>();
  final PreferenceManger _preferenceManger = Get.find<PreferenceManger>();
  int backPressCounter = 0;
  LoginResponseModel? loginResponseModel = LoginResponseModel();

  var contactNo;
  var contactFour;
  var resend;
  List contactNoList = [];
  bool isHide = false;

  bool? isReset;
  int time = 180;
  final preFilledWidget = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 56,
        height: 3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );

  final defaultPinTheme = PinTheme(
    height: height_55,
    width: height_40,
    textStyle: TextStyle(
      fontSize: font_20,
      color: Colors.black,
    ),
    decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade400,
            width: 1,
          ),
        )),
  );

  final errorPinTheme = PinTheme(
    height: height_55,
    width: height_40,
    textStyle: TextStyle(
      fontSize: font_20,
      color: Colors.black,
    ),
    decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        )),
  );

  verifyNumber({contactNo}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+60 ${contactNo}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
        String smsCode = 'xxxx';
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      isReset = Get.arguments['isReset'];
      contactNo = Get.arguments[contactIdKey];
      otpAttempt = Get.arguments[otpAttemptIdKey];
      resend = Get.arguments[resendKey];
      contactNoList = contactNo.toString().split("");
      contactFour = contactNoList
          .getRange(contactNoList.length - 4, contactNoList.length)
          .join("");
      debugPrint('resend ${resend.toString()}');
      debugPrint('mobile number ${contactFour.toString()}');
      debugPrint('mobile number ${contactFour.toString()}');
      debugPrint('OTP number ${Get.arguments[otpAttemptIdKey]}');
      debugPrint('mobile number ${contactNo.toString()}');
      // verifyNumber(contactNo: contactNo);
    }

    timerr = Timer.periodic(Duration(seconds: 1), (timer) {
      if (time > 0) {
        time--;
      }

      update();
    });
    getProfileData();
    initEditTextController();
    initFocusNodeController();
    super.onInit();
  }

  getProfileData() async {
    _preferenceManger.getSavedLoginData().then((value) {
      if (value != null) {
        loginResponseModel?.detail = value;
        initEditTextController();
        update();
      }
    });
  }

  formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }


  /* =========================================================init all edit text, focus node, models that are used in this controller ============================================*/

  initFocusNodeController() {
    otpFieldOneFocusNode = FocusNode();
    otpFieldTwoFocusNode = FocusNode();
    otpFieldThreeFocusNode = FocusNode();
    otpFieldFourFocusNode = FocusNode();
  }

  initEditTextController() {
    otpFieldTwoTextController = TextEditingController();
    otpFieldOneEditTextController = TextEditingController();
    otpFieldThreeTextController = TextEditingController();
    otpFieldFourTextController = TextEditingController();
  }

  /* ========================================================gotoOtpScreen ============================================*/

  gotoCreateScreen() {
    Get.offNamed(
        isReset == true
            ? AppRoutes.resetPassRoute
            : AppRoutes.createAccountRoute,
        arguments: {
          contactIdKey: loginResponseModel?.detail?.contactNo ?? "",
        }
    );
  }

  /* =======================================================clearEditText===========================================*/

  clearEditText() {
    otpFieldOneEditTextController!.clear();
    otpFieldTwoTextController!.clear();
    otpFieldThreeTextController!.clear();
    otpFieldFourTextController!.clear();
  }

  /* =======================================================clearEditText===========================================*/

  clearFocusNode() {
    otpFieldFourFocusNode!.dispose();
    otpFieldOneFocusNode!.dispose();
    otpFieldTwoFocusNode!.dispose();
    otpFieldThreeFocusNode!.dispose();
  }

  /* ======================================================hitLoginApi=========================================*/

  hitOtpVerifyApi({otpVer, message}) {
    Map<String, dynamic> requestModel =
    AuthRequestModel.loginVerifyOtpRequestModel(
        contactNo: contactNo,
        mobileOtp: otpFieldOneEditTextController!.text.trim(),
        otpVerified: otpVer.toString());
    _repository
        .loginVerifyOtpApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        loginResponseModel = value;
        if (otpVer == 0) {
          flashBar(message: message);
        } else {
          flashBar(message: '${loginResponseModel?.message.toString()}');
        }
      }
      gotoCreateScreen();
    }).onError((error, stackTrace) {
      if (otpVer == 0) {
        flashBar(message: message);
      } else {
        flashBar(message: error.toString());
      }
    });
  }

  /* ======================================================hitresendOtpApi=========================================*/

  hitresendOtpApi() {
    Map<String, dynamic> requestModel = AuthRequestModel.resendOtpRequestModel(
      contactNo: contactNo,
    );
    _repository.resendApiCall(dataBody: requestModel).then((value) async {
      if (value != null) {
        loginResponseModel = value;
        saveDataToLocalStorage(loginResponseModel);
        otpAttempt = loginResponseModel!.detail!.otpAttempt;
        debugPrint(
            'otpAttempt${loginResponseModel!.detail!.otpAttempt.toString()}');
        if (otpAttempt == 3) {
          time = 1800;
          update();
        } else if (otpAttempt == 2) {
          time = 180;
          update();
        } else {
          var data = await Get.toNamed(AppRoutes.signUpUnSuccessfullyRoute,
              arguments: {contactIdKey: contactNo});
          if (data != null) {
            getProfileData();
          }
        }
        update();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  /* ======================================================saveDataToLocalStorage=========================================*/

  saveDataToLocalStorage(LoginResponseModel? loginResponseModel) {
    _preferenceManger.saveRegisterData(loginResponseModel?.detail);
  }

  @override
  void dispose() {
    clearEditText();
    clearFocusNode();
    timerr?.cancel;
    super.dispose();
  }
}