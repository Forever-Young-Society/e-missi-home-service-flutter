/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import '../../../../../export.dart';

class HomeScreen extends GetView<HomeController> {
  final GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return SafeArea(
            child: Scaffold(
                key: scaffoldKey,
                resizeToAvoidBottomInset: false,
                appBar: titleNDrawerAppBar(
                    title:
                        '${strWelcome}, ${controller.loginResponseModel?.detail?.fullName?.toString().trimLeft() ?? ""}',
                    icon: ICON_menu,
                    onPressed: () {
                      scaffoldKey!.currentState!.openDrawer();
                    }),
                drawer: customDrawer(),
                body: _gridView()));
      },
    );
  }

  _gridView() {
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.gridItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
            childAspectRatio: 1.1),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              controller.selectedIndex = index;
              switch (index) {
                case 0:
                  {
                    Get.toNamed(AppRoutes.myBusinessCalendarScreen);
                  }
                  break;
                case 1:
                  {
                    Get.find<MainController>().selectedIndex = 4;
                    Get.find<MainController>().update();
                    controller.update();
                  }
                  break;

                case 2:
                  {
                    Get.toNamed(AppRoutes.myBookingHistoryScreen);
                  }
                  break;
                case 3:
                  {
                    Get.toNamed(AppRoutes.ratingScreen);
                  }
                  break;
              }

              controller.update();
            },
            child: Card(
              elevation: margin_3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius_10)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius_10),
                    color: Colors.white),
                child: Center(
                    child: Column(
                  children: [
                    AssetImageWidget(
                      imageUrl: controller.gridItems[index].icon ?? "",
                      imageFitType: BoxFit.cover,
                      imageHeight: height_60,
                    ).paddingOnly(top: margin_20, bottom: margin_10),
                    Text(
                      controller.gridItems[index].title ?? "",
                      style: TextStyle(color: blackColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
              ),
            ).paddingAll(margin_5),
          );
        }).paddingAll(margin_10);
  }

  customDrawer() => Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: margin_20,
              ),
              profileHeader(),
              Divider(
                color: Colors.grey.shade500,
              ).paddingSymmetric(vertical: margin_20, horizontal: margin_10),
              listTile(
                  icon: ic_home,
                  text: strHome.tr,
                  onTap: () {
                    scaffoldKey!.currentState!.closeDrawer();
                  }),
              listTile(
                  icon: ic_profilePurple,
                  text: strProfileAccount.tr,
                  onTap: () {
                    Get.find<MainController>().selectedIndex = 2;
                    Get.find<MainController>().update();
                    controller.update();
                  }),
              listTile(
                  icon: ic_notifications,
                  text: strNotificationOrderSummary.tr,
                  onTap: () {
                    Get.find<MainController>().selectedIndex = 1;
                    Get.find<MainController>().update();
                    controller.update();
                  }),
              listTile(
                  icon: ic_booking_appointment,
                  text: strMyCalendar.tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.myBusinessCalendarScreen);
                  }),
              listTile(
                  icon: ic_booking_appointment,
                  text: strBookingAppointment.tr,
                  onTap: () {
                    Get.find<MainController>().selectedIndex = 4;
                    Get.find<MainController>().update();
                    controller.update();
                  }),
              listTile(
                  icon: ic_booking_historys,
                  text: strBookingHistory.tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.myBookingHistoryScreen);
                  }),
              listTile(
                  icon: ic_service_report,
                  text: strServiceReport.tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.serviceReportListScreen);
                  }),
              listTile(
                  icon: ic_star_empty,
                  text: strMyRatingReview.tr,
                  onTap: () {
                    Get.toNamed(AppRoutes.ratingScreen);
                  }),
              listTile(
                  icon: ICON_faq,
                  text: strFaqHelp,
                  onTap: () {
                    Get.back();
                    Get.toNamed(AppRoutes.faqRoute);
                  }),
              listTile(
                  icon: ICON_logout,
                  text: strLogout.tr,
                  onTap: () {
                    logoutDialog(
                        text: strLogoutHeading,
                        confirmText: strLogout,
                        onTap: () {
                          controller.logoutApiCall();
                        });
                  }),
              listTile(
                  icon: ic_delete,
                  text: strDeleteAccount,
                  onTap: () {
                    logoutDialog(
                        text: strAccountHeading,
                        confirmText: strDelete,
                        onTap: () {
                          controller.deleteAccountApiCall();
                        });
                  }),
            ],
          ),
        ),
      );

  listTile({text, icon, onTap}) => InkWell(
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_15),
          child: Row(
            children: [
              AssetImageWidget(
                      imageUrl: icon,
                      imageHeight: height_20,
                      imageWidth: height_20,
                      imageFitType: BoxFit.contain)
                  .paddingOnly(right: radius_12),
              Text(
                text,
                style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: font_15),
              )
            ],
          ),
        ),
        onTap: () {
          scaffoldKey!.currentState!.closeDrawer();
          onTap();
        },
      );

  titleNDrawerAppBar({title, icon, onPressed}) => PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Padding(
          padding: EdgeInsets.all(margin_16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    onPressed();
                  },
                  child: Icon(
                    Icons.menu_rounded,
                    color: darkPurple,
                    size: margin_30,
                  ).paddingOnly(right: margin_15, bottom: margin_5)),
              Flexible(
                child: TextView(
                  text: title,
                  textStyle: textStyleBody2().copyWith(
                    fontSize: font_16,
                    color: COLOR_russianVoilet,
                  ),
                  maxLine: 2,
                ),
              ),
            ],
          ),
        ),
      );

  profileHeader() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NetworkImageWidget(
                    imageUrl:
                        "${controller.loginResponseModel?.detail?.profileFile ?? ""}",
                    radiusBottomRight: radius_30,
                    radiusTopLeft: radius_30,
                    radiusBottomLeft: radius_30,
                    radiusTopRight: radius_30,
                    imageHeight: height_50,
                    imageWidth: height_50,
                    imageFitType: BoxFit.fill,
                    errorImage:
                        controller.loginResponseModel?.detail?.gender == 0
                            ? ICON_avatar
                            : ICON_avatar_female,
                  ).paddingOnly(right: margin_10),
                  Flexible(
                    child: TextView(
                      text:
                          'Hi, ${controller.loginResponseModel?.detail?.fullName.toString().trimLeft() ?? ""}',
                      textStyle: textStyleBody2()
                          .copyWith(fontWeight: FontWeight.bold),
                      maxLine: 2,
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
            InkWell(
                onTap: () {
                  Get.find<MainController>().selectedIndex = 2;
                  Get.find<MainController>().update();
                  controller.update();
                },
                child: AssetImageWidget(
                    imageUrl: ic_settings, imageHeight: height_20))
          ],
        ),
      );
}
