import '../../../../export.dart';

bottomSheet({widget, textLabel, isSlotColor, isSlot, slotHeight}) {
  return Get.bottomSheet(
      buildBottomSheetUi(
          widget: widget,
          textLabel: textLabel,
          isSlot: isSlot,
          slotHeight: slotHeight),
      backgroundColor: isSlotColor ?? Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(radius_20),
              topLeft: Radius.circular(radius_20))));
}

buildBottomSheetUi({widget, textLabel, isSlot, slotHeight}) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [isSlot ?? _divider(), _label(textLabel, slotHeight), widget],
    );

_divider() {
  return Center(
    child: Container(
      width: Get.width * 0.28,
      height: height_5,
      margin: EdgeInsets.only(top: margin_10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius_20),
        child: Divider(
          color: Colors.grey.shade300,
          thickness: margin_5,
        ),
      ),
    ),
  );
}

_label(textLabel, isSlot) {
  return Text(textLabel,
          style: textStyleBody1()
              .copyWith(fontWeight: FontWeight.w700, fontSize: font_18))
      .paddingSymmetric(vertical: isSlot ?? margin_25, horizontal: margin_20);
}
