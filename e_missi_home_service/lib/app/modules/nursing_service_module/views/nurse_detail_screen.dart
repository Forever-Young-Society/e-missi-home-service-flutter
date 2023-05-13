import 'package:e_missi_home_service/export.dart';

class NurseDetailScreen extends GetView<NurseDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NurseDetailController>(
      init: NurseDetailController(),
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                width: Get.width,
                color: appLightColor,
                height: Get.height * 0.25,
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appBarView2(
                        title: "${controller.titleOfService.toString()} " +
                            strDetails),
                    _containerView(),
                    _headTxtView(
                        title: "Service Area :",
                        subTitle: validateDateUserData(controller
                                .nursesServicesDetailResponseModel
                                .detail
                                ?.workZoneTitle ??
                            '')),
                    _headTxtView(
                        title: "Qualification :",
                        subTitle: validateDateUserData(controller
                                .nursesServicesDetailResponseModel
                                .detail
                                ?.qualificationTitle ??
                            '')),
                    controller.nursesServicesDetailResponseModel.detail
                                    ?.languageTitle !=
                                null &&
                            controller.nursesServicesDetailResponseModel.detail!
                                .languageTitle
                                .toString()
                                .isNotEmpty
                        ? _headTxtView(
                            title: "Language :",
                            subTitle: controller
                                    .nursesServicesDetailResponseModel
                                    .detail
                                    ?.languageTitle ??
                                '')
                        : Container(),
                    TextView(
                        text: 'Service Provided :',
                        textStyle:
                            TextStyle(color: Colors.black, fontSize: font_15)),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.stringList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: Colors.grey,
                              size: margin_10,
                            ).paddingOnly(right: margin_5),
                            Expanded(
                              child: TextView(
                                text: controller.stringList[index],
                                textStyle: TextStyle(
                                    color: Colors.grey, fontSize: font_15),
                                textAlign: TextAlign.start,
                                maxLine: 2,
                              ),
                            )
                          ],
                        ).paddingOnly(bottom: margin_5);
                      },
                    ),
                    SizedBox(height: height_20),
                    _button()
                  ],
                ).paddingAll(margin_20),
              ),
            ],
          ),
        );
      },
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
          NetworkImageWidget(
                  imageUrl: controller.nursesServicesDetailResponseModel.detail
                          ?.profileFile ??
                      "",
                  imageHeight: height_100,
                  imageFitType: BoxFit.fill,
                  errorImage: controller.nursesServicesDetailResponseModel
                              .detail?.gender ==
                          0
                      ? ICON_avatar
                      : ICON_avatar_female)
              .paddingOnly(
            right: margin_15,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                      text: controller.nursesServicesDetailResponseModel.detail
                              ?.fullName ??
                          '',
                      textStyle: textStyleBody2().copyWith(color: Colors.black))
                  .paddingOnly(bottom: margin_10),
              description(
                  descriptionHeading: 'Age',
                  descriptionSubHeading: calculateAge(DateTime.parse(controller
                          .nursesServicesDetailResponseModel
                          .detail
                          ?.dateOfBirth ??
                      DateTime.now().toString()))),
              description(
                  descriptionHeading: strGender,
                  descriptionSubHeading: controller
                              .nursesServicesDetailResponseModel
                              .detail
                              ?.gender ==
                          0
                      ? 'Male'
                      : controller.nursesServicesDetailResponseModel.detail
                                  ?.gender ==
                              1
                          ? 'Female'
                          : controller.nursesServicesDetailResponseModel.detail
                                      ?.gender ==
                                  null
                              ? ''
                              : ''),
              description(
                  descriptionHeading: "Experience",
                  descriptionSubHeading: controller
                              .nursesServicesDetailResponseModel
                              .detail
                              ?.experience
                              .toString() ==
                          null
                      ? ''
                      : "${controller.nursesServicesDetailResponseModel.detail?.experience.toString()} Years"),
              Row(
                children: [
                  AssetImageWidget(
                    imageUrl: ic_star,
                    imageHeight: height_15,
                    imageFitType: BoxFit.fill,
                  ).paddingOnly(right: margin_5),
                  TextView(
                      text: controller
                              .nursesServicesDetailResponseModel.detail?.rating
                              ?.toString() ??
                          "0",
                      textStyle: textStyleBody2().copyWith(color: Colors.black))
                ],
              )
            ],
          )),
        ],
      ),
    ).paddingOnly(top: margin_10);
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day.toInt();
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return controller.age = age.toString();
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
        ).paddingOnly(bottom: margin_0)),
      ],
    ).paddingOnly(bottom: margin_5);
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
        Get.toNamed(AppRoutes.appointmentViewRoute, arguments: {
          'date': controller.date,
          'providerId': controller.nursesServicesDetailResponseModel.detail?.id,
          "serviceId": controller.serviceId,
          'dependentId': controller.dependentID,
          'typeId': controller.typeID,
          'workingZoneId': controller.workingzoneId,
          'zipcode': controller.zipcode,
          'categoryId': controller.catId,
          'isFirst': true
        });
      },
      buttonText: strBookNow.toUpperCase(),
    ).paddingOnly(top: margin_5);
  }
}
