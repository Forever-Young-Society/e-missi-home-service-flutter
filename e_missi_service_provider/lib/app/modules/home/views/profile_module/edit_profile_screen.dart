/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

/*========================================================_body============================================*/

  _body() => Scaffold(
        body: Stack(
          children: [
            AssetImageWidget(
              imageUrl: ic_maskGroup,
              imageWidth: Get.width,
              imageHeight: height_150,
              imageFitType: BoxFit.fill,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBarView2(title: strAddDependent),
                Center(
                  child: Stack(children: [
                    AssetImageWidget(
                      imageUrl: ICON_avatar,
                      imageHeight: height_90,
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: AssetImageWidget(
                          imageUrl: ic_Add,
                          imageHeight: height_30,
                        )),
                  ]).paddingOnly(bottom: margin_5),
                ),
                formWidget(),
              ],
            ).paddingSymmetric(horizontal: margin_20, vertical: margin_5),
          ],
        ),
      );

  formWidget() {
    return Expanded(
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _nameTextField().paddingOnly(bottom: margin_20),
              _identificationTextField().paddingOnly(bottom: margin_20),
              contactController().paddingOnly(bottom: margin_20),
              addressController().paddingOnly(bottom: margin_20),
              breifMdeicalConditionController().paddingOnly(bottom: margin_20),
              TextView(
                      text: strLessThanMb,
                      textStyle: textStyleBody2().copyWith(color: Colors.grey))
                  .paddingOnly(bottom: margin_10),
              Container(
                child: TextView(
                        text: strMedicalReport,
                        textStyle:
                            textStyleBody2().copyWith(color: Colors.white))
                    .paddingSymmetric(
                        horizontal: margin_20, vertical: margin_5),
                decoration: BoxDecoration(
                    color: darkPurple,
                    borderRadius: BorderRadius.circular(radius_5)),
              ).paddingOnly(bottom: margin_20),
              dobController().paddingOnly(bottom: margin_20),
              emailController().paddingOnly(bottom: margin_20),
              TextView(
                      text: strChangePassword,
                      textStyle:
                          textStyleHeading2().copyWith(color: Colors.black))
                  .paddingOnly(bottom: margin_20),
              _oldPasswordText().paddingOnly(bottom: margin_20),
              _newPasswordText().paddingOnly(bottom: margin_20),
              _confirmPasswordText().paddingOnly(bottom: margin_20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: TextView(
                              text: strCancel,
                              textStyle:
                                  textStyleBody2().copyWith(color: Colors.grey))
                          .paddingSymmetric(
                              horizontal: margin_20, vertical: margin_13),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radius_5)),
                    ).paddingOnly(bottom: margin_5, right: margin_20),
                  ),
                  Expanded(
                    child: Container(
                      child: TextView(
                              text: strSave,
                              textStyle: textStyleBody2()
                                  .copyWith(color: Colors.white))
                          .paddingSymmetric(
                              horizontal: margin_20, vertical: margin_15),
                      decoration: BoxDecoration(
                          color: darkPurple,
                          borderRadius: BorderRadius.circular(radius_5)),
                    ).paddingOnly(bottom: margin_5),
                  ),
                ],
              ).paddingOnly(bottom: margin_20)
            ],
          ),
        ],
      ),
    );
  }

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget _nameTextField() => TextFieldWidget(
        shadow: true,
        focusNode: controller.medicalConditionFocusNode,
        textController: controller.confirmTextController,
        errorColor: Colors.white,
        hint: strNameIcPassport,
        inputAction: TextInputAction.next,
        inputType: TextInputType.text,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_user,
            ),
          ),
        ),
      );

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget _identificationTextField() => TextFieldWidget(
        shadow: true,
        focusNode: controller.medicalConditionFocusNode,
        textController: controller.confirmTextController,
        errorColor: Colors.white,
        hint: strIdentificatioNumber,
        inputAction: TextInputAction.next,
        inputType: TextInputType.text,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_user,
            ),
          ),
        ),
      );

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget ageController() => TextFieldWidget(
        shadow: true,
        focusNode: controller.medicalConditionFocusNode,
        textController: controller.confirmTextController,
        errorColor: Colors.white,
        hint: 'Age',
        inputAction: TextInputAction.next,
        inputType: TextInputType.text,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_Age,
            ),
          ),
        ),
      );

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget addressController() => TextFieldWidget(
        shadow: true,
        focusNode: controller.medicalConditionFocusNode,
        textController: controller.confirmTextController,
        errorColor: Colors.white,
        hint: strAddress,
        inputAction: TextInputAction.next,
        inputType: TextInputType.text,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_address,
            ),
          ),
        ),
      );

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget dobController() => TextFieldWidget(
        shadow: true,
        focusNode: controller.medicalConditionFocusNode,
        textController: controller.confirmTextController,
        errorColor: Colors.white,
        hint: strDob,
        inputAction: TextInputAction.next,
        inputType: TextInputType.text,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_caldrgry,
            ),
          ),
        ),
      );

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget emailController() => TextFieldWidget(
        shadow: true,
        focusNode: controller.medicalConditionFocusNode,
        textController: controller.confirmTextController,
        errorColor: Colors.white,
        hint: strEmailAddress,
        inputAction: TextInputAction.next,
        inputType: TextInputType.text,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_mail,
            ),
          ),
        ),
      );

  /* ====================================================PDF PNG or JPEG format less than 3 MB========= name edit text ========================================================*/

  TextFieldWidget contactController() => TextFieldWidget(
        shadow: true,
        focusNode: controller.medicalConditionFocusNode,
        textController: controller.confirmTextController,
        errorColor: Colors.white,
        hint: strMobileNumber,
        inputAction: TextInputAction.next,
        inputType: TextInputType.text,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_mobile,
            ),
          ),
        ),
      );

  /* ============================================================= name edit text ========================================================*/

  TextFieldWidget breifMdeicalConditionController() => TextFieldWidget(
        shadow: true,
        focusNode: controller.medicalConditionFocusNode,
        textController: controller.confirmTextController,
        errorColor: Colors.white,
        hint: strBriefMedicalCondition,
        inputAction: TextInputAction.next,
        inputType: TextInputType.text,
        contentPadding: EdgeInsets.only(top: margin_5),
        prefixIcon: Center(
          child: Transform.scale(
            scale: 0.6,
            child: AssetImageWidget(
              imageUrl: ic_mediclegry,
            ),
          ),
        ),
      );

  /* ============================================================= password edit text ========================================================*/

  TextFieldWidget _oldPasswordText() => TextFieldWidget(
        shadow: true,
        focusNode: controller.passwordFocusNode,
        textController: controller.passwordTextController,
        errorColor: Colors.white,
        labelText: strOldPassword,
        hint: strPasswordHint,
        inputAction: TextInputAction.next,
        obscureText: controller.isHide,
        inputFormatter: [FilteringTextInputFormatter.deny(' ')],
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
      );

  /* ============================================================= new password edit text ========================================================*/

  TextFieldWidget _newPasswordText() => TextFieldWidget(
        shadow: true,
        focusNode: controller.passwordFocusNode,
        textController: controller.passwordTextController,
        errorColor: Colors.white,
        labelText: strNewPasssword,
        hint: strPasswordHint,
        inputAction: TextInputAction.next,
        obscureText: controller.isHide,
        inputFormatter: [FilteringTextInputFormatter.deny(' ')],
        validate: (data) => PasswordFormValidator.validate(data),
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
            scale: 0.3,
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
        labelText: strConfirmPassword,
        hint: strPasswordHint,
        inputAction: TextInputAction.next,
        obscureText: controller.isHide,
        inputFormatter: [FilteringTextInputFormatter.deny(' ')],
        validate: (data) => PasswordFormValidator.validate(data),
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
            scale: 0.3,
            child: AssetImageWidget(
              imageUrl: controller.isHide == false
                  ? ic_password_open
                  : ic_password_close,
            ),
          ),
        ),
      );

  appBarView2({title}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: AssetImageWidget(
                  imageUrl: ic_back_image,
                  imageFitType: BoxFit.cover,
                  imageHeight: height_25,
                ).paddingOnly(bottom: margin_10),
              ),
              TextView(
                  text: strEdit,
                  textStyle: textStyleHeading2().copyWith(color: Colors.black))
            ],
          ),
        ],
      ),
    ).paddingOnly(bottom: margin_20, top: margin_20);
  }
}
