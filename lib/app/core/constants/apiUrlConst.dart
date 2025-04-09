// ignore_for_file: non_constant_identifier_names

var baseurl = "https://timaindia.com/";
//Login Url
var login_end = "login/user_login";
var login_url = baseurl + login_end;

//Change Password//
var cp_end = "login/change_password";
var cp_url = baseurl + cp_end;

//Client Registration//
var client_reg_end = "client/save";
var client_reg_url = baseurl + client_reg_end;

//Client profile//
var client_profile_end = "client/get";
var client_profile_url = baseurl + client_profile_end;

//Vender Registration//
var vender_reg_end = "vendor/save";
var vender_reg_url = baseurl + vender_reg_end;

//Get BANNER//
var get_slider = "home/get_slider_logo";
var get_slider_url = baseurl + get_slider;

//Vender profile//
var vender_profile_end = "vendor/get";
var vender_profile_url = baseurl + vender_profile_end;

//State //
var state_end = "state/get";
var state_url = baseurl + state_end;

//City //
var city_end = "city/get";
var city_url = baseurl + city_end;

var product_end = "product_service/get_product_service";
var product_service_url = baseurl + product_end;

//Get Eenquiry Details//
var get_enquiry_details = "enquiry/get_enquiry_details";
var Get_Enquiry_details_url = baseurl + get_enquiry_details;

//Get show enquiry report app//
var show_enquiry_report_app = "report/show_enquiry_report_app";
var show_enquiry_report_app_url = baseurl + show_enquiry_report_app;

//Reject enquiry //
var reject_enquiry_app = "enquiry/reject_enquiry";
var reject_enquiry_app_url = baseurl + reject_enquiry_app;

//Get show Nextvist report app//
var show_next_visit_app = "report/show_next_visit_app";
var show_next_visit_app_url = baseurl + show_next_visit_app;

//Get Visit Details//
var get_visit_data = "visit/get_visit_data";
var get_visit_data_url = baseurl + get_visit_data;

//Get Attendance Details//
var show_attendance_app = "report/show_attendance_app";
var show_attendance_app_url = baseurl + show_attendance_app;

//Save Eenquiry //
var save_enquiry = "enquiry/save_enquiry";
var save_enquiry_url = baseurl + save_enquiry;

//Get Enquiry Type//
var getenquirytype = "enquiry/get_enquiry_type";
var getenquirytype_url = baseurl + getenquirytype;

//Get Branches//
var getbranchestype = "branch_office/get_branches";
var getbranchestype_url = baseurl + getbranchestype;

//Get Users//
var getusers = "users/get_users";
var getusers_url = baseurl + getusers;

//Update Home Location Users//
var updatehome_location = "users/update_home_location";
var updatehome_location_url = baseurl + updatehome_location;

//Update Current Location Users//
var updatecurrent_location = "users/update_current_location";
var updatecurrent_location_url = baseurl + updatecurrent_location;

//Mark CheckIn Users//
var mark_attendance_in = "users/mark_attendance_in";
var mark_attendance_in_url = baseurl + mark_attendance_in;

//Mark CheckOut Users///
var mark_attendance_out = "users/mark_attendance_out";
var mark_attendance_out_url = baseurl + mark_attendance_out;

//Get Client Data //
var get_client_data = "client/get_client_data";
var get_client_data_url = baseurl + get_client_data;

//Get Attendance Places //
var get_attendance_places = "users/attendance_places";
var get_attendance_places_url = baseurl + get_attendance_places;

//Get Vendor Data //
var get_vendor_data = "vendor/get_vendor_data";
var get_vendor_data_url = baseurl + get_vendor_data;

//Visit Save Data //
var get_visitsave = "visit/save";
var get_visitsave_url = baseurl + get_visitsave;

const String getNotificationApiEndPointURl =
    'https://timaindia.com/home/get_notifications';

//Set User App Status Data //
var set_user_app_status = "users/set_user_app_status";
var set_user_app_status_url = baseurl + set_user_app_status;

const String getVisitStatusApiUrlEndPoint =
    'https://timaindia.com/visit/get_visit_status';
// user_id
// company_id

const String startVisitApiUrlEndPoint =
    'https://timaindia.com/visit/start_visit';
// user_id
// company_id
// visit_at (client/vendor)
// client_id
// vendor_id
// location
// inq_id (default 0)

const String endVisitApiUrlEndPoint = 'https://timaindia.com/visit/end_visit';
// visit_id
// user_id
// visit_at (client/vendor)
// client_id
// vendor_id
// start_at (datetime)
// person_name
// person_desi
// person_mobile
// product_service (array)
// query_complaint
// order_done (yes/no)
// next_visit (datetime)
// remark
// location

// Parameter//
var Mobile = "mobile";
var Email = "email";
var Password = "password";
var RePassword = "re_password";
var UserId = "user_id";
var Oraganization_name = "org_name";
var U_address = "address";
var User_city = "city";
var User_state = "state";
var User_pin = "pin";
var User_number = "contact_no";
var User_name = "contact_person";
var Web = "web";
var User_location = "location";
var User_product = "product/service [array]";
var DeviceId = 'device_id';
