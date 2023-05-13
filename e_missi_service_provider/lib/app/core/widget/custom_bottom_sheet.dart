import '../../../export.dart';

bottomSheet({widget}) {
  return showModalBottomSheet(
      enableDrag: true,
      context: Get.context!,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(margin_25))),
      builder: (BuildContext context) {
        return buildBottomSheetUi(widget: widget);
      });
}

buildBottomSheetUi({widget}) => Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget,
        ],
      ),
    );
