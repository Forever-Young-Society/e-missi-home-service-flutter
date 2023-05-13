/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import '../../../../export.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<OnboardingController>(
        init: OnboardingController(),
        builder: (controller) => _bodyWidget(),
      ),
    );
  }

  SizedBox _bodyWidget() => SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: PageView(
                  physics: ScrollPhysics(),
                  children: controller.listOfScreens,
                  onPageChanged: (value) {
                    controller.onSlide(value);
                    controller.update();
                  },
                  controller: controller.controller,
                )),
                controller.selectedPageIndex == 0
                    ? Container(
                        color: Colors.grey.shade200,
                        height: 1,
                      )
                    : SizedBox(),
                controller.selectedPageIndex == 2
                    ? InkWell(
                        onTap: () {
                          controller.moveToMainScreenRoute();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: height_60,
                          width: Get.width,
                          child: Text(
                            'GET STARTED!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: font_20,
                                fontWeight: FontWeight.bold),
                          ),
                          decoration: BoxDecoration(color: lightPurple),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _skipText(),
                          _indicatorWidget(),
                          _nextMoveButton()
                        ],
                      ),
              ],
            ),
          ],
        ),
      );

  /*=================================================_skipText============================================*/

  Widget _skipText() => InkWell(
        highlightColor: Colors.transparent,
        onTap: () {
          controller.moveToMainScreenRoute();
        },
        child: Container(
          color: Colors.white,
          child: TextView(
            textStyle: textStyleBody1().copyWith(color: blackLightColor),
            text: strSkip,
          ),
        ).paddingAll(margin_20),
      );

  /*========================================================_indicatorWidget===============================================*/

  _indicatorWidget() => SizedBox(
      height: height_25,
      child: ListView.builder(
        itemCount: controller.listOfScreens.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: height_10,
              width:
                  index == controller.selectedPageIndex ? height_10 : height_10,
              decoration: BoxDecoration(
                  color: index == controller.selectedPageIndex
                      ? purple
                      : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(radius_30)),
            ).paddingOnly(left: margin_15)
          ],
        ),
      ));

  /*=============================================================_nextMoveButton==============================================*/

  Widget _nextMoveButton() => InkWell(
        highlightColor: Colors.transparent,
        onTap: () {
          controller.movePageAction();
        },
        child: Container(
          color: Colors.white,
          child: TextView(
            textStyle: textStyleBody1().copyWith(color: blackLightColor),
            text: strNext,
          ),
        ).paddingAll(margin_20),
      );
}
