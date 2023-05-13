import 'package:e_missi_service_provider/export.dart';


class SelectServiceTypeScreen extends GetView<SelectServiceController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.7,
      child: Column(
        children: [
          Divider(
            color: Colors.grey.shade300,
            thickness: margin_2,
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [_list(), _cancelAdd()],
            ),
          )
        ],
      ),
    );
  }

  _list() {
    return Obx(() => ListView.separated(
        itemBuilder: (context, index) {
          return inkWell(
            ontap: () {
              controller.title[index].isSelected =
                  !controller.title[index].isSelected;
              controller.title.refresh();
            },
            child: ListDataScreen(controller.title[index]),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey.withOpacity(0.7),
          );
        },
        itemCount: controller.title.length));
  }

  _cancelAdd() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: margin_3,
            blurRadius: margin_3)
      ]),
      child: Row(
        children: [
          Expanded(
              child: MaterialButtonWidget(
            onPressed: () {
              Get.back();
            },
            borderColor: Colors.grey,
            buttonText: strCancel,
            textColor: Colors.grey,
            buttonColor: Colors.white,
          )),
          sizeBox(width: width_20),
          Expanded(
              child: MaterialButtonWidget(
            onPressed: () {
              Get.back();
            },
            borderColor: appColor,
            buttonText: strAdd,
            textColor: Colors.white,
            buttonColor: appColor,
          )),
        ],
      ).paddingSymmetric(horizontal: margin_20, vertical: margin_20),
    );
  }
}
