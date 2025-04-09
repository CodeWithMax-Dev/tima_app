


// class routerConfigue {
//   final GoRouter pageRouter =
//       GoRouter(initialLocation: routerConst.splashScreen, routes: [
//     // !home page
//     GoRoute(
//       path: routerConst.homePage,
//       name: routerConst.homePage,
//       builder: (context, state) {
//         return const Home();
//       },
//     ),

//     // !loginScreen Inquiry page
//     GoRoute(
//       path: routerConst.createInquiryPage,
//       name: routerConst.createInquiryPage,
//       builder: (context, state) {
//         return const CreateInquiry();
//       },
//     ),

//     // !forgot page
//     GoRoute(
//       path: routerConst.forgotPage,
//       name: routerConst.forgotPage,
//       builder: (context, state) {
//         return const ForgotPasswordScreen();
//       },
//     ),
    
//     // !forgot page home
//     GoRoute(
//       path: HomeForgotPass.routeName,
//       name: HomeForgotPass.routeName,
//       builder: (context, state) {
//         return const HomeForgotPass();
//       },
//     ),

//     // !NavigationBar LogIn

//     GoRoute(
//       path: routerConst.homeNavBar,
//       name: routerConst.homeNavBar,
//       builder: (context, state) {
//         return const HomeNavBar();
//       },
//     ),

//     // ! update home location
//     GoRoute(
//       path: routerConst.homeUpdateLocation,
//       name: routerConst.homeUpdateLocation,
//       builder: (context, state) {
//         return const HomeMapLocation();
//       },
//     ),

//     // ! Home Forgot Password
//     GoRoute(
//       path: routerConst.homeForgotPass,
//       name: routerConst.homeForgotPass,
//       builder: (context, state) {
//         return const HomeForgotPass();
//       },
//     ),

//     // ! Mark Attendence

//     GoRoute(
//       path: routerConst.markAttendence,
//       name: routerConst.markAttendence,
//       builder: (context, state) {
//         return const Markattendance();
//       },
//     ),

//     // ! Splash Screens
//     GoRoute(
//       path: routerConst.splashScreen,
//       name: routerConst.splashScreen,
//       builder: (context, state) {
//         return const SplashScreen();
//       },
//     ),

//     // !clientRegister Screens
//      GoRoute(
//       path: routerConst.register,
//       name: routerConst.register,
//       builder: (context, state) {
//          LatLng latLng = state.extra as LatLng;
//         return  RegisterScreen(latLng: latLng,);
//       },
//     ),

//     // ! Error 401  Screens
//     GoRoute(
//       path: routerConst.error401,
//       name: routerConst.error401,
//       builder: (context, state) {
//         return const Error401Page();
//       },
//     ),

//     // ! login screen

//     GoRoute(
//       path: routerConst.loginScreen,
//       name: routerConst.loginScreen,
//       builder: (context, state) {
//         return const PhoneEmailLogin();
//       },
//     ),

//     // ! visit details page

//     GoRoute(
//       path: routerConst.visitDetailScreen,
//       name: routerConst.visitDetailScreen,
//       builder: (context, state) {
//         VisitDetailScreenParams visitDetailScreenParams =
//             state.extra as VisitDetailScreenParams;
//         return VisitDeatil(
//           visitDetailScreenParams: visitDetailScreenParams,
//         );
//       },
//     ),

//     // ! visit details page

//     GoRoute(
//       path: routerConst.inquiryDetailScreen,
//       name: routerConst.inquiryDetailScreen,
//       builder: (context, state) {
//         InquiryDetailParams inquiryDetailParams =
//             state.extra as InquiryDetailParams;
//         return InquiryDeatil(
//           inquiryDetailParams: inquiryDetailParams,
//         );
//       },
//     ),

//     // ! request admin page

//     GoRoute(
//       path: routerConst.requestAdmin,
//       name: routerConst.requestAdmin,
//       builder: (context, state) {
//         return const RequestAdmin();
//       },
//     ),

//     // ! create inquiry page

//     GoRoute(
//       path: routerConst.recivedInquiry,
//       name: routerConst.recivedInquiry,
//       builder: (context, state) {

//         return const ReciveInquiry();
//       },
//     ),

//     // ! generate inquiry page

//     // GoRoute(
//     //   path: routerConst.generateInquiry,
//     //   name: routerConst.generateInquiry,
//     //   builder: (context, state) {
//     //     return Generateinquiry();
//     //   },
//     // ),

//     GoRoute(
//       path: routerConst.genEnqpage,
//       name: routerConst.genEnqpage,
//       builder: (context, state) {
//         return const Generateinquiry();
//       },
//     ),
//   ]);
// }
