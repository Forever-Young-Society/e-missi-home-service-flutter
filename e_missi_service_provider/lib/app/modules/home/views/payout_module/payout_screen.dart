/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class PayOutScreen extends GetView<PayOutControllerController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PayOutControllerController>(
        init: PayOutControllerController(),
        builder: (controller) {
          return _body();
        });
  }

/*========================================================_body============================================*/

  Widget _body() => Container(
        margin: EdgeInsets.only(
            top: margin_20,
            left: margin_20,
            right: margin_20,
            bottom: margin_8),
        child: Column(
          children: [
            headingTextView(),
            sizeBox(height: height_20),
            resetCardView(),
            weekOptionsList(),
            _tabBarView(),
          ],
        ),
      );

/*===================================================reset Card View============================================*/

  resetCardView() {
    return CommonCardView(
      child: Column(
        children: [
          sizeBox(height: height_10),
          TextView(
              text: "\$11030",
              textStyle: textStyleHeading().copyWith(
                color: greenColor,
              )),
          sizeBox(height: height_5),
          TextView(
              text: "$strAmountReceived 30 September, 2022",
              textStyle: textStyleSubTitle().copyWith(
                color: Colors.grey.shade500,
              )),
          sizeBox(height: height_8),
          MaterialButtonWidget(
            padding: height_10,
            onPressed: () {
              debugPrint("onPressed");
            },
            minWidth: height_120,
            buttonText: strReset,
          ),
          sizeBox(height: height_12),
        ],
      ),
    );
  }

/*================================================heading Text View============================================*/

  headingTextView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextView(
            text: strTransactionHistory,
            textStyle: textStyleHeading2().copyWith()),
        TextView(
            text: strReset,
            textStyle: textStyleHeading2().copyWith(
              color: appColor,
            )),
      ],
    );
  }

  /*===========================================_tabBarView=========================================*/

  Widget _tabBarView() {
    return Expanded(
      child: TabBarView(controller: controller.tabController, children: [
        transactionListView(),
        transactionListView(),
        transactionListView(),
        transactionListView(),
      ]),
    );
  }

  /*============================================weekListView===========================================*/

  transactionListView() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: controller.weekList.length,
      itemBuilder: (BuildContext context, int index) {
        return Obx(
          () => InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              controller.updateTransactionValue(index);
            },
            child: PayOutView(
              borderColor: controller.selectedTransaction.value == index
                  ? appColor
                  : Colors.transparent,
            ),
          ),
        );
      },
    );
  }

  /* ====================================================options list==============================================*/
  Widget weekOptionsList() {
    return Container(
        height: height_40,
        width: Get.width,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(244, 244, 244, 1.0),
            borderRadius: BorderRadius.circular(radius_20),
            border: Border.all(color: Colors.grey.shade200)),
        child: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          labelStyle: textStyleBody1()
              .copyWith(fontSize: font_12point5, fontWeight: FontWeight.w700),
          indicator: BoxDecoration(
              color: appColor, borderRadius: BorderRadius.circular(radius_20)),
          controller: controller.tabController,
          tabs: const [
            Tab(
              text: strToday,
            ),
            Tab(
              text: strWeekly,
            ),
            Tab(
              text: strMonthly,
            ),
            Tab(
              text: strYearly,
            ),
          ],
        )).paddingOnly(top: margin_20, bottom: margin_20);
  }
}
