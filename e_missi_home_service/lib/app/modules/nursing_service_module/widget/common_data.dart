import 'package:e_missi_home_service/app/core/widget/custom_loader.dart';
import 'package:e_missi_home_service/export.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

getContainer(child) {
  return Container(
    width: Get.width,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(margin_15),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: margin_3,
              blurRadius: margin_3)
        ]),
    child: child,
  );
}

inkWell({child, ontap}) {
  return InkWell(
    child: child,
    onTap: ontap,
  );
}

convertDateToNormalTime({dateString}) {
  if (dateString != null && dateString != "") {
    var strToDateTime = DateTime.parse(dateString.toString() + 'Z');
    final convertLocal = strToDateTime;
    DateFormat newFormat = DateFormat("hh:mm a");
    return newFormat.format(convertLocal).toLowerCase();
  }
}

convertDateSendDate({dateString}) {
  if (dateString != null && dateString != "") {
    var strToDateTime = DateTime.parse(dateString.toString() + 'Z');
    final convertLocal = strToDateTime;
    DateFormat newFormat = DateFormat("yyyy-MM");
    return newFormat.format(convertLocal).toLowerCase();
  }
}

convertDateNormalDate({dateString}) {
  if (dateString != null && dateString != "") {
    var strToDateTime = DateTime.parse(dateString.toString() + 'Z');
    final convertLocal = strToDateTime;
    DateFormat newFormat = DateFormat("yyyy-MM-dd");
    return newFormat.format(convertLocal).toLowerCase();
  }
}

getDate(String startime, String endtime) {
  if (startime != null &&
      startime.isNotEmpty &&
      endtime != null &&
      endtime.isNotEmpty) {
    String date = DateFormat("dd MMMM yyyy").format(DateTime.parse(startime));
    String startTime = DateFormat("hh:mm a").format(DateTime.parse(startime));
    String endTime = DateFormat("hh:mm a").format(DateTime.parse(endtime));
    return date + " - " + startTime + " - " + endTime;
  } else {
    return "";
  }
}

getStartEndTIme(String startime, String endtime) {
  if (startime != null &&
      startime.isNotEmpty &&
      endtime != null &&
      endtime.isNotEmpty) {
    String startTime = DateFormat("hh:mm a").format(DateTime.parse(startime));
    String endTime = DateFormat("hh:mm a").format(DateTime.parse(endtime));
    return startTime + " - " + endTime;
  } else {
    return "";
  }
}

getDateString(String startime) {
  if (startime != null && startime.isNotEmpty) {
    String date = DateFormat("dd MMMM yyyy").format(DateTime.parse(startime));
    return date;
  } else {
    return "";
  }
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

validateDateUserData(value) {
  if (value != null && value.isNotEmpty) {
    return value;
  } else {
    return keyDataIsNotAddedYet;
  }
}

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
                fontWeight: FontWeight.w400,
                fontSize: font_13,
                color: textColor),
            maxLine: 2,
          ),
        )
      ],
    ).paddingOnly(top: margin_10),
  );
}

final Repository _repository = Get.find<Repository>();

reportCrash(stackTrace) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  CustomLoader customLoader = CustomLoader();
  var req = AuthRequestModel.logCrashErrorReq(
      error: 'com.emissi.homeservice',
      packageVersion: version,
      phoneModel: _repository.deviceName,
      ip: _repository.deviceVersion,
      stackTrace: stackTrace);
  debugPrint('Log req: $req', wrapWidth: 1000);
  await _repository.reportCrashLogApiCall(data: req).then((value) async {
    customLoader.hide();
    if (value != null) {}
  }).onError((error, stackTrace) {
    customLoader.hide();
    initApp();
    flashBar(message: error.toString());
  });
}
