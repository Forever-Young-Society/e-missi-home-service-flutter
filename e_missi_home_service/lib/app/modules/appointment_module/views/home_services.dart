/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class HomeServiceScreen extends GetView<HomeServiceController> {
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: GetBuilder<HomeServiceController>(
          init: HomeServiceController(),
          builder: (controller) {
            return Scaffold(body: _bodyWidget());
          },
        ));
  }

  /* ==================================================== build body of the screen =========================================================*/

  Widget _bodyWidget() => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AssetImageWidget(
            imageUrl: ic_tech_bg,
            imageFitType: BoxFit.cover,
            // imageHeight: Get.height,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [appBarView2(title: strHomeServices), Expanded(child: _gridView())],
          ).paddingSymmetric(horizontal: margin_20, vertical: margin_25),
        ],
      );

  _gridView() {
    return GridView.builder(
        itemCount: controller.categoryList!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
            childAspectRatio: 1.1),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              controller.selectedIndex = index;
              if (controller.categoryListResponse!.list![index].termAccepted ==
                  false) {
               await Get.toNamed(AppRoutes.homeServiceTermsRoute,
                    arguments: {
                      catKey: controller.categoryListResponse!.list![index].id,
                      serviceTitle:controller.categoryListResponse!.list![index].title
                    });
                  controller.hitServiceCategoryAPI();

              } else {
                Get.toNamed(AppRoutes.nursingService, arguments: {
                  catKey: controller.categoryListResponse!.list![index].id,
                  serviceTitle:controller.categoryListResponse!.list![index].title,
                });
              }

              controller.update();
            },
            child: homeServicesCard(index: index),
          );
        });
  }

  homeServicesCard({index}) {
    return Card(
      elevation: margin_3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius_10)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius_10),
            color: controller.selectedIndex == index ? appColor : Colors.white),
        child: Center(
            child: Column(
          children: [
            NetworkImageWidget(
              imageUrl: controller.categoryList![index].imageFile,
              imageFitType: BoxFit.cover,
              imageHeight: height_60,
            ).paddingOnly(top: margin_20, bottom: margin_10),
            Text(
              controller.categoryList![index].title ?? "",
              style: TextStyle(
                  color: controller.selectedIndex == index
                      ? Colors.white
                      : blackColor),
            ),
          ],
        )),
      ),
    ).paddingAll(margin_5);
  }
}
