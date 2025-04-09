import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tima_app/app/feature/NavBar/Admin/screen/requestAdmin.dart';
import 'package:tima_app/app/feature/NavBar/attendence/screen/markAttendenc.dart';
import 'package:tima_app/app/feature/NavBar/report/screen/reportList.dart';
import 'package:tima_app/app/feature/home/screen/home.dart';

class HomeNavBar extends StatefulWidget {
  const HomeNavBar({super.key});

  @override
  HomeNavBarState createState() => HomeNavBarState();
}

class HomeNavBarState extends State<HomeNavBar> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: pageList[currentIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(displayWidth * .05),
        height: displayWidth * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
          itemBuilder:
              (context, index) => InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = index;
                    HapticFeedback.lightImpact();
                  });
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width:
                          index == currentIndex
                              ? displayWidth * .32
                              : displayWidth * .18,
                      alignment: Alignment.center,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        height: index == currentIndex ? displayWidth * .12 : 0,
                        width: index == currentIndex ? displayWidth * .32 : 0,
                        decoration: BoxDecoration(
                          color:
                              index == currentIndex
                                  ? Colors.blueAccent.withOpacity(.2)
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width:
                          index == currentIndex
                              ? displayWidth * .31
                              : displayWidth * .18,
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width:
                                    index == currentIndex
                                        ? displayWidth * .13
                                        : 0,
                              ),
                              AnimatedOpacity(
                                opacity: index == currentIndex ? 1 : 0,
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: Text(
                                  index == currentIndex
                                      ? pageTitles[index]
                                      : '',
                                  style: const TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width:
                                    index == currentIndex
                                        ? displayWidth * .03
                                        : 20,
                              ),
                              Icon(
                                listOfIcons[index],
                                size: displayWidth * .076,
                                color:
                                    index == currentIndex
                                        ? Colors.blueAccent
                                        : Colors.black26,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.edit_square,
    Icons.location_city,
    Icons.security,
  ];

  List<Widget> pageList = [
    const Home(),
    const Markattendance(),
    const RequestAdmin(),
    const Reportlist(),
  ];

  List<String> pageTitles = const ['Home', 'Att', 'Visit', 'Report'];
}
