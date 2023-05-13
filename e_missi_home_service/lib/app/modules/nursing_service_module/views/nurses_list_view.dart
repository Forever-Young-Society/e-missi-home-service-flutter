import 'package:e_missi_home_service/export.dart';

class NursesListScreen extends GetView<NursesListController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NursesListController>(
      init: NursesListController(),
      builder: (controller) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AssetImageWidget(
                imageUrl: ic_tech_bg,
                imageFitType: BoxFit.cover,
              ),
              Column(
                children: [appBarView2(title: strNurses), _listView()],
              ).paddingAll(margin_20),
            ],
          ),
        );
      },
    );
  }

  _listView() {
    return Expanded(
      child: controller.servicesList!.length == null ||
              controller.servicesList!.length == 0
          ? Center(
              child: TextView(
                text: strNoNursesFound,
                textStyle: textStyleBody1().copyWith(),
              ),
            )
          : ListView.builder(
              itemCount: controller.servicesList!.length,
              controller: controller.scrollController,
              itemBuilder: (context, index) {
                return CommonCardViewDetail(
                  title: strPatientDetails,
                  image: ic_profile,
                  topView: Container(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NetworkImageWidget(
                              imageUrl:
                                  controller.servicesList![index].profileFile,
                              imageHeight: height_100,
                              imageFitType: BoxFit.fill,
                              errorImage:
                                  controller.servicesList![index].gender == 0
                                      ? ICON_avatar
                                      : ICON_avatar_female)
                          .paddingOnly(right: margin_15),
                      Flexible(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                                  text: controller.servicesList?[index].fullName
                                          ?.toString()
                                          .trimLeft() ??
                                      "",
                                  textStyle: textStyleBody2()
                                      .copyWith(color: Colors.black))
                              .paddingOnly(bottom: margin_10),
                          description(
                              descriptionHeading: 'Service Area',
                              descriptionSubHeading: controller
                                      .servicesList?[index].workZoneTitle ??
                                  ''),
                          description(
                            descriptionHeading: 'Age',
                            descriptionSubHeading: calculateAge(DateTime.parse(
                                controller.servicesList?[index].dateOfBirth)),
                          ),
                          description(
                              descriptionHeading: strGender,
                              descriptionSubHeading: controller
                                          .servicesList?[index].gender ==
                                      0
                                  ? 'Male'
                                  : controller.servicesList?[index].gender == 1
                                      ? 'Female'
                                      : ''),
                          description(
                              descriptionHeading: "Experience",
                              descriptionSubHeading: controller
                                          .servicesList?[index].experience
                                          .toString() ==
                                      null
                                  ? ''
                                  : "${controller.servicesList?[index].experience.toString()} Years"),
                          Row(
                            children: [
                              AssetImageWidget(
                                imageUrl: ic_star,
                                imageHeight: height_15,
                                imageFitType: BoxFit.fill,
                              ).paddingOnly(right: margin_5),
                              TextView(
                                  text: controller.servicesList?[index].rating
                                          ?.toString() ??
                                      "0",
                                  textStyle: textStyleBody2()
                                      .copyWith(color: Colors.black))
                            ],
                          )
                        ],
                      )),
                    ],
                  ),
                  bottomButton: Row(
                    children: [
                      _firstButton(index),
                      SizedBox(
                        width: margin_20,
                      ),
                      _secondButton(index)
                    ],
                  ).paddingOnly(top: margin_10),
                );
              }),
    );
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

  _firstButton(index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.nurseDetailRoute, arguments: {
            'id': controller.servicesList?[index].id,
            'date': controller.date,
            'serviceId': controller.serviceId,
            'dependentId': controller.dependentID,
            'typeId': controller.typeID,
            'categoryId': controller.catId,
            'workingZoneId': controller.workingzoneID,
            'zipcode': controller.zipcode,
            'titleOfService': controller.titleOfService
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius_5),
            border: Border.all(color: Colors.grey),
          ),
          child: TextView(
                  text: strDetails,
                  textStyle: textStyleBody2().copyWith(color: Colors.grey))
              .paddingSymmetric(vertical: margin_10),
        ),
      ),
    );
  }

  _secondButton(int index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.appointmentViewRoute, arguments: {
            'providerId': controller.servicesList?[index].id,
            'date': controller.date,
            'serviceId': controller.serviceId,
            'dependentId': controller.dependentID,
            'typeId': controller.typeID,
            'categoryId': controller.catId,
            'workingZoneId': controller.workingzoneID,
            'zipcode': controller.zipcode,
            'isFirst': true
          });
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius_5), color: darkPurple),
          child: TextView(
                  text: strBookNow,
                  textStyle: textStyleBody2().copyWith(color: Colors.white))
              .paddingSymmetric(vertical: margin_10),
        ),
      ),
    );
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
          maxLine: 2,
          textAlign: TextAlign.start,
        ).paddingOnly(bottom: margin_8)),
      ],
    );
  }
}
