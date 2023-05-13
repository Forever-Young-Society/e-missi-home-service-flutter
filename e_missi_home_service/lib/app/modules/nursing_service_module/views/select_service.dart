/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class SelectServiceTypsScreen extends GetView<SelectServiceController> {
  var onTap;

  @override
  SelectServiceTypsScreen({this.onTap});

  Widget build(BuildContext context) {
    return GetBuilder<SelectServiceController>(
      init: SelectServiceController(),
      builder: (controller) {
        return Container(
          height: Get.height * 0.7,
          child: Column(
            children: [
              Divider(
                color: Colors.grey.shade300,
                thickness: margin_2,
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [_list(), _cancelAdd(onTap)],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _list() {
    return ListView.separated(
        padding: EdgeInsets.only(bottom: margin_90),
        itemBuilder: (context, index) {
          SubCategoryDataModel item =
              Get.find<NursingServiceController>().subCategoryList![index];

          return item.subServices != null && item.subServices!.length != 0
              ? Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                      childrenPadding:
                          EdgeInsets.symmetric(horizontal: margin_20),
                      tilePadding: EdgeInsets.zero,
                      iconColor: appColor,
                      collapsedIconColor: appColor,
                      title: Text(item.title, style: textStyleHeading2()),
                      children: [
                        ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return checkTitleText(
                                  tick: item.subServices![index].isSelected,
                                  title: item.subServices![index].title,
                                  onTap: () {
                                    Get.find<NursingServiceController>()
                                            .combinationCount =
                                        item.subServices![index]
                                            .combinationCount;
                                    if (item.subServices!
                                            .where((e) => e.isSelected == true)
                                            .toList()
                                            .length >=
                                        item.subServices![index]
                                            .combinationCount) {
                                      if (item.subServices![index].isSelected ==
                                          true) {
                                        item.subServices![index].isSelected =
                                            !item.subServices![index]
                                                .isSelected!;
                                        Get.find<NursingServiceController>()
                                            .selectedSubServices
                                            .remove(
                                                item.subServices![index].id);
                                      } else {
                                        flashBar(message: strCombinationoftwo);
                                      }
                                    } else {
                                      item.subServices![index].isSelected =
                                          !item.subServices![index].isSelected!;
                                      Get.find<NursingServiceController>()
                                          .selectedIndex = null;
                                      Get.find<NursingServiceController>()
                                          .selectedSubCatId = item.id;
                                      _clearSelection();
                                      if (Get.find<NursingServiceController>()
                                          .selectedSubServices
                                          .contains(
                                              item.subServices![index].id)) {
                                        Get.find<NursingServiceController>()
                                            .selectedSubServices
                                            .remove(
                                                item.subServices![index].id);
                                        Get.find<NursingServiceController>()
                                            .update();
                                      } else {
                                        Get.find<NursingServiceController>()
                                            .selectedSubServices
                                            .add(item.subServices![index].id);
                                        Get.find<NursingServiceController>()
                                            .update();
                                      }
                                    }

                                    controller.update();
                                  });
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: height_10);
                            },
                            itemCount: item.subServices?.length ?? 0)
                      ]).paddingSymmetric(horizontal: margin_20),
                )
              : inkWell(
                  ontap: () {
                    for (var i = 0;
                        i <
                            Get.find<NursingServiceController>()
                                .subCategoryList!
                                .length;
                        i++) {
                      for (var j = 0;
                          j <
                              Get.find<NursingServiceController>()
                                  .subCategoryList![i]
                                  .subServices!
                                  .length;
                          j++) {
                        Get.find<NursingServiceController>()
                            .subCategoryList![i]
                            .subServices![j]
                            .isSelected = false;
                        controller.update();
                      }
                    }
                    Get.find<NursingServiceController>().selectedSubServices =
                        [];
                    Get.find<NursingServiceController>().subCategoryList?.map(
                        (e) => e.subServices?.map((e) => e.isSelected = false));
                    print("daata of list${item.subServices}");
                    Get.find<NursingServiceController>().selectedIndex = index;
                    controller.update();
                  },
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                              Get.find<NursingServiceController>()
                                      .subCategoryList![index]
                                      .title ??
                                  "",
                              style: textStyleBody1())),
                      sizeBox(width: width_10),
                      Get.find<NursingServiceController>().selectedIndex ==
                              index
                          ? AssetImageWidget(
                              imageUrl: ic_check,
                              imageHeight: height_15,
                            )
                          : Container()
                    ],
                  ).paddingSymmetric(
                      vertical: margin_15, horizontal: margin_20),
                );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey.withOpacity(0.7),
          );
        },
        itemCount:
            Get.find<NursingServiceController>().subCategoryList!.length);
  }

  _cancelAdd(onTap) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: margin_3,
            blurRadius: margin_3)
      ]),
      child: Row(
        children: [
          Expanded(
              child: MaterialButtonWidget(
            onPressed: () {
              Get.find<NursingServiceController>().selectedIndex = null;
              Get.find<NursingServiceController>()
                  .serviceTextEditingController!
                  .clear();
              Get.find<NursingServiceController>().update();
              for (var i = 0;
                  i <
                      Get.find<NursingServiceController>()
                          .subCategoryList!
                          .length;
                  i++) {
                for (var j = 0;
                    j <
                        Get.find<NursingServiceController>()
                            .subCategoryList![i]
                            .subServices!
                            .length;
                    j++) {
                  Get.find<NursingServiceController>()
                      .subCategoryList![i]
                      .subServices![j]
                      .isSelected = false;
                  controller.update();
                }
              }
              Get.find<NursingServiceController>().selectedSubServices = [];
              Get.back();
            },
            borderColor: Colors.grey,
            buttonText: strCancel,
            textColor: Colors.grey,
            buttonColor: Colors.white,
          )),
          sizeBox(width: width_20),
          Expanded(
              child: MaterialButtonWidget(
            onPressed: onTap ?? () {},
            borderColor: appColor,
            buttonText: strSubmit,
            textColor: Colors.white,
            buttonColor: appColor,
          )),
        ],
      ).paddingSymmetric(horizontal: margin_20, vertical: margin_20),
    );
  }

  _clearSelection() {
    Get.find<NursingServiceController>().subCategoryList?.forEach((subCat) {
      subCat.subServices?.forEach((subService) {
        if (subCat.id != Get.find<NursingServiceController>().selectedSubCatId)
          subService.isSelected = false;

        print(
            "length of the list${Get.find<NursingServiceController>().selectedSubServices.length}");
      });
      // Get.find<NursingServiceController>().selectedSubServices = [];
    });
    Get.find<NursingServiceController>().selectedIndex = null;
  }
}
