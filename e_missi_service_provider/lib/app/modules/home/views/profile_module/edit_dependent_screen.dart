/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class EditDependentScreen extends GetView<EditDependentController> {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

/*========================================================_body============================================*/

  _body() => Scaffold(
        body: Stack(
          children: [
            Container(
              width: Get.width,
              height: height_150,
              color: lightPink,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBarView2(title: strAddDependent),
                Center(
                  child: Stack(children: [
                    AssetImageWidget(
                      imageUrl: ic_defaultUser,
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
              ageController().paddingOnly(bottom: margin_20),
              addressController().paddingOnly(bottom: margin_20),
              dobController().paddingOnly(bottom: margin_20),
              emailController().paddingOnly(bottom: margin_20),
              contactController().paddingOnly(bottom: margin_20),
              breifMdeicalConditionController().paddingOnly(bottom: margin_10),
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
              ).paddingOnly(bottom: margin_5),
              Row(
                children: [
                  TextView(
                          text: 'Medical_report.PDF',
                          textStyle:
                              textStyleBody2().copyWith(color: Colors.black))
                      .paddingOnly(right: margin_10),
                  AssetImageWidget(
                    imageUrl: ic_delete,
                    imageHeight: height_20,
                  )
                ],
              ).paddingOnly(bottom: margin_20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: TextView(
                              text: strRemove,
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
        inputFormatter: [FilteringTextInputFormatter.deny(' ')],
        validate: (data) => PasswordFormValidator.validatePasswordMatch(
            value: data,
            confirmPassword: controller.passwordTextController?.text),
        onFieldSubmitted: (String val) =>
            FocusScope.of(Get.context!).requestFocus(controller.dobFocusNode),
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

  /* ============================================================= name edit text ========================================================*/

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

  appBarView2({title}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: TextStyle(fontSize: font_26, color: purple))
                  .paddingOnly(
                left: margin_10,
              ),
            ],
          ),
        ],
      ),
    ).paddingOnly(bottom: margin_20, top: margin_20);
  }
}
