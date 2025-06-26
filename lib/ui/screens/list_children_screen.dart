import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parent_wish/ui/themes/color.dart';

class ListChildrenScreen extends StatefulWidget {
  const ListChildrenScreen({super.key});

  @override
  State<ListChildrenScreen> createState() => _ListChildrenScreenState();
}

class _ListChildrenScreenState extends State<ListChildrenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Children'),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/man.png',
                        width: 36.w,
                        height: 36.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 9.w),
                        child: Text(
                          'Sara, Female, 4 - 4Y',
                          style: TextStyle(
                            color: AppColors.gray900,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/icons/trash.png',
                    width: 23.w,
                    height: 23.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
