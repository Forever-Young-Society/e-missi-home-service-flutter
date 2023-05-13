import 'package:e_missi_home_service/app/modules/nursing_service_module/controllers/select_state_controller.dart';
import 'package:e_missi_home_service/export.dart';

class SelectZipCodeScreen extends GetView<SelectStateController> {
  var onTap;

  @override
  SelectZipCodeScreen({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectStateController>(
      init: SelectStateController(),
      builder: (controller) {
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
      },
    );
  }

  _list() {
    return ListView.separated(
        padding: EdgeInsets.only(bottom: margin_90),
        itemBuilder: (context, index) {
          return inkWell(
            ontap: () {
              Get.find<NursingServiceController>().selectedZipCodeIndex = index;
              controller.update();
            },
            child: Row(
              children: [
                Expanded(
                    child: Text(
                        Get.find<NursingServiceController>()
                                .locationZipCodeList![index]
                                .postCode ??
                            "",
                        style: textStyleBody1())),
                sizeBox(width: width_10),
                Get.find<NursingServiceController>().selectedZipCodeIndex ==
                        index
                    ? AssetImageWidget(
                        imageUrl: ic_check,
                        imageHeight: height_15,
                      )
                    : Container()
              ],
            ).paddingSymmetric(vertical: margin_15, horizontal: margin_20),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey.withOpacity(0.7),
          );
        },
        itemCount:
            Get.find<NursingServiceController>().locationZipCodeList!.length);
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
            onPressed: onTap ?? () {},
            borderColor: appColor,
            buttonText: strSubmit,
            textColor: Colors.white,
            buttonColor: appColor,
          )),
        ],
      ).paddingSymmetric(horizontal: margin_20, vertical: margin_20),
    );
  }
}
