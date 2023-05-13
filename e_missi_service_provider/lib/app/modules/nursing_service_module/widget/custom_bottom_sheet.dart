import '../../../../export.dart';

bottomSheet({widget, textLabel}) {
  return Get.bottomSheet(
      buildBottomSheetUi(widget: widget, textLabel: textLabel),
      backgroundColor: appLightColor,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius_20),
            topRight: Radius.circular(radius_20),
          )));
}

buildBottomSheetUi({widget, textLabel}) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [ _label(textLabel), widget],
    );

_label(textLabel) {
  return Text(textLabel,
          style: textStyleBody1()
              .copyWith(fontWeight: FontWeight.w700, fontSize: font_18))
      .paddingSymmetric(vertical: margin_25, horizontal: margin_20);
}
