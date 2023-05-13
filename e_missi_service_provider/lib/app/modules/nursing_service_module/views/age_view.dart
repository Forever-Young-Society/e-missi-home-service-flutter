import '../../../../export.dart';

class AgeViewScreen extends GetView<AgeViewController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(radius_20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(strSelectAge,
                  style: textStyleBody1().copyWith(fontWeight: FontWeight.bold))
              .paddingAll(margin_20),
          sizeBox(height: height_20),
          _ageScrollView(),
          sizeBox(height: height_20),
          Divider(color: Colors.grey),
          _cancelSubmit()
        ],
      ),
    );
  }

  _ageScrollView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Obx(() => ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 150.0, maxWidth: 120.0),
                child: ListWheelScrollView(
                  magnification: 1.5,
                  useMagnifier: true,
                  squeeze: 0.7,
                  controller: controller.scrollController,
                  onSelectedItemChanged: (x) {
                    controller.currentIndex.value = x;
                    controller.update();
                  },
                  children: List.generate(
                      80,
                      (x) => Container(
                          width: 50,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.grey)),
                          ),
                          child: Text('$x',
                              style: textStyleBody1().copyWith(
                                color: x == controller.currentIndex.value
                                    ? Colors.black
                                    : Colors.grey,
                                fontSize: font_14,
                                fontWeight: x == controller.currentIndex.value
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                              )))),
                  itemExtent: 40,
                )))),
        Text(strYearsOld,
            style: textStyleBody1().copyWith(
              color: Colors.black,
              fontSize: font_16,
              fontWeight: FontWeight.w500,
            ))
      ],
    );
  }

  _cancelSubmit() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: inkWell(
          ontap: () {
            Get.back();
          },
          child: Center(
            child: Text(strCancel, style: textStyleBody1())
                .paddingSymmetric(vertical: margin_20),
          ),
        )),
        SizedBox(
          height: height_55,
          child: VerticalDivider(
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: inkWell(
            ontap: () {
              Get.back();
            },
            child: Text(strSubmit.capitalizeFirst!,
                    textAlign: TextAlign.center,
                    style: textStyleBody1().copyWith(color: appColor))
                .paddingSymmetric(vertical: margin_20),
          ),
        ),
      ],
    );
  }
}
