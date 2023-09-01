import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MewkesButtonBar extends StatefulWidget {
  const MewkesButtonBar({Key? key}) : super(key: key);

  @override
  State<MewkesButtonBar> createState() => _MewkesButtonBar();
}

class _MewkesButtonBar extends State<MewkesButtonBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      height: 78.h,
      decoration: const BoxDecoration(
          color: Color(0xfff7f7f7),

      ),
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(right: 12.w),
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 8.h),
                child: Icon(CupertinoIcons.settings_solid),
              ),
              const Text("接单设置"),
            ],
          ),
          ),
          Expanded(child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: const Color(0xffcefc52),
              onPrimary: Colors.black,
              shadowColor: const Color(0xffcefc52),
              elevation: 2.0,
              maximumSize: Size(120.w, 52.h)
            ),
            child: Container(
              height: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Text("刷新列表", style: TextStyle(fontSize: 17.sp,
                fontWeight: FontWeight.w600,
              ),),
            ),
          ),
          )
        ],
      ),
    );
  }
}
