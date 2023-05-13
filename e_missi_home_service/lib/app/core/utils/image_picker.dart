/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';
import 'package:permission_handler/permission_handler.dart';

/*=================================================================== Image Pick Using camera ===================================================*/

Future<PickedFile?> imageFromCamera() async {
  try {
    var pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile == null) {
      showInSnackBar(message: strNoImageClicked);
    } else {
      return cropImage(pickedFile.path);
    }
    return null;
  } catch (e) {
    Get.defaultDialog(
        title: 'Permission Required!',
        content: Column(
          children: [
            TextView(
                text: 'Please enable required permission !',
                maxLine: 3,
                textStyle: textStyleHeading2().copyWith(fontSize: font_14)),
            SizedBox(
              height: height_20,
            ),
            Row(
              children: [
                Expanded(
                    child: MaterialButtonWidget(
                  buttonText: strNo,
                  onPressed: () {
                    Get.back();
                  },
                  textColor: Colors.white,
                ).paddingSymmetric(horizontal: margin_20)),
                Expanded(
                    child: MaterialButtonWidget(
                  buttonText: 'Allow',
                  textColor: Colors.white,
                  onPressed: () {
                    Get.back();
                    openAppSettings();
                  },
                ).paddingSymmetric(horizontal: margin_20)),
              ],
            )
          ],
        ));
  }
}

/*=================================================================== Image Pick Using Gallery ===================================================*/

Future<PickedFile?> imageFromGallery() async {
  var pickedFile = await ImagePicker()
      .pickImage(source: ImageSource.gallery, imageQuality: 100);
  if (pickedFile == null) {
    showInSnackBar(message: strNoImageSelected);
  } else {
    return cropImage(pickedFile.path);
  }
  return null;
}

Future<PickedFile?> cropImage(filePath) async {
  var croppedImage = await ImageCropper().cropImage(
    sourcePath: filePath,
    aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    aspectRatioPresets: [CropAspectRatioPreset.original],
  );
  if (croppedImage == null) {
    showInSnackBar(message: strNoImage);
  } else {
    return PickedFile(croppedImage.path);
  }
  return null;
}
