/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class ImagePickerDialogWidget extends StatelessWidget {
  final String action;
  final int recordId;
  final String title;
  final galleryFunction;
  final cameraFunction;
  final Function(dynamic) voidCallback;

  const ImagePickerDialogWidget(
      {Key? key,
      required this.action,
      required this.recordId,
      required this.title,
      required this.galleryFunction,
      required this.cameraFunction,
      required this.voidCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            width: Get.width,
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(margin_5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _dialogButton(),
              ],
            ).marginAll(margin_20)),
        _cancelButton()
      ],
    ).marginAll(margin_10);
  }

  _cancelButton() => MaterialButtonWidget(
        onPressed: () {
          Get.back();
        },
        fontsize: font_15,
        buttonRadius: margin_5,
        buttonColor: Colors.white,
        textColor: Colors.black,
        buttonText: strCancel,
      ).paddingSymmetric(vertical: margin_15);

  Widget _dialogButton() => Column(
        children: [
          InkWell(
            onTap: cameraFunction,
            child: TextView(
              text: strTakeImage,
              textStyle: textStyleBody1(),
              textAlign: TextAlign.start,
            ).paddingSymmetric(vertical: margin_12),
          ),
          Divider(
            color: Colors.grey.shade300,
            thickness: margin_1,
          ),
          InkWell(
            onTap: galleryFunction,
            child: TextView(
              text: strChooseImage,
              textStyle: textStyleBody1(),
              textAlign: TextAlign.start,
            ).paddingSymmetric(vertical: margin_12),
          )
        ],
      );
}
