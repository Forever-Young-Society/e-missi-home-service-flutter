/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

// components

export 'dart:async';

/*============================================ third parties libraries ====================================*/
export 'package:device_info_plus/device_info_plus.dart';
export 'package:flutter/foundation.dart';
/* =============================================dart, flutter and getx =====================================*/

export 'package:flutter/gestures.dart';

// flutter package
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:flutter_easyloading/flutter_easyloading.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:get/get.dart'
    hide Response, HeaderValue, MultipartFile, FormData;
export 'package:get/instance_manager.dart';
export 'package:get_storage/get_storage.dart';
export 'package:logger/logger.dart';
export 'package:syncfusion_flutter_datepicker/datepicker.dart';
export 'package:e_missi_service_provider/app/modules/home/controllers/home_module_controllers/faq_controller.dart';
export 'package:e_missi_service_provider/app/modules/home/views/models/data_models/faq_data_model.dart';
export 'package:e_missi_service_provider/app/modules/home/views/models/response_models/faq_reponse_model.dart';
export 'package:e_missi_service_provider/app/core/base/base_controller.dart';
export 'package:e_missi_service_provider/app/modules/authentication/controllers/registration_controller.dart';
export 'package:e_missi_service_provider/app/modules/authentication/views/registration_screen.dart';
export 'package:e_missi_service_provider/app/modules/authentication/controllers/otp_controller.dart';
export 'package:e_missi_service_provider/app/modules/authentication/controllers/forgot_pass_controller.dart';
export 'package:e_missi_service_provider/app/modules/authentication/controllers/reset_password_controller.dart';
export 'package:e_missi_service_provider/app/modules/authentication/controllers/create_account_controller.dart';
export 'package:e_missi_service_provider/app/modules/authentication/controllers/static_page_controller.dart';
export 'package:e_missi_service_provider/app/modules/authentication/controllers/logout_controller.dart';
export 'package:e_missi_service_provider/app/modules/appointment_module/controllers/appointment_calendar_controller.dart';
export 'package:e_missi_service_provider/app/modules/appointment_module/controllers/home_services_controller.dart';
export 'package:e_missi_service_provider/app/modules/home/controllers/profile_module_controller/edit_dependent_controller.dart';
export 'package:e_missi_service_provider/app/modules/authentication/controllers/submission_controller.dart';
export 'package:e_missi_service_provider/app/modules/authentication/models/response_models/otp_response_model.dart';
export 'package:e_missi_service_provider/app/modules/authentication/models/data_model/notification_data.dart';
export 'package:e_missi_service_provider/app/modules/authentication/models/response_models/notifications_response.dart';
export 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
export 'package:pinput/pinput.dart';
export 'package:e_missi_service_provider/app/modules/nursing_service_module/controllers/ageview_controller.dart';
export 'package:e_missi_service_provider/app/modules/nursing_service_module/controllers/nursing_service_controller.dart';
export 'package:e_missi_service_provider/app/modules/nursing_service_module/controllers/select_service_controller.dart';
export 'package:e_missi_service_provider/app/modules/nursing_service_module/controllers/someone_else_controller.dart';
export 'package:e_missi_service_provider/app/modules/nursing_service_module/widget/common_data.dart';
export 'package:e_missi_service_provider/app/modules/nursing_service_module/views/select_service.dart';
export 'package:e_missi_service_provider/app/modules/nursing_service_module/views/select_state.dart';
export 'package:e_missi_service_provider/app/modules/nursing_service_module/views/someone_else_view.dart';
export 'package:e_missi_service_provider/app/modules/nursing_service_module/widget/person_view.dart';
export 'package:e_missi_service_provider/app/modules/nursing_service_module/widget/list_screen.dart';
export 'package:e_missi_service_provider/app/core/notification_manger/push_notification_manager.dart';
export 'package:e_missi_service_provider/app/modules/authentication/views/approval_screen.dart';
export 'package:e_missi_service_provider/app/modules/authentication/views/sig_up_unsuccessfully_screen.dart';
export 'package:e_missi_service_provider/app/modules/authentication/views/submission_page.dart';
export 'package:e_missi_service_provider/app/modules/home/views/home_module/faq_screen.dart';
export 'package:e_missi_service_provider/app/modules/home/views/setting_module/booking_history_detail_screen.dart';
export 'package:e_missi_service_provider/app/modules/home/views/setting_module/my_booking_history.dart';
export 'package:e_missi_service_provider/app/modules/home/views/setting_module/my_business_calendar.dart';
export 'package:e_missi_service_provider/app/modules/home/views/setting_module/service_report_add.dart';
export 'package:e_missi_service_provider/app/modules/home/views/setting_module/service_report_list_screen.dart';
export 'package:e_missi_service_provider/app/modules/nursing_service_module/views/nurse_detail_screen.dart';
export 'package:e_missi_service_provider/app/modules/nursing_service_module/views/nurses_list_view.dart';
/*=============================================== base exports =============================================*/

export 'package:e_missi_service_provider/app/core/base/base_view.dart';
export 'package:e_missi_service_provider/app/core/base/page_state.dart';
export 'package:e_missi_service_provider/app/core/utils/helper_widget.dart';
export 'package:e_missi_service_provider/app/core/utils/validator.dart';
export 'package:e_missi_service_provider/app/core/values/app_assets.dart';
export 'package:e_missi_service_provider/app/core/values/app_assets.dart';
export 'package:e_missi_service_provider/app/core/values/app_colors.dart';
export 'package:e_missi_service_provider/app/core/values/app_global_values.dart';
export 'package:e_missi_service_provider/app/core/values/app_strings.dart';
export 'package:e_missi_service_provider/app/core/values/app_theme.dart';
export 'package:e_missi_service_provider/app/core/values/route_arguments.dart';
export 'package:e_missi_service_provider/app/modules/authentication/controllers/approval_controller.dart';
export 'package:e_missi_service_provider/app/modules/authentication/models/data_model/category_data_model.dart';
export 'package:e_missi_service_provider/app/modules/authentication/models/data_model/my_slot_data_model.dart';
export 'package:e_missi_service_provider/app/modules/authentication/models/response_models/category_response_model.dart';
export 'package:e_missi_service_provider/app/modules/authentication/models/response_models/my_slots_response_model.dart';
export 'package:e_missi_service_provider/app/core/arguments/route_arguments.dart';
export 'package:e_missi_service_provider/app/core/widget/custom_future_builder.dart';
export 'package:e_missi_service_provider/app/modules/appointment_module/common_widgets/common_data.dart';
export 'package:e_missi_service_provider/app/modules/home/views/models/data_models/service_report_data_model.dart';
export 'package:e_missi_service_provider/app/modules/home/controllers/setting_module_controllers/service_report_list_controller.dart';
export 'package:e_missi_service_provider/app/modules/home/views/models/response_models/service_report_list_response.dart';
export 'package:e_missi_service_provider/app/modules/home/views/models/data_models/add_rating_data_model.dart';
export 'package:flutter_rating_bar/flutter_rating_bar.dart';
export 'package:e_missi_service_provider/app/modules/authentication/widget/common_widgets.dart';
export 'package:e_missi_service_provider/app/modules/home/controllers/setting_module_controllers/my_business_calendar_controller.dart';
export 'package:e_missi_service_provider/app/modules/home/controllers/setting_module_controllers/my_booking_history_controller.dart';
export 'package:e_missi_service_provider/app/modules/home/controllers/setting_module_controllers/my_appointments_controller.dart';
export 'package:e_missi_service_provider/app/modules/home/widget/my_appointment_card_view.dart';
export 'package:e_missi_service_provider/app/modules/home/controllers/setting_module_controllers/booking_history_detail_controller.dart';
export 'package:e_missi_service_provider/app/modules/home/widget/common_card_view_detail.dart';
export 'package:e_missi_service_provider/app/modules/home/controllers/setting_module_controllers/appointment_detail_controller.dart';
export 'package:e_missi_service_provider/app/modules/home/controllers/profile_module_controller/edit_profile_controller.dart';
export 'package:e_missi_service_provider/app/core/widget/alert_dialog_widget.dart';
export 'package:e_missi_service_provider/app/core/widget/date_picker_custom.dart';
export 'package:e_missi_service_provider/app/modules/authentication/widget/input_formatter.dart';
export 'package:e_missi_service_provider/app/modules/home/widget/animation_expand_widget.dart';
export 'package:e_missi_service_provider/app/modules/home/widget/pdf_viewer.dart';
export 'package:file_picker/file_picker.dart';
export 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
export 'package:e_missi_service_provider/app/modules/authentication/models/data_model/skills_data_model.dart';
export 'package:carousel_slider/carousel_controller.dart';
export 'package:e_missi_service_provider/app/modules/home/views/setting_module/my_appointments_screen.dart';
export 'package:e_missi_service_provider/app/modules/authentication/models/data_model/language_data_model.dart';
export 'package:e_missi_service_provider/app/modules/authentication/models/data_model/location_list_data_model.dart';
export 'package:e_missi_service_provider/app/modules/authentication/models/response_models/language_response.dart';
export 'package:e_missi_service_provider/app/modules/authentication/models/response_models/location_list_response_model.dart';
export 'package:e_missi_service_provider/app/modules/authentication/models/response_models/skills_response_model.dart';
export 'package:e_missi_service_provider/app/modules/home/views/models/data_models/booking_detail_data_mode.dart';
export 'package:e_missi_service_provider/app/modules/home/views/models/response_models/booking_list_response_model.dart';
export 'package:e_missi_service_provider/app/modules/home/views/models/response_models/booking_detail_response_mode.dart';
export 'package:e_missi_service_provider/app/modules/home/views/models/response_models/complete_booking_response.dart';
export 'package:e_missi_service_provider/app/modules/authentication/models/response_models/sucess_response.dart';
export 'package:e_missi_service_provider/app/modules/nursing_service_module/views/select_slot_view.dart';
export 'package:e_missi_service_provider/app/modules/nursing_service_module/widget/custom_bottom_sheet.dart';
/* ================================================app constants ===========================================*/

export 'package:e_missi_service_provider/app/core/values/app_values.dart';
export 'package:e_missi_service_provider/app/core/values/text_styles.dart';
export 'package:e_missi_service_provider/app/core/widget/annotated_region_widget.dart';
export 'package:e_missi_service_provider/app/core/widget/asset_image.dart';
export 'package:e_missi_service_provider/app/core/widget/button_widget.dart';
export 'package:e_missi_service_provider/app/core/widget/button_widget.dart';
/*=================================================== widgets =============================================*/
export 'package:e_missi_service_provider/app/modules/nursing_service_module/controllers/nurses_list_controller.dart';
export 'package:e_missi_service_provider/app/modules/nursing_service_module/controllers/nurse_details_controller.dart';
export 'package:e_missi_service_provider/app/core/widget/custom_app_bar.dart';
export 'package:e_missi_service_provider/app/core/widget/edit_text_widget.dart';
export 'package:e_missi_service_provider/app/core/widget/edit_text_widget.dart';
export 'package:e_missi_service_provider/app/core/widget/loading.dart';
export 'package:e_missi_service_provider/app/core/widget/ripple.dart';
export 'package:e_missi_service_provider/app/core/widget/text_view.dart';
export 'package:e_missi_service_provider/app/modules/home/controllers/setting_module_controllers/rating_controller.dart';
export 'package:e_missi_service_provider/app/modules/appointment_module/binding/binding.dart';
export 'package:e_missi_service_provider/app/modules/appointment_module/views/appointment_calendar_view.dart';
export 'package:e_missi_service_provider/app/modules/appointment_module/views/home_services.dart';
export 'package:e_missi_service_provider/app/modules/authentication/views/create_account_screen.dart';
export 'package:e_missi_service_provider/app/modules/authentication/views/forgot_pass_screen.dart';
export 'package:e_missi_service_provider/app/modules/authentication/views/logout_screen.dart';
export 'package:e_missi_service_provider/app/modules/authentication/views/otp_screen.dart';
export 'package:e_missi_service_provider/app/modules/authentication/views/reset_password_screen.dart';
export 'package:e_missi_service_provider/app/modules/authentication/views/static_page.dart';
export 'package:e_missi_service_provider/app/modules/home/views/profile_module/edit_dependent_screen.dart';
export 'package:e_missi_service_provider/app/modules/home/views/profile_module/edit_profile_screen.dart';
export 'package:e_missi_service_provider/app/modules/home/views/profile_module/profile_screen.dart';
export 'package:e_missi_service_provider/app/modules/home/views/setting_module/appointment_detail_screen.dart';
export 'package:e_missi_service_provider/app/modules/home/views/setting_module/rating_screen.dart';
export 'package:e_missi_service_provider/app/modules/nursing_service_module/binding/binding.dart';
export 'package:e_missi_service_provider/app/modules/nursing_service_module/views/nursing_service.dart';
export 'package:e_missi_service_provider/app/modules/splash/views/onboarding_screen.dart';
export 'package:e_missi_service_provider/app/modules/home/controllers/setting_module_controllers/service_report_controller.dart';

/*==================================================== local services =====================================*/
export 'package:e_missi_service_provider/app/data/local/prefrences/preference.dart';
/*================================================== dio client ======================================*/
export 'package:e_missi_service_provider/app/modules/authentication/controllers/sign_up_unsuccessfully_controller.dart';

export 'package:e_missi_service_provider/app/data/repository/api_repository.dart';
/*================================================ dio client ============================================*/
export 'package:e_missi_service_provider/app/data/repository/api_repository.dart';
export 'package:e_missi_service_provider/app/data/repository/dio_client.dart';
export 'package:e_missi_service_provider/app/data/repository/endpoint.dart';
export 'package:e_missi_service_provider/app/data/repository/network_exceptions.dart';
export 'package:e_missi_service_provider/app/logger/logger_utils.dart';
/*================================================== application binding =====================================*/

export 'package:e_missi_service_provider/app/modules/app_content/binding/binding.dart';
export 'package:e_missi_service_provider/app/modules/app_content/controllers/app_content_controller.dart';
export 'package:e_missi_service_provider/app/modules/app_content/controllers/notification_controller.dart';
export 'package:e_missi_service_provider/app/modules/app_content/views/notification_screen.dart';
export 'package:e_missi_service_provider/app/modules/app_content/views/static_page_screen.dart';
export 'package:e_missi_service_provider/app/modules/app_content/widget/notification_item.dart';
export 'package:e_missi_service_provider/app/modules/authentication/binding/binding.dart';
export 'package:e_missi_service_provider/app/modules/authentication/controllers/login_controller.dart';
/* =============================================== request model =====================================*/
export 'package:e_missi_service_provider/app/modules/authentication/models/auth_request_model.dart';
export 'package:e_missi_service_provider/app/modules/authentication/views/login_screen.dart';
export 'package:e_missi_service_provider/app/modules/home/binding/binding.dart';
export 'package:e_missi_service_provider/app/modules/home/controllers/home_module_controllers/home_controller.dart';
export 'package:e_missi_service_provider/app/modules/home/controllers/main_screen_controller/main_controller.dart';
export 'package:e_missi_service_provider/app/modules/home/controllers/main_screen_controller/main_controller.dart';
export 'package:e_missi_service_provider/app/modules/home/views/home_module/home_screen.dart';
export 'package:e_missi_service_provider/app/modules/home/views/main_screen/main_screen.dart';
export 'package:e_missi_service_provider/app/modules/splash/binding/binding.dart';
export 'package:e_missi_service_provider/app/core/widget/network_image.dart';
export 'package:e_missi_service_provider/app/modules/app_content/controllers/app_content_controller.dart';
export 'package:e_missi_service_provider/app/modules/app_content/controllers/notification_controller.dart';
export 'package:e_missi_service_provider/app/modules/home/controllers/payout_screen_controller/payout_screen_controller.dart';
export 'package:e_missi_service_provider/app/modules/home/views/payout_module/payout_screen.dart';
export 'package:e_missi_service_provider/app/modules/home/widget/common_card_view.dart';
export 'package:e_missi_service_provider/app/modules/home/widget/payout_list_view.dart';
export 'package:get/get.dart';
export 'package:e_missi_service_provider/app/modules/authentication/controllers/login_controller.dart';
export 'package:e_missi_service_provider/app/modules/authentication/models/remember_me.dart';
export 'package:e_missi_service_provider/app/modules/authentication/models/response_models/login_response_model.dart';
export 'package:e_missi_service_provider/app/modules/authentication/models/data_model/login_data_model.dart';
export 'package:e_missi_service_provider/app/modules/authentication/widget/authentication_module_card_view.dart';
export 'package:e_missi_service_provider/app/core/values/route_arguments.dart';
export 'package:e_missi_service_provider/app/modules/home/controllers/profile_module_controller/profile_controller.dart';
export 'package:e_missi_service_provider/app/modules/home/views/profile_module/profile_screen.dart';
export 'package:e_missi_service_provider/app/modules/home/views/setting_module/appointment_screen.dart';
export 'package:e_missi_service_provider/app/core/widget/image_picker_dialog.dart';
export 'package:e_missi_service_provider/app/modules/home/controllers/setting_module_controllers/appointment_controller.dart';

/*========================================== application controller ============================================*/
export 'package:e_missi_service_provider/app/modules/splash/controllers/splash_controller.dart';
export 'package:e_missi_service_provider/app/modules/splash/views/splash_screen.dart';
/* ==================================================app routes ===========================================*/

export 'package:e_missi_service_provider/app/routes/app_pages.dart';
export 'package:e_missi_service_provider/app/routes/app_routes.dart';
export 'package:e_missi_service_provider/main.dart';

/*============================================== application screens =====================================*/
export 'package:e_missi_service_provider/my_app.dart';
export 'package:e_missi_service_provider/app/bindings/initial_binding.dart';
