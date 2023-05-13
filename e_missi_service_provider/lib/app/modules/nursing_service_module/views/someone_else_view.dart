import 'package:e_missi_service_provider/app/modules/nursing_service_module/views/age_view.dart';
import 'package:e_missi_service_provider/export.dart';

class SomeOneElseViewScreen extends GetView<SomeOneElseController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.7,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              color: Colors.grey.shade300,
              thickness: margin_2,
            ),
            _form()
          ],
        ),
      ),
    );
  }

  _form() {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizeBox(height: height_10),
        _name(),
        _age(),
        _address(),
        _identificationNumber(),
        _dob(),
        _email(),
        _mobile(),
        _medicalCondition(),
        Text(strmedicalReportFormat,
            style: textStyleBody1()
                .copyWith(fontSize: font_12, color: Colors.grey)),
        sizeBox(height: height_10),
        _uploadButton(),
        sizeBox(height: height_10),
        _fileName(),
        sizeBox(height: height_60),
        _cancelAdd(),
        sizeBox(height: height_20),
      ],
    )).paddingSymmetric(horizontal: margin_25);
  }

  _name() {
    return TextFieldWidget(
      hint: strNamePassport,
      contentPadding: EdgeInsets.only(top: margin_10),
      prefixIcon: AssetImageWidget(
        imageUrl: ic_user,
        imageHeight: height_20,
        imageWidth: height_20,
      ).paddingOnly(top: margin_10, right: margin_10),
    ).paddingSymmetric(vertical: margin_15);
  }

  _age() {
    return TextFieldWidget(
      hint: strAge,
      readOnly: true,
      onTap: () {
        _selectAgeDialog();
      },
      contentPadding: EdgeInsets.only(top: margin_10),
      prefixIcon: AssetImageWidget(
        imageUrl: ic_age,
        imageHeight: height_20,
        imageWidth: height_20,
      ).paddingOnly(top: margin_10, right: margin_10),
    ).paddingSymmetric(vertical: margin_15);
  }

  _address() {
    return TextFieldWidget(
      hint: strAddress.toUpperCase(),
      contentPadding: EdgeInsets.only(top: margin_10),
      prefixIcon: AssetImageWidget(
        imageUrl: ic_address,
        imageHeight: height_20,
        imageWidth: height_20,
      ).paddingOnly(top: margin_10, right: margin_10),
    ).paddingSymmetric(vertical: margin_15);
  }

  _identificationNumber() {
    return TextFieldWidget(
      hint: strIdentificationNumber,
      contentPadding: EdgeInsets.only(top: margin_10),
      prefixIcon: AssetImageWidget(
        imageUrl: ic_usercircle,
        imageHeight: height_20,
        imageWidth: height_20,
      ).paddingOnly(top: margin_10, right: margin_10),
    ).paddingSymmetric(vertical: margin_15);
  }

  _dob() {
    return TextFieldWidget(
      hint: strDateOfBirth,
      contentPadding: EdgeInsets.only(top: margin_10),
      prefixIcon: AssetImageWidget(
        imageUrl: ic_caldrgry,
        imageHeight: height_20,
        imageWidth: height_20,
      ).paddingOnly(top: margin_10, right: margin_10),
    ).paddingSymmetric(vertical: margin_15);
  }

  _email() {
    return TextFieldWidget(
      hint: strEmail.toUpperCase(),
      contentPadding: EdgeInsets.only(top: margin_10),
      prefixIcon: AssetImageWidget(
        imageUrl: ic_mail,
        imageHeight: height_20,
        imageWidth: height_20,
      ).paddingOnly(top: margin_10, right: margin_10),
    ).paddingSymmetric(vertical: margin_15);
  }

  _mobile() {
    return TextFieldWidget(
      hint: strMobileNumber.toUpperCase(),
      contentPadding: EdgeInsets.only(top: margin_10),
      prefixIcon: AssetImageWidget(
        imageUrl: ic_mobile,
        imageHeight: height_20,
        imageWidth: height_20,
      ).paddingOnly(top: margin_10, right: margin_10),
    ).paddingSymmetric(vertical: margin_15);
  }

  _medicalCondition() {
    return TextFieldWidget(
      hint: strMedicalCondition,
      contentPadding: EdgeInsets.only(top: margin_10),
      prefixIcon: AssetImageWidget(
        imageUrl: ic_mediclegry,
        imageHeight: height_20,
        imageWidth: height_20,
      ).paddingOnly(top: margin_10, right: margin_10),
    ).paddingSymmetric(vertical: margin_15);
  }

  _uploadButton() {
    return MaterialButtonWidget(
      buttonText: strMedicalReportUpload,
      onPressed: () {},
      padding: margin_10,
      fontsize: font_15,
    ).paddingOnly(right: margin_60);
  }

  _fileName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(child: Text("MEDICAL_REPORT.PDF")),
        sizeBox(width: width_10),
        AssetImageWidget(
          imageUrl: ic_dlt,
          imageHeight: height_20,
        )
      ],
    );
  }

  _cancelAdd() {
    return Row(
      children: [
        Expanded(
            child: MaterialButtonWidget(
          onPressed: () {
            Get.back();
          },
          borderColor: Colors.grey,
          buttonText: strCancel,
          textColor: Colors.grey,
          buttonColor: Colors.white,
        )),
        sizeBox(width: width_20),
        Expanded(
            child: MaterialButtonWidget(
          onPressed: () {},
          borderColor: appColor,
          buttonText: strAdd,
          textColor: Colors.white,
          buttonColor: appColor,
        )),
      ],
    );
  }

  _selectAgeDialog() {
    if (!Get.isRegistered()) {
      Get.lazyPut(() => AgeViewController());
    }
    return Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius_10))),
        content: AgeViewScreen(),
      ),
      barrierDismissible: true,
    );
  }
}
