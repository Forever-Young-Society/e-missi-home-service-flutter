/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class AppPages {
  static const INITIAL = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
      bindings: [SplashBinding()],
    ),
    GetPage(
      name: AppRoutes.logIn,
      page: () => LoginScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.registrationRoute,
      page: () => RegistrationScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.otpRoute,
      page: () => OTPScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.forgotRoute,
      page: () => ForgotPasswordScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.resetPassRoute,
      page: () => ResetPasswordScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.createAccountRoute,
      page: () => CreateAccountScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.staticPageRoute,
      page: () => StaticPageScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.logoutRoute,
      page: () => LogoutScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.subMissionRoute,
      page: () => SubMissionScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.approvalRoute,
      page: () => ApprovalScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.signUpUnSuccessfullyRoute,
      page: () => SignUpUnSuccessfullyScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.appointmentViewRoute,
      page: () => AppointmentCalendarScreen(),
      bindings: [AppointmentBinding()],
    ),
    GetPage(
      name: AppRoutes.homeServiceScreenRoute,
      page: () => HomeServiceScreen(),
      bindings: [AppointmentBinding()],
    ),
    GetPage(
      name: AppRoutes.mainScreen,
      page: () => MainBottomScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.myappointmentScreen,
      page: () => MyAppointmentsScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.payoutScreen,
      page: () => PayOutScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.notification,
      page: () => NotificationScreen(),
      bindings: [AppContentBinding()],
    ),
    GetPage(
      name: AppRoutes.profileScreen,
      page: () => ProfileScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.nursingService,
      page: () => NursingServiceScreen(),
      bindings: [NursingBinding()],
    ),
    GetPage(
      name: AppRoutes.nursesService,
      page: () => NursesListScreen(),
      bindings: [NursingBinding()],
    ),
    GetPage(
      name: AppRoutes.nurseDetailRoute,
      page: () => NurseDetailScreen(),
      bindings: [NursingBinding()],
    ),
    GetPage(
        name: AppRoutes.onBoarding,
        page: () => OnboardingScreen(),
        binding: SplashBinding()),
    GetPage(
      name: AppRoutes.deliveryHistory,
      page: () => ProfileScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.editDependent,
      page: () => EditDependentScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => EditProfileScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.appointmentDetailScreen,
      page: () => AppointmentDetailScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.ratingScreen,
      page: () => RatingScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.faqRoute,
      page: () => FAQScreen(),
      bindings: [AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.profileScreen,
      page: () => ProfileScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.bookingHistoryDetailScreen,
      page: () => BookingHistoryDetailScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.myBookingHistoryScreen,
      page: () => MyBookingHistoryScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.serviceReportListScreen,
      page: () => ServiceReportListScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.serviceReportAddScreen,
      page: () => ServiceReportAddScreen(),
      bindings: [HomeBinding()],
    ),
    GetPage(
      name: AppRoutes.myBusinessCalendarScreen,
      page: () => MyBusinessCalendarScreen(),
      bindings: [HomeBinding()],
    ),
  ];
}
