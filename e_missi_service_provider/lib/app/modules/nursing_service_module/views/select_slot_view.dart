import 'package:e_missi_service_provider/export.dart';

class SelectSlotScreen extends GetView<MyBusinessCalendarController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(strAVAILABLETime,
                  style: textStyleBody1()
                      .copyWith(fontWeight: FontWeight.w700, fontSize: font_20))
              .paddingOnly(left: margin_20, bottom: margin_10),
          Expanded(
            child: _list(),
          ),
          _cancelAdd()
        ],
      ),
    );
  }

  _list() {
    return GetBuilder<MyBusinessCalendarController>(builder: (controller) {
      return ListView.separated(
              itemBuilder: (context, index) {
                return inkWell(
                  ontap: () {
                    controller.mySlotList![index].isSelected =
                        !controller.mySlotList![index].isSelected!;
                    controller.mySlotList![index].startTime.toString();
                    controller.update();
                  },
                  child: SlotListView(controller.mySlotList![index]),
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  height: margin_10,
                );
              },
              itemCount: controller.mySlotList?.length ?? 0)
          .paddingSymmetric(horizontal: margin_20);
    });
  }

  _cancelAdd() {
    return Container(
      child: MaterialButtonWidget(
        onPressed: () {
          controller.hitAddSlotApi();
        },
        borderColor: appColor,
        buttonText: strSave,
        textColor: Colors.white,
        buttonColor: appColor,
      ).paddingSymmetric(horizontal: margin_20, vertical: margin_20),
    );
  }
}

class SlotListView extends StatelessWidget {
  var stateList;

  SlotListView(this.stateList);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(radius_10)),
      child: Row(
        children: [
          Expanded(
              child: Text(
                  "${convertDateToNormalTime(dateString: "2022-12-24 ${stateList.startTime.toString()}")} - ${convertDateToNormalTime(dateString: "2022-12-24 ${stateList.endTime.toString()}")}",
                  style: textStyleBody1())),
          sizeBox(width: width_10),
          AssetImageWidget(
            imageUrl:
                stateList.isSelected == true ? ic_check_slot : ic_un_check_slot,
            imageHeight: height_18,
          )
        ],
      ).paddingSymmetric(vertical: margin_15, horizontal: margin_20),
    );
  }
}
