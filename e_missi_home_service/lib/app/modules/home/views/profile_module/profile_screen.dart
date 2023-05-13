/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class ProfileScreen extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

/*========================================================_body============================================*/

  _body() => GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: TextDirection.ltr,
                children: [
                  _networkImage(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextView(
                        text:
                            '${controller.loginResponseModel.detail?.fullName?.toString().trimLeft() ?? ''}',
                        textStyle: textStyleBody1()
                            .copyWith(color: purple, fontSize: font_20),
                        textAlign: TextAlign.start,
                      ).paddingOnly(bottom: margin_5),
                      InkWell(
                        onTap: () async {
                          var data = await Get.toNamed(
                            AppRoutes.editProfile,
                          );
                          if (data == true) {
                            controller.hitprofileDetailApi();
                          }
                        },
                        child: Row(
                          children: [
                            TextView(
                                text: strEditProfile,
                                textStyle: textStyleBody2().copyWith(
                                  color: Colors.grey,
                                )).paddingOnly(right: margin_10),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: margin_12,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ).paddingOnly(bottom: margin_20, top: margin_10),
              TextView(
                  text: strDependentsLists,
                  textStyle: textStyleHeading2().copyWith(
                    color: Colors.black,
                  )).paddingOnly(bottom: margin_20),
              Expanded(
                child: Container(
                    child: GridView.builder(
                  itemCount: controller.dependentList.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1.0,
                      mainAxisSpacing: 10.0),
                  itemBuilder: (BuildContext context, int index) {
                    return index == 0
                        ? InkWell(
                            onTap: () async {
                              var data =
                                  await Get.toNamed(AppRoutes.addDependent);
                              if (data != null) {
                                controller.hitdepedentListApi();
                              }
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(margin_20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(radius_20),
                                      border: Border.all(
                                          color: Colors.grey, width: 2)),
                                  child: AssetImageWidget(
                                    color: Colors.grey,
                                    imageUrl: ic_outlineduser,
                                    imageHeight: height_30,
                                  ),
                                ).paddingOnly(bottom: margin_5),
                                TextView(
                                    maxLine: 5,
                                    text: strAddDependent,
                                    textStyle: textStyleBody2().copyWith(
                                        color: Colors.grey, fontSize: font_13)),
                              ],
                            ),
                          )
                        : InkWell(
                            onTap: () async {
                              var data = await Get.toNamed(
                                  AppRoutes.editDependent,
                                  arguments: {
                                    'id': controller.dependentList[index - 1].id
                                  });
                              if (data != null) {
                                controller.hitdepedentListApi();
                              }
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(margin_20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(radius_20),
                                      border: Border.all(
                                          color: darkkPurple, width: 2)),
                                  child: AssetImageWidget(
                                    color: darkkPurple,
                                    imageUrl: ic_user,
                                    imageHeight: height_30,
                                  ),
                                ).paddingOnly(bottom: margin_5),
                                TextView(
                                    maxLine: 1,
                                    text: controller
                                        .dependentList[index - 1].fullName,
                                    textStyle: textStyleBody2().copyWith(
                                        color: Colors.black,
                                        fontSize: font_13)),
                              ],
                            ),
                          );
                  },
                )),
              )
            ],
          ).marginSymmetric(horizontal: margin_20, vertical: margin_10),
        );
      });

  _networkImage() => Flexible(
        child: NetworkImageWidget(
          radiusAll: radius_80,
          imageHeight: height_70,
          placeHolder: ICON_avatar,
          imageUrl: controller.loginResponseModel.detail?.profileFile ?? "",
          errorImage: controller.loginResponseModel.detail?.gender == 1
              ? ICON_avatar_female
              : ICON_avatar,
        ).paddingOnly(right: margin_20),
      );
}
