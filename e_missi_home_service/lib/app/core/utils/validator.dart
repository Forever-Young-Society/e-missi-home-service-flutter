/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */
import 'package:e_missi_home_service/export.dart';

/*========================Email Validator==============================================*/
class Validator {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return strEmailEmpty;
    } else if (!GetUtils.isEmail(value.trim())) {
      return strInvalidEmail;
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return strPasswordEmpty;
    } else if (value.length < 8) {
      return strInvalidPassword;
    }
    return null;
  }

  static String? validateConfirmPasswordMatch(
      {String? value, String? password}) {
    if (value!.isEmpty) {
      return strCPasswordEmpty;
    } else if (value.length < 8) {
      return strInvalidPassword;
    } else if (value != password) {
      return strPasswordMatc;
    }
    return null;
  }

  static String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return strPhoneEmEmpty;
    } else if (value.length < 9) {
      return strPhoneNumberInvalid;
    } else if (int.parse(value) == 0) {
      return strPhoneNumberInvalidd;
    } else if (value.length > 15) {
      return strPhoneNumberInvalid;
    }
    return null;
  }

  static String? fieldChecker({required String value, required message}) {
    if (value.toString().trim().isEmpty) {
      return "$message cannot be empty";
    }
    return null;
  }

  static String? fieldCheckerEmpty({required String value, required message}) {
    return null;
  }
}

/*================================================== Password Validator ===================================================*/

class PasswordFormValidator {
  static String? validate(String value) {
    var pattern = r'^(?=.*?[a-z])(?=.*?[0-9])';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return strPasswordEmpty;
    } else if (value.length < 8) {
      return strInvalidPassword;
    } else if (!regExp.hasMatch(value)) {
      return strIInvalidPassword;
    }
    return null;
  }

  static String? validatePasswordMatch(
      {String? value, String? confirmPassword}) {
    if (value!.isEmpty) {
      return strCPasswordEmpty;
    } else if (value.length < 8) {
      return strInvalidPassword;
    } else if (value != confirmPassword) {
      return strPasswordMatc;
    }
    return null;
  }
}

/*================================================== Phone Number Validator ===================================================*/

class PhoneNumberValidate {
  static String? validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return strPhoneEmEmpty;
    } else if (value.length < 8 || value.length > 15) {
      return strPhoneNumberInvalid;
    } else if (!validateNumber(value)) {
      return strSpecialCharacter;
    }
    return null;
  }
}

bool validateNumber(String value) {
  var pattern = r'^[0-9]+$';
  RegExp regex = RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}

/*===============================Field Checker=================================================*/
class FieldChecker {
  static String? fieldChecker(String? value, message) {
    if (value == null || value.toString().trim().isEmpty) {
      return "$message cannot be empty";
    }
    return null;
  }
}
