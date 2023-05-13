/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../../export.dart';
import '../../widget/services_card_view.dart';

class HomeScreen extends GetView<HomeController> {
  final GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: titleNDrawerAppBar(
              title:
                  '${strWelcome} ${controller.loginResponseModel?.detail?.fullName.toString().trimLeft() ?? ""}',
              icon: ICON_menu,
              onPressed: () {
                scaffoldKey!.currentState!.openDrawer();
              }),
          drawer: customDrawer(controller),
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                  left: margin_15,
                  right: margin_15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    gridView(controller),
                    Text(
                      strOurServices,
                      style: TextStyle(color: purple, fontSize: font_20),
                    ).paddingOnly(bottom: margin_10),
                    ourServicesList(controller),
                    _croselSlder(controller),
                    _carouselIndicator(controller, images: ["1", "3", "5"]),
                  ],
                )),
          ),
        );
      },
    );
  }

  gridView(controller) {
    return Container(
        height: height_100,
        margin: EdgeInsets.only(bottom: margin_20, top: margin_10),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _userData(controller)),
              sizeBox(width: width_10),
              Expanded(
                  child: _topView(strHealthMonitoring, ICON_fys, lightBlue)),
              sizeBox(width: width_15),
              Expanded(
                  child: InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.serviceReportListScreen);
                },
                child:
                    _topView(strMyHealthRecord, ICON_medicalBook, lightGreen),
              )),
            ],
          ),
        ));
  }

  _userData(controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: AutoSizeText(
            controller.loginResponseModel?.detail?.fullName ?? "",
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              fontSize: font_12,
              color: purple,
              fontWeight: FontWeight.w500,
            ),
          ).paddingOnly(bottom: margin_7),
        ),
        controller.loginResponseModel?.detail?.profileFile == null ||
                controller.loginResponseModel?.detail?.profileFile == ''
            ? Flexible(
                flex: 2,
                child: AssetImageWidget(
                  imageUrl: controller.loginResponseModel?.detail?.gender == 1
                      ? ICON_avatar_female
                      : ICON_avatar,
                  imageHeight: height_50,
                  radiusAll: height_50,
                ),
              )
            : Flexible(flex: 2, child: _networkImage(controller)),
      ],
    ).paddingOnly(top: margin_6);
  }

  _topView(String value, image, color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: margin_5, vertical: margin_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(
              value,
              style: TextStyle(fontSize: font_13, color: Colors.black),
            ).paddingOnly(bottom: margin_5),
            Icon(
              Icons.arrow_right_alt,
              color: lightPurple,
              size: margin_20,
            )
          ]),
          Spacer(),
          AssetImageWidget(imageUrl: image, imageHeight: height_35)
        ],
      ),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 5)],
        color: color,
        borderRadius: BorderRadius.circular(radius_10),
      ),
    );
  }

  ourServicesList(HomeController controller) {
    return Container(
      height: height_150,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 3,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 20.0,
            childAspectRatio: 0.1),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                if (index == 0) {
                  Get.toNamed(AppRoutes.homeServiceScreenRoute);
                }
              },
              child: ServicesCommonCardView(
                  index: index,
                  title: controller.stringList[index],
                  boxColor: controller.colors[index],
                  image: controller.imgList1[index],
                  color: controller.comingSoonColors[index]));
        },
      ),
    );
  }

  /*========================Slider================================================================*/

  Widget _croselSlder(controller, {List<String>? images}) => CarouselSlider(
      items: ["1", "3", "5"]
          .map((e) => Container(
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    AssetImageWidget(
                            imageUrl: ICON_banner,
                            imageHeight: height_130,
                            imageWidth: Get.width,
                            imageFitType: BoxFit.fill)
                        .paddingSymmetric(horizontal: margin_15),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextView(
                              maxLine: 2,
                              textAlign: TextAlign.start,
                              text: 'We take care of\nYour health',
                              textStyle: textStyleBody2().copyWith(
                                  color: Colors.black,
                                  fontSize: font_18,
                                  fontWeight: FontWeight.w500),
                            ).paddingSymmetric(
                                horizontal: margin_30, vertical: margin_10),
                          ],
                        ).paddingOnly(
                          top: margin_25,
                          left: margin_40,
                          right: margin_25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextView(
                              text: 'Learn more',
                              textStyle: textStyleBody2().copyWith(
                                color: Colors.black,
                                fontSize: font_18,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.black,
                              size: margin_20,
                            ).paddingOnly(right: margin_70)
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ))
          .toList(),
      carouselController: controller.carouselController,
      options: CarouselOptions(
        viewportFraction: 1.0,
        aspectRatio: 2.4,
        initialPage: 0,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        onPageChanged: (index, __) {
          controller.onPageChange(postion: index);
        },
        scrollDirection: Axis.horizontal,
      ));

/*================================= build Carousel Indicator =================================*/

  _carouselIndicator(controller, {List<String>? images}) => Container(
        height: height_20,
        alignment: Alignment.center,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: images?.length ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return _buildIndictaor(controller, index);
            }),
      ).paddingOnly(bottom: margin_20);

  _buildIndictaor(
    controller,
    int index,
  ) =>
      Padding(
          padding: EdgeInsets.all(margin_5),
          child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: index == controller.selectedIndex ? height_10 : height_10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == controller.selectedIndex
                    ? purple
                    : Colors.grey.shade300,
              )));

  customDrawer(HomeController controller) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              profileHeader(controller),
              Divider(
                color: Colors.grey.shade500,
              ).paddingSymmetric(vertical: margin_10, horizontal: margin_10),
              listTile(
                  icon: ic_home,
                  text: strHome.tr,
                  onTap: () {
                    Get.back();
                  }),
              listTile(
                  icon: ic_profilePurple,
                  text: strProfileAccount,
                  onTap: () {
                    Get.back();
                    var mainController = Get.put(MainController());
                    mainController.selectedIndex = 1;
                    mainController.update();
                  }),
              listTile(
                  icon: ic_notifications,
                  text: strNotificationOrderSummary,
                  onTap: () {
                    Get.back();
                    var mainController = Get.put(MainController());
                    mainController.selectedIndex = 2;
                    mainController.update();
                  }),
              listTile(
                  icon: ic_payment,
                  text: strPaymentHistory,
                  onTap: () {
                    Get.back();
                    Get.toNamed(AppRoutes.paymentHistoryScreenRoute);
                  }),
              listTile(
                  icon: ICON_faq,
                  text: strFaqHelp,
                  onTap: () {
                    Get.back();
                    Get.toNamed(AppRoutes.faqRoute);
                  }),
              listTile(
                  icon: ICON_terms,
                  text: strTermsConditions,
                  onTap: () {
                    Get.toNamed(AppRoutes.staticPageRoute,
                        arguments: {typeKey: termsCondtionType});
                  }),
              listTile(
                  icon: ICON_logout,
                  text: strLogout,
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
                      color: purple,
                      imageUrl: icon,
                      imageHeight: height_20,
                      imageWidth: height_20,
                      imageFitType: BoxFit.contain)
                  .paddingOnly(right: radius_12),
              Expanded(
                child: Text(
                  text,
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: font_15),
                ),
              )
            ],
          ),
        ),
        onTap: () {
          onTap();
        },
      );

  titleNDrawerAppBar({title, icon, onPressed}) => PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Padding(
          padding: EdgeInsets.all(margin_15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    onPressed();
                  },
                  child: Icon(
                    Icons.menu_rounded,
                    color: darkPurple,
                    size: margin_30,
                  ).paddingOnly(right: margin_15)),
              Flexible(
                child: TextView(
                  maxLine: 2,
                  text: title,
                  textStyle: textStyleBody2().copyWith(
                    fontSize: font_18,
                    color: COLOR_russianVoilet,
                  ),
                ).paddingOnly(top: margin_2),
              ),
            ],
          ),
        ),
      );

  profileHeader(controller) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: margin_10),
        child: Row(
          children: [
            controller.loginResponseModel?.detail?.profileFile == '' ||
                    controller.loginResponseModel?.detail?.profileFile == null
                ? AssetImageWidget(
                        imageUrl:
                            controller.loginResponseModel?.detail?.gender == 0
                                ? ICON_avatar
                                : ICON_avatar_female,
                        imageHeight: height_70)
                    .paddingOnly(right: margin_10)
                : _networkImage(controller),
            sizeBox(width: width_10),
            Expanded(
              child: TextView(
                textAlign: TextAlign.start,
                text:
                    '${controller.loginResponseModel?.detail?.fullName?.toString().trimLeft() ?? ''}',
                textStyle:
                    textStyleBody2().copyWith(fontWeight: FontWeight.bold),
                maxLine: 2,
              ),
            ),
            InkWell(
                onTap: () {
                  Get.back();
                  var mainController = Get.put(MainController());
                  mainController.selectedIndex = 1;
                  mainController.update();
                },
                child: AssetImageWidget(
                    imageUrl: ic_settings, imageHeight: height_20))
          ],
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      );

  Widget _networkImage(controller) => NetworkImageWidget(
        radiusAll: height_60,
        imageHeight: height_60,
        placeHolder: ICON_avatar,
        imageUrl: controller.loginResponseModel?.detail?.profileFile ?? "",
      );
}
