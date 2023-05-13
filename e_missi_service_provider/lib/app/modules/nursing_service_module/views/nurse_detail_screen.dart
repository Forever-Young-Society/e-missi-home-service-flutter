import 'package:e_missi_service_provider/export.dart';

class NurseDetailScreen extends GetView<NurseDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: Get.width,
            color: appLightColor,
            height: Get.height * 0.25,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBarView2(title: strDetails),
              _containerView(),
              _headTxtView(
                  title: "Service Area :",
                  subTitle: "Petaling Jaya, subag Jaya"),
              _headTxtView(
                  title: "Qualification :",
                  subTitle:
                      "Bachelor of Nursing (hons) Public Health, MalaSia University"),
              _headTxtView(
                  title: "Language :", subTitle: "English, Malay, Chinese"),
              _headTxtView(
                  title: "Service Provided :",
                  subTitle: "Home & Environment assessment for elderly "),
              Spacer(),
              _button()
            ],
          ).paddingAll(margin_20),
        ],
      ),
    );
  }

  _containerView() {
    return CommonCardViewDetail(
      title: strPatientDetails,
      image: ic_profile,
      topView: Container(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AssetImageWidget(
            imageUrl: ic_girl,
            imageHeight: height_120,
            imageFitType: BoxFit.fill,
          ).paddingOnly(right: margin_15),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                      text: 'Mr. Tan Wei Mang',
                      textStyle: textStyleBody2().copyWith(color: Colors.black))
                  .paddingOnly(bottom: margin_10),
              description(
                  descriptionHeading: 'Service Area',
                  descriptionSubHeading: 'mohali'),
              description(
                  descriptionHeading: 'Age', descriptionSubHeading: '55'),
              description(
                  descriptionHeading: strGender, descriptionSubHeading: 'Male'),
              description(
                  descriptionHeading: "Experience",
                  descriptionSubHeading: '4 years'),
              Row(
                children: [
                  AssetImageWidget(
                    imageUrl: ic_star,
                    imageHeight: height_15,
                    imageFitType: BoxFit.fill,
                  ).paddingOnly(right: margin_5),
                  TextView(
                      text: '4.2',
                      textStyle: textStyleBody2().copyWith(color: Colors.black))
                ],
              )
            ],
          )),
        ],
      ),
    ).paddingOnly(top: margin_10);
  }

  description({descriptionHeading, descriptionSubHeading}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
                text: descriptionHeading,
                textStyle: TextStyle(fontSize: font_12, color: Colors.grey))
            .paddingOnly(bottom: margin_3),
        TextView(
                text: ': ',
                textStyle: TextStyle(fontSize: font_12, color: Colors.grey))
            .paddingOnly(bottom: margin_3),
        Flexible(
            child: TextView(
          text: descriptionSubHeading,
          textStyle: TextStyle(fontSize: font_12, color: Colors.black),
          maxLine: 1,
          textAlign: TextAlign.start,
        ).paddingOnly(bottom: margin_8)),
      ],
    );
  }

  _headTxtView({title, subTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
                text: title,
                textStyle: TextStyle(color: Colors.black, fontSize: font_15))
            .paddingOnly(bottom: margin_5),
        TextView(
          text: subTitle,
          textStyle: TextStyle(color: Colors.grey, fontSize: font_15),
          textAlign: TextAlign.start,
          maxLine: 2,
        )
      ],
    ).paddingOnly(bottom: margin_20);
  }

  _button() {
    return MaterialButtonWidget(
      onPressed: () {
        Get.toNamed(AppRoutes.appointmentViewRoute);
      },
      buttonText: strBookNow.toUpperCase(),
    );
  }
}
