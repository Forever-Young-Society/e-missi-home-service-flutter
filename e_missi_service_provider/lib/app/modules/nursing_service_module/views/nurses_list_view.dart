import 'package:e_missi_service_provider/export.dart';

class NursesListScreen extends GetView<NursesListController> {
  @override
  Widget build(BuildContext context) {
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
  }

  _listView() {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
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
                              textStyle: textStyleBody2()
                                  .copyWith(color: Colors.black))
                          .paddingOnly(bottom: margin_10),
                      description(
                          descriptionHeading: 'Service Area',
                          descriptionSubHeading: 'mohali'),
                      description(
                          descriptionHeading: 'Age',
                          descriptionSubHeading: '55'),
                      description(
                          descriptionHeading: strGender,
                          descriptionSubHeading: 'Male'),
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
                  _firstButton(),
                  SizedBox(
                    width: margin_20,
                  ),
                  _secondButton()
                ],
              ).paddingOnly(top: margin_10),
            );
          }),
    );
  }

  _firstButton() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.nurseDetailRoute);
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

  _secondButton() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.appointmentViewRoute);
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
          maxLine: 1,
          textAlign: TextAlign.start,
        ).paddingOnly(bottom: margin_8)),
      ],
    );
  }
}
