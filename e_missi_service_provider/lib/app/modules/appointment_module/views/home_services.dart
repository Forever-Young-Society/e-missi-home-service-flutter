/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

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
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [appBarView2(title: strHomeServices), _gridView()],
          ).paddingSymmetric(horizontal: margin_20, vertical: margin_25),
        ],
      );

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
              if (index == 0) {
                Get.toNamed(AppRoutes.nursingService);
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
                    color: controller.selectedIndex == index
                        ? appColor
                        : Colors.white),
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
                      style: TextStyle(
                          color: controller.selectedIndex == index
                              ? Colors.white
                              : blackColor),
                    ),
                  ],
                )),
              ),
            ).paddingAll(margin_5),
          );
        });
  }
}
