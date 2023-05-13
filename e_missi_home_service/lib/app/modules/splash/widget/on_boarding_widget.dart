import '../../../../export.dart';

class OnBoardingWidget extends StatelessWidget {
  final String? imageUrl;
  final String? headingText;
  final String? bodyText;

  const OnBoardingWidget({
    Key? key,
    required this.imageUrl,
    required this.headingText,
    required this.bodyText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: GetBuilder<OnboardingController>(
          builder: (controller) => _bodyWidget(),
          init: OnboardingController(),
        ));
  }

  /*=====================================================_bodyWidget==============================================*/

  _bodyWidget() => Get.find<OnboardingController>().selectedPageIndex == 0
      ? SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AssetImageWidget(
                        imageUrl: ICON_topBg,
                        imageHeight: height_150,
                        imageFitType: BoxFit.fill,
                        imageWidth: Get.width),
                    Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: lightBlue,
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.only(right: margin_20, left: margin_40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Text(
                                'Fulfils your online health\nleisure '
                                'lifestyle needs\nthrough our innovative platform.',
                                style: TextStyle(
                                    color: darkPurple,
                                    fontWeight: FontWeight.w500,
                                    fontSize: font_16),
                              ).paddingOnly(top: margin_20, bottom: margin_20),
                            ),
                            AssetImageWidget(
                                imageUrl: ICON_flower, imageHeight: height_130)
                          ],
                        ),
                      ),
                    ).marginOnly(top: margin_20, bottom: margin_20),
                    _heading(headingText: strTelemonitoring),
                    _heading(headingText: strHomeCareSolution),
                    _heading(headingText: strOnlineHealthShop),
                    _heading(headingText: strEPharmacy),
                    _heading(headingText: strTelemedicine),
                  ],
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: AssetImageWidget(
                            imageUrl: ICON_splashlogo, imageHeight: height_80)
                        .marginOnly(top: margin_20))
              ],
            ),
          ),
        )
      : SafeArea(
          child: Stack(
            children: [
              Get.find<OnboardingController>().selectedPageIndex == 1
                  ? Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: lightPurple,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: lightPurple,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
              Get.find<OnboardingController>().selectedPageIndex == 1
                  ? SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Your homecare',
                            style: TextStyle(
                                color: purple,
                                fontSize: font_25,
                                fontWeight: FontWeight.bold),
                          ).paddingOnly(top: margin_40),
                          Text(
                            'services are',
                            style: TextStyle(
                                color: purple,
                                fontSize: font_25,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'INSURED',
                            style: TextStyle(
                                color: lightPurple,
                                fontSize: font_25,
                                fontWeight: FontWeight.bold),
                          ).paddingOnly(bottom: margin_20),
                          AssetImageWidget(
                                  imageUrl: ICON_insured,
                                  imageHeight: height_190)
                              .paddingOnly(bottom: margin_20),
                          Text(
                            'We make the difference,\nensuring that your health services are secured and safe. So you can order our comprehensive health services with the peace of mind',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: font_18,
                                fontWeight: FontWeight.w500),
                          ).paddingOnly(bottom: margin_20),
                        ],
                      ).paddingSymmetric(horizontal: margin_50),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  'Our \nTele-\nmonitoring',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: font_25,
                                      fontWeight: FontWeight.bold),
                                ).paddingOnly(top: margin_50, left: margin_20),
                              ),
                              AssetImageWidget(
                                imageUrl: ICON_monitoring,
                                imageWidth: width_150,
                              ).paddingOnly(top: margin_90),
                            ],
                          ).paddingOnly(bottom: margin_70),
                          Text(
                            'With our Telemonitoring, you\nare not only able to monitor\n'
                            'your own health but also\nmonitor remotely the health\n'
                            'of your loved ones and\ngetting prompt solutions for\nthem',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: purple,
                                fontSize: font_18,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: margin_20),
                    )
            ],
          ),
        );

  /*==================================================_heading=============================================*/

  Widget _heading({headingText}) => Text(
        headingText ?? '',
        style: TextStyle(
            color: purple, fontSize: font_18, fontWeight: FontWeight.bold),
      ).paddingSymmetric(horizontal: margin_10, vertical: margin_10);
}
