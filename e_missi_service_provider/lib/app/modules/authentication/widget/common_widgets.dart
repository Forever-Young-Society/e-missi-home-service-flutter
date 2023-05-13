import 'package:e_missi_service_provider/app/core/widget/custom_loader.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../export.dart';

checkTitleText({bool? tick, title, onTap, textColor, hideCheckBox}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        hideCheckBox == null
            ? AssetImageWidget(
                    imageUrl: tick == true ? ic_check_true : ic_check_false,
                    imageHeight: height_18)
                .paddingOnly(right: margin_5)
            : SizedBox(),
        Expanded(
          child: TextView(
            text: title,
            textAlign: TextAlign.start,
            textStyle: TextStyle(
                fontWeight: FontWeight.w400, fontSize: font_13, color: textColor),
            maxLine: 2,
          ),
        )
      ],
    ).paddingOnly(top: margin_10),
  );
}

openDropdown(key) {
  GestureDetector? detector;
  searchForGestureDetector(BuildContext? element) {
    element?.visitChildElements((element) {
      if (element.widget is GestureDetector) {
        detector = element.widget as GestureDetector?;
      } else {
        searchForGestureDetector(element);
      }
    });
  }

  searchForGestureDetector(key.currentContext);
  assert(detector != null);

  detector?.onTap!();
}


convertDateToNormalTime({dateString}) {
  if (dateString != null && dateString != "") {
    var strToDateTime = DateTime.parse(dateString.toString() + 'Z');
    final convertLocal = strToDateTime;
    DateFormat newFormat = DateFormat("hh:mm a");
    return newFormat.format(convertLocal).toLowerCase();
  }
}
convertDateToNormalDate({dateString}) {
  if (dateString != null && dateString != "") {
    var strToDateTime = DateTime.parse(dateString.toString() + 'Z');
    final convertLocal = strToDateTime;
    DateFormat newFormat = DateFormat("dd MMMM yyyy");
    return newFormat.format(convertLocal);
  }
}
convertDateToSendDate({dateString}) {
  if (dateString != null && dateString != "") {
    var strToDateTime = DateTime.parse(dateString.toString() + 'Z');
    final convertLocal = strToDateTime;
    DateFormat newFormat = DateFormat("yyyy-MM-dd");
    return newFormat.format(convertLocal);
  }
}
final Repository _repository = Get.find<Repository>();


reportCrash(stackTrace) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  CustomLoader customLoader = CustomLoader();
  var req = AuthRequestModel.logCrashErrorReq(
      error: 'com.jom_fys',
      packageVersion:version,
      phoneModel: _repository.deviceName,
      ip: _repository.deviceVersion,
      stackTrace: stackTrace);
  debugPrint('Log req: $req', wrapWidth: 1000);
  await _repository.reportCrashLogApiCall(data: req)
      .then((value) async {
    customLoader.hide();
    if (value != null) {
    }
  }).onError((error, stackTrace) {
    customLoader.hide();
    initApp();
    flashBar(message: error.toString());
  });
}

Future<void> requestPermissions(
    List<Permission> permissionType, Function(bool data) onTap) async {
  Map<Permission, PermissionStatus> statuses = await permissionType.request();

  if (statuses[Permission.camera] == PermissionStatus.granted &&
      statuses[Permission.storage] == PermissionStatus.granted) {
    onTap(true);
  } else if (statuses[Permission.camera] ==
      PermissionStatus.permanentlyDenied ||
      statuses[Permission.storage] == PermissionStatus.permanentlyDenied) {
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
  } else {
    await Permission.camera.request();
    await Permission.storage.request();
  }
}
