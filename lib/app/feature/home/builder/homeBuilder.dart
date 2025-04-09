import 'dart:convert';
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tima_app/app/DataBase/dataHub/secureStorageService.dart';
import 'package:tima_app/app/DataBase/keys/keys.dart';
import 'package:tima_app/app/core/constants/apiUrlConst.dart';
import 'package:tima_app/app/core/constants/colorConst.dart';
import 'package:tima_app/app/core/models/lat_lng_model.dart';
import 'package:tima_app/app/feature/Auth/forgotPassword/screen/home_forgot_pass.dart';
import 'package:tima_app/app/feature/Auth/loginPages/screen/loginPage.dart';
import 'package:tima_app/app/feature/Auth/register/screen/register.dart';
import 'package:tima_app/app/feature/LogOut/logout.dart';
import 'package:tima_app/app/feature/drawerPage/homeLocation/homelocation.dart';
import 'package:tima_app/app/feature/drawerPage/inquiry/createInquiry/screen/createInqueryPage.dart';
import 'package:tima_app/app/feature/drawerPage/inquiry/generateInquiry/screen/generateInquiry.dart';
import 'package:tima_app/app/feature/drawerPage/inquiry/reciveInquiry/screen/reciveInquiry.dart';
import 'package:tima_app/app/feature/home/model/slider_model.dart';
import 'package:tima_app/app/feature/home/screen/home.dart';
import 'package:tima_app/app/providers/LocationProvider/location_provider.dart';

abstract class HomeBuilder extends State<Home> {
  final SecureStorageService secureStorageService = SecureStorageService();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final storageHub = const FlutterSecureStorage();
  // SliderModel sliderModel = SliderModel();  checking
  bool isHomeSkeletonON = true;
  List<SliderData> homeSliderImage = [];
  String? timaLogo;

  disabledSkeleton() {
    Future.delayed(const Duration(seconds: 1)).then(
      (disabled) => setState(() {
        isHomeSkeletonON = false;
      }),
    );
  }

  String? userEmail;
  String? userName;
  String? mobileNo;
  String? timaHomeLogo;
  List<ScreenHiddenDrawer> pages = [];
  int currentSlider = 0;

  usreInit() async {
    userName = await storageHub.read(key: StorageKeys.NameKey);
    userEmail = await storageHub.read(key: StorageKeys.emailKey);
    timaHomeLogo = await storageHub.read(key: StorageKeys.timaLogoKey);
    mobileNo = await storageHub.read(key: StorageKeys.mobileKey);
    setState(() {});
  }

  bool isLoading = true;

  // loadData() {
  //   Future.delayed(
  //     const Duration(seconds: 2),
  //   );
  // }

  int current = 0; // Current index of the carousel
  // final CarouselController controller = CarouselController();
  CarouselSliderController sliderController = CarouselSliderController();
  String title = '';

  String titlemessage = "Tima";
  bool isImageLoading = true;
  List<String> imgList = [];
  // var logoMessage;
  List imageSliders = ['assets/banner.jpg', 'assets/banner1.jpg'];

  // * load banner images from api

  Future<void> callHomeBannerFromApi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userId = await secureStorageService.getUserID(
      key: StorageKeys.userIDKey,
    );
    String? companyId = await secureStorageService.getUserCompanyID(
      key: StorageKeys.companyIdKey,
    );
    // String username =
    //     await secureStorageService.getUserName(key: StorageKeys.NameKey) ??
    //         'Guest';
    // String? useremail =
    //     await secureStorageService.getUserEmailID(key: StorageKeys.emailKey) ??
    //         'not EmailID Found';

    isImageLoading = true;
    final client = http.Client();
    try {
      final response = await client
          .post(
            Uri.parse(get_slider_url),
            body: {'company_id': companyId, 'user_id': userId},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        Map<String, dynamic> bannerDataDecoded = jsonDecode(response.body);
        var loginStatus = bannerDataDecoded['user_login_status'];
        if (loginStatus == 0) {
          setState(() {
            pref
                .setBool(StorageKeys.loginKey, false)
                .then(
                  (route) => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => PhoneEmailLogin()),
                  ),
                );
          });
        } else {
          HomeSliderModel homeSliderModel = HomeSliderModel.fromJson(
            bannerDataDecoded,
          );
          // slidingImage.add(bannerDataDecoded['image_url']);
          homeSliderImage = homeSliderModel.data;

          timaLogo = homeSliderModel.logo;
          timaHomeLogo = homeSliderModel.logoMessage;
        }
      }

      log("userLogin_title : ${title.toString()}");

      log("imageSliders:--> $imageSliders ");

      isImageLoading = false;
    } catch (error) {
      log(error.toString());
    }
  }

  Widget get HiddenDrawerView => HiddenDrawerMenu(
    backgroundColorMenu: Colors.deepPurpleAccent,
    screens: pages,
  );

  Widget get TimaAppDrawer => Drawer(
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.blue.shade50.withOpacity(0.3)],
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 260.h,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 200.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [colorConst.primarycolor, Colors.blue.shade400],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(30.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 40.h,
                  right: -30.w,
                  child: Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ),
                Positioned(
                  top: -20.h,
                  left: -20.w,
                  child: Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ),
                Positioned(
                  top: 25.h,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/timaApplogo.jpg',
                            height: 90.h,
                            width: 90.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 20.w,
                  right: 20.w,
                  child: Container(
                    padding: EdgeInsets.all(15.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName.toString(),
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Icon(
                              Icons.email_outlined,
                              size: 16.sp,
                              color: colorConst.primarycolor,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                userEmail.toString(),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black54,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(
                              Icons.phone_outlined,
                              size: 16.sp,
                              color: colorConst.primarycolor,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              mobileNo.toString(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          _buildDrawerItem(
            icon: Icons.password,
            title: "Change Password",
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => HomeForgotPass()));
            },
          ),
          Consumer<LocationProvider>(
            builder: (_, ref, __) {
              return _buildDrawerItem(
                icon: Icons.person,
                title: "Registration",
                onTap: () async {
                  ref.updateLocation();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (_) => RegisterScreen(
                            latLng: LatLng(
                              lat: ref.lat.value.toString(),
                              lng: ref.lng.value.toString(),
                              address: ref.address.value,
                            ),
                          ),
                    ),
                  );
                },
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.location_on,
            title: "Home Location",
            onTap:
                () => Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => HomeMapLocation())),
          ),
          _buildDrawerItem(
            icon: Icons.calendar_today_rounded,
            title: "Create Enquiry",
            onTap:
                () => Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => CreateInquiry())),
          ),
          _buildDrawerItem(
            icon: Icons.calendar_today_rounded,
            title: "Received Enquiry",
            onTap:
                () => Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => ReciveInquiry())),
          ),
          _buildDrawerItem(
            icon: Icons.calendar_today_rounded,
            title: "Generated Enquiry",
            onTap:
                () => Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => Generateinquiry())),
          ),
          _buildDrawerItem(
            icon: Icons.logout,
            title: "Logout",
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const CustomDialog();
                },
              );
            },
          ),
          SizedBox(height: 20.h),
          SizedBox(height: 100.h),
        ],
      ),
    ),
  );

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: colorConst.primarycolor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    icon,
                    color: colorConst.primarycolor,
                    size: 22.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey.shade400,
                  size: 16.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ImageSlider() {
    return Stack(
      children: [
        CarouselSlider(
          items:
              homeSliderImage
                  .map(
                    (images) => Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          images.imageUrl.toString(),
                          fit: BoxFit.cover,
                          width: 1000,
                        ),
                      ),
                    ),
                  )
                  .toList(),
          carouselController: sliderController,
          options: CarouselOptions(
            height: 280.0,
            enlargeCenterPage: true,
            autoPlay: true,
            // aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.8,
            onPageChanged: (index, reason) {
              setState(() {
                current = index;
              });
            },
          ),
        ),
        Positioned.fill(
          top: 150,
          left: 155,
          child: Row(
            children: List.generate(
              homeSliderImage.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: AnimatedContainer(
                  duration: const Duration(microseconds: 300),
                  // padding: const EdgeInsets.symmetric(horizontal: 3),
                  width: current == index ? 16 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: current == index ? blueColor : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // * show logout dailoge feature box
}
