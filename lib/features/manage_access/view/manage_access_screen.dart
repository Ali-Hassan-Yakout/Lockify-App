import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lockify/features/fingerprint/view/fingerprint_screen.dart';
import 'package:lockify/features/password/view/password_screen.dart';
import 'package:lockify/features/rfid/view/rfid_screen.dart';
import 'package:lockify/generated/l10n.dart';
import 'package:lockify/utils/app_colors.dart';
import 'package:lockify/utils/app_fonts.dart';

class ManageAccessScreen extends StatelessWidget {
  const ManageAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 25.r,
            color: AppColors.primaryColor,
          ),
        ),
        title: Text(
          S().manageAccess,
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.w800,
            fontFamily: AppFonts.mainFont,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: accessItem(
                    S().fingerprint,
                    "assets/images/fingerprint.png",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FingerprintScreen(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: accessItem(
                    S().rfid,
                    "assets/images/rfid.png",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RfidScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: accessItem(
                    S().password,
                    "assets/images/password.png",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PasswordScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget accessItem(
    String title,
    String icon,
    GestureTapCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 160.w,
        height: 200.h,
        padding: EdgeInsets.all(15.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.toastBackgroundColor,
          border: Border.all(color: AppColors.primaryColor, width: 2.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 90.w,
              height: 90.h,
            ),
            SizedBox(height: 10.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontFamily: AppFonts.mainFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
