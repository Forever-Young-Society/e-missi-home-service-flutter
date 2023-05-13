/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
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
const String faqEndPoint = "user/faq-list";

const String completeSignUpEndPoint = "user/complete-provider-signup";
const String updateProfileEndPoint = "user/update-profile-provider";
const String loginEndPoint = "user/login";
const String userDetailEndPoint = "user/provider-detail";
const String forgotPasswordEndPoint = "user/forgot-password";
const String changePasswordEndPoint = "user/change-password";
const String logoutEndPoint = "user/logout";
const String getProfileEndPoint = "user/get-profile";
const String loginVerifyOtpEndPoint = "user/verify-otp";
const String resendEndPoint = "user/resend-otp";
const String checkEndPoint = "user/check";
const String getPagesEndPoint = "user/get-page";
const String locationListEndPoint = "user/location-list";
const String languageEndPoint = "service/language-list";
const String serviceCategoryEndPoint = "service/category-list";
const String serviceSubCategoryEndPoint = "service/sub-category-list";
const String myCategoryEndPoint = "service/my-services";
const String slotsListEndPoint = "slot/list";
const String slotAddEndPoint = "slot/add-schedule";
const String bookingDetailEndPoint = "/slot/booking-detail";
const String bookingListEndPoint = "slot/provider-bookings";
const String startBookingEndPoint = "slot/start-booking";
const String completeBookingEndPoint = "slot/complete-booking";
const String ratingListEndPoint = "rating/list";
const String skillListEndPoint = "service/skill-list";
const String serviceReportListEndPoint = "slot/report-list";
const String startDutyListEndPoint = "slot/current-duty";
const String deleteAccountEndPoint = "user/delete-account";
const String bookingReportPostEndPoint = "slot/booking-report";


//Log exceptions and crashes
const logCrashesExceptionsEndPoint = "logger/log/exception";

// const values

const documentPending = 0;

const documentApproved = 1;

const documentRejected = 2;


const catId = "cat_id";
const startTime = "start_time";
const endTime = "end_time";


//==booking List State ID===
const statePending = 0;

const stateInProgress = 1;

const stateCancelled = 2;

const stateCompleted = 3;


//==booking State ID===
const appointmentUpcoming = 1;

const appointmentHistory = 2;

//==reschedule State ID===


const userReschedule = 1;
//==rating State ID===

const sortLatest = 1;

const sortHighest = 2;

const sortLowest = 3;

//=payment status==
const paymentPending = 0;

const paymentSuccess = 1;