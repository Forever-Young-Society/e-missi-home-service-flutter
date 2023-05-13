/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

const crashBaseUrl = "https://app.elderlovemissi.com.my/";


const String baseUrl = "https://app.elderlovemissi.com.my/api/";
const String baseWebUrl = "https://app.elderlovemissi.com.my/";
const String imageBaseUrl = "https://app.elderlovemissi.com.my";

const String signUpEndPoint = "user/signup";
const String notificationEndPoint = "user/notification-list";
const String notificationClearEndPoint = "user/notification-clear";
const String completeSignUpEndPoint = "user/complete-signup";
const String updateProfileEndPoint = "user/update-profile-user";
const String loginEndPoint = "user/login";
const String userDetailEndPoint = "user/detail";
const String addDependentEndPoint = "user/add-dependent";
const String removeDependentEndPoint = "user/remove-dependent";
const String DependentDetailEndPoint = "user/dependent-detail";
const String EditDependentEndPoint = "user/update-dependent";
const String dependentListEndPoint = "user/dependent-list";
const String forgotPasswordEndPoint = "user/forgot-password";
const String changePasswordEndPoint = "user/change-password";
const String logoutEndPoint = "user/logout";
const String getProfileEndPoint = "user/get-profile";
const String loginVerifyOtpEndPoint = "user/verify-otp";
const String resendEndPoint = "user/resend-otp";
const String checkEndPoint = "user/check";
const String getPagesEndPoint = "user/get-page";
const String faqEndPoint = "user/faq-list";

const String locationListEndPoint = "service/location-list";
const String matchesListEndPoint = "service/matches-list";
const String servicesDetailsEndPoint = "service/provider-detail";
const String locationZipCodeEndPoint = "service/location-zipcode";
const String serviceTermEndPoint = "service/term-detail";
const String serviceAcceptTermEndPoint = "service/accept-term";
const String serviceCategoryEndPoint = "service/category-list";
const String serviceSubCategoryEndPoint = "service/sub-category-list";
const String getProviderSlotListEndPoint = "slot/get-provider-slot";
const String providerAvailabilityEndPoint = "slot/availability";
const String bookSlotEndPoint = "/slot/booking";
const String updateBookSlotEndPoint = "/slot/edit-booking";
const String bookingPaymentEndPoint = "/slot/payment";
const String bookingDetailEndPoint = "/slot/booking-detail";
const String bookingListEndPoint = "slot/user-bookings";
const String paymentHistoryEndPoint = "slot/payment-history";
const String cancelBookingEndPoint = "slot/cancel-booking";
const String reScheduleBookingEndPoint = "slot/reschedule-booking";
const String addRatingEndPoint = "rating/add-rating";
const String serviceReportListEndPoint = "service/report-list";
const String deleteAccountEndPoint = "user/delete-account";

//Log exceptions and crashes
const logCrashesExceptionsEndPoint = "logger/log/exception";

//Payment
const String webViewPaymentEndPoint = "payment/pay";


// consts
const String serviceId = 'service_id';
const String providerId = 'provider_id';
const String dateId = 'date';
const TYPE_SELF = "0";
const typeDependent = "1";

//==booking List State ID===
const statePending = 0;

const stateInProgress = 1;

const stateCancel = 2;


const stateCompleted = 3;


//==booking State ID===
const appointmentTypeUpcoming = 1;

const appointmentTypeHistory = 2;

//==reschedule State ID===

const userReschdeule = 1;