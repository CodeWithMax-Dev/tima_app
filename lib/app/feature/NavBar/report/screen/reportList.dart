import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tima_app/app/core/constants/colorConst.dart';
import 'package:tima_app/app/feature/NavBar/report/widget/attendance_tab.dart';
import 'package:tima_app/app/feature/NavBar/report/widget/next_visit.dart';
import 'package:tima_app/app/feature/NavBar/report/widget/visit.dart';

class Reportlist extends StatefulWidget {
  const Reportlist({super.key});

  @override
  State<Reportlist> createState() => _ReportlistState();
}

class _ReportlistState extends State<Reportlist> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'REPORTS',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: colorConst.primarycolor,
              letterSpacing: 1.2,
            ),
          ),
          bottom: TabBar(
            labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            indicatorColor: colorConst.primarycolor,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Colors.grey,
            labelColor: colorConst.primarycolor,
            tabs: [
              Tab(
                icon: Icon(Icons.calendar_today_rounded, size: 22.sp),
                text: 'Next Visit',
              ),
              Tab(
                icon: Icon(Icons.history_rounded, size: 22.sp),
                text: 'Visit',
              ),
              Tab(
                icon: Icon(Icons.person_outline_rounded, size: 22.sp),
                text: 'Attendance',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [NextVisitTab(), VisitTab(), AttendanceTab()],
        ),
      ),
    );
  }
}
