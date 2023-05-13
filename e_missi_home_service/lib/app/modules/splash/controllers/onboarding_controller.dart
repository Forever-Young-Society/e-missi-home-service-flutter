/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import '../../../../export.dart';
import '../../../core/values/local_keys.dart';
import '../widget/on_boarding_widget.dart';

class OnboardingController extends GetxController {
  onSkip() {
    localStorage.write(LOCALKEY_onboarding, true);
    Get.offAllNamed(AppRoutes.logIn);
  }

  onSlide(index) {
    selectedPageIndex = index;
  }

  int selectedPageIndex = 0;

  List<OnBoardingWidget> listOfScreens = [];
  PageController controller = PageController();

  @override
  void onInit() {
    addData();
    super.onInit();
  }

  /*==============================================================addData============================================*/

  addData() {
    listOfScreens.clear();
    listOfScreens.add(OnBoardingWidget(
      imageUrl: ICON_slider1,
      headingText: 'strOnboardingHeading1',
      bodyText: 'strOnboardingSubHeading',
    ));
    listOfScreens.add(OnBoardingWidget(
      imageUrl: ICON_slider1,
      headingText: 'strOnboardingHeading2',
      bodyText: 'strOnboardingSubHeading',
    ));
    listOfScreens.add(OnBoardingWidget(
      imageUrl: ICON_slider1,
      headingText: 'strOnboardingHeading3',
      bodyText: 'strOnboardingSubHeading',
    ));
  }

  /*========================================================movePageAction==============================================*/

  movePageAction() {
    if (selectedPageIndex < listOfScreens.length - 1) {
      selectedPageIndex++;
      controller.animateToPage(selectedPageIndex,
          curve: Curves.decelerate,
          duration: const Duration(
              milliseconds: 300)); // for animated jump. Requires a cu
    } else {
      moveToMainScreenRoute();
    }
  }

  moveToMainScreenRoute() {
    Get.find<PreferenceManger>().firstLaunch(true);
    Get.offAllNamed(AppRoutes.logIn);
  }

  /*============================================================onSwipePage============================================*/

  onSwipePage(index) {
    selectedPageIndex = index;
    update();
  }

  @override
  void refresh() {
    addData();
    super.refresh();
  }
}
