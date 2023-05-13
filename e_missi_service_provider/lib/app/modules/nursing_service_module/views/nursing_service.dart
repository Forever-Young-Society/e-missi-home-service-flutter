
import 'package:e_missi_service_provider/app/modules/nursing_service_module/controllers/select_state_controller.dart';
import 'package:e_missi_service_provider/export.dart';


class NursingServiceScreen extends GetView<NursingServiceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AssetImageWidget(
            imageUrl: ic_tech_bg,
            imageFitType: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                appBarView2(title: strNursingServices),
                sizeBox(height: margin_20),
                _forWhom(),
                sizeBox(height: margin_30),
                _findNurseForm(),
                sizeBox(height: margin_30),
                _typeOfServiceForm(),
                sizeBox(height: margin_30),
                _next()
              ],
            ).paddingAll(margin_20),
          ),
        ],
      ),
    );
  }

  _forWhom() {
    return getContainer(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(strIsThisForYou, style: textStyleBody1()), _personList()],
    ).paddingOnly(
        top: margin_20, left: margin_20, right: margin_20, bottom: margin_0));
  }

  _personList() {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: controller.personList.length + 1,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.6,
            crossAxisSpacing: margin_20),
        itemBuilder: (context, index) {
          return index != controller.personList.length
              ? Obx(() => inkWell(
                    ontap: () {
                      controller.updateIndex(index);
                    },
                    child: PersonViewScreen(
                      image: controller.personList[index].image,
                      name: controller.personList[index].name,
                      isSelected:
                          controller.currentIndex.value == index ? true : false,
                    ),
                  ))
              : Obx(() => inkWell(
                  ontap: () {
                    controller.updateIndex(controller.personList.length);
                    bottomSheet(
                        widget: SomeOneElseViewScreen(),
                        textLabel: strAddProfile);
                  },
                  child: PersonViewScreen(
                    image: ic_outlineduser,
                    name: strSomeoneElse,
                    isSelected: controller.currentIndex.value ==
                            controller.personList.length
                        ? true
                        : false,
                  )));
        });
  }

  _findNurseForm() {
    return getContainer(
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(strFindTheNurse, style: textStyleBody1()),
      sizeBox(height: margin_20),
      _state(),
      _area(),
      _date()
    ]).paddingAll(margin_20));
  }

  _state() {
    return TextFieldWidget(
      hint: strState,
      textController: controller.stateTextEditingController,
      alignLabelWithHint: false,
      labels: false,
      onTap: () {
        if (!Get.isRegistered()) {
          Get.put(SelectStateController());
        }
        bottomSheet(widget: SelectStateScreen(), textLabel: strSelectState);
      },
      readOnly: true,
      hintStyle: textStyleBody1()
          .copyWith(fontSize: font_14, color: Colors.grey.shade400),
      contentPadding:
          EdgeInsets.symmetric(horizontal: margin_10, vertical: margin_15),
      borders: OutlineInputBorder(
          borderRadius: BorderRadius.circular(margin_10),
          borderSide: BorderSide(color: Colors.grey)),
      suffixIcon: AssetImageWidget(
        imageUrl: ic_dropdown,
        imageHeight: height_15,
        imageWidth: height_15,
        color: Colors.purple,
      ).paddingAll(margin_12),
    ).paddingOnly(bottom: margin_20);
  }

  _area() {
    return TextFieldWidget(
      hint: strArea,
      textController: controller.areaTextEditingController,
      alignLabelWithHint: false,
      labels: false,
      onTap: () {},
      readOnly: true,
      hintStyle: textStyleBody1()
          .copyWith(fontSize: font_14, color: Colors.grey.shade400),
      contentPadding:
          EdgeInsets.symmetric(horizontal: margin_10, vertical: margin_15),
      borders: OutlineInputBorder(
          borderRadius: BorderRadius.circular(margin_10),
          borderSide: BorderSide(color: Colors.grey)),
      suffixIcon: AssetImageWidget(
        imageUrl: ic_dropdown,
        imageHeight: height_15,
        imageWidth: height_15,
        color: Colors.purple,
      ).paddingAll(margin_12),
    ).paddingOnly(bottom: margin_20);
  }

  _date() {
    return TextFieldWidget(
      hint: strDateMonthYear,
      textController: controller.dateTextEditingController,
      alignLabelWithHint: false,
      labels: false,
      readOnly: true,
      prefixIcon: AssetImageWidget(
        imageUrl: ic_prplecal,
        imageHeight: height_30,
        imageWidth: height_30,
        color: Colors.purple,
      ).paddingOnly(left: margin_10, right: margin_3),
      hintStyle: textStyleBody1()
          .copyWith(fontSize: font_14, color: Colors.grey.shade400),
      contentPadding:
          EdgeInsets.symmetric(horizontal: margin_10, vertical: margin_15),
      borders: OutlineInputBorder(
          borderRadius: BorderRadius.circular(margin_10),
          borderSide: BorderSide(color: Colors.grey)),
    ).paddingOnly(bottom: margin_20);
  }

  _typeOfServiceForm() {
    return getContainer(
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(strTypeOfServices, style: textStyleBody1()),
      sizeBox(height: margin_20),
      _service(),
    ]).paddingAll(margin_20));
  }

  _service() {
    return TextFieldWidget(
      hint: strPleaseSelect,
      alignLabelWithHint: false,
      labels: false,
      readOnly: true,
      textController: controller.serviceTextEditingController,
      onTap: () {
        if (!Get.isRegistered()) {
          Get.put(SelectServiceController());
        }
        bottomSheet(
            widget: SelectServiceTypeScreen(),
            textLabel: strSelectTypeOfService);
      },
      hintStyle: textStyleBody1()
          .copyWith(fontSize: font_14, color: Colors.grey.shade400),
      contentPadding:
          EdgeInsets.symmetric(horizontal: margin_10, vertical: margin_15),
      borders: OutlineInputBorder(
          borderRadius: BorderRadius.circular(margin_10),
          borderSide: BorderSide(color: Colors.grey)),
      suffixIcon: AssetImageWidget(
        imageUrl: ic_dropdown,
        imageHeight: height_15,
        imageWidth: height_15,
        color: Colors.purple,
      ).paddingAll(margin_12),
    );
  }

  _next() {
    return MaterialButtonWidget(
      onPressed: () {
        if (controller.currentIndex.value == 1) {
          Get.toNamed(AppRoutes.nursesService);
        }
      },
      buttonText: strNext.toUpperCase(),
    );
  }
}
