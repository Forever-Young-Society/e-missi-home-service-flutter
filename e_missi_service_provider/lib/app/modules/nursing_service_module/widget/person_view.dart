import '../../../../export.dart';

class PersonViewScreen extends StatelessWidget {
  String? image;
  String? name;
  bool? isSelected;

  PersonViewScreen({this.name, this.image, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: isSelected! ? purpleColor : Colors.white,
                borderRadius: BorderRadius.circular(margin_15),
                border: Border.all(
                    color: isSelected! ? Colors.white : Colors.grey.shade500)),
            child: PhysicalModel(
              shadowColor: isSelected! ? purpleColor : Colors.white,
              borderRadius: BorderRadius.circular(margin_15),
              color: isSelected! ? purpleColor : Colors.white,
              elevation: isSelected! ? margin_5 : margin_0,
              child: AssetImageWidget(
                imageUrl: image!,
                imageHeight: height_25,
                imageWidth: height_25,
                color: isSelected! ? whiteColor : Colors.grey,
              ).paddingAll(margin_15),
            ),
          ),
          sizeBox(height: margin_15),
          Text(name!,
              textAlign: TextAlign.center,
              style: textStyleBody1().copyWith(
                  color: isSelected! ? Colors.black : Colors.grey.shade600,
                  fontSize: font_13))
        ],
      ),
    );
  }
}
