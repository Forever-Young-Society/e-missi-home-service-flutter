import 'package:e_missi_service_provider/export.dart';

class ListDataScreen extends StatelessWidget {
  var stateList;

  ListDataScreen(this.stateList);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(stateList.title?.toString() ?? "", style: textStyleBody1())),
        sizeBox(width: width_10),
        stateList.isSelected == true
            ? AssetImageWidget(
                imageUrl: ic_check,
                imageHeight: height_15,
              )
            : Container()
      ],
    ).paddingSymmetric(vertical: margin_15, horizontal: margin_20);
  }
}
