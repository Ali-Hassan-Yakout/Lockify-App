import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lockify/features/login/view/login_screen.dart';
import 'package:lockify/features/register/view/register_screen.dart';
import 'package:lockify/utils/app_colors.dart';
import 'package:lockify/utils/app_fonts.dart';
import 'package:lottie/lottie.dart';

class AppOnBoarding extends StatelessWidget {
  const AppOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        onFinish: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterScreen(),
            ),
            (route) => false,
          );
        },
        trailingFunction: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        },
        headerBackgroundColor: AppColors.backgroundDarkColor,
        finishButtonText: 'Register',
        finishButtonTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 19.sp,
          fontWeight: FontWeight.bold,
          fontFamily: AppFonts.mainFont,
        ),
        finishButtonStyle: FinishButtonStyle(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        skipTextButton: Text(
          'Skip',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontFamily: AppFonts.mainFont,
            fontSize: 18.sp,
          ),
        ),
        trailing: Text(
          'Login',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontFamily: AppFonts.mainFont,
            fontSize: 18.sp,
          ),
        ),
        centerBackground: true,
        pageBackgroundColor: AppColors.backgroundDarkColor,
        background: const [
          SizedBox(),
          SizedBox(),
          SizedBox(),
          SizedBox(),
        ],
        totalPage: 4,
        speed: 1.5,
        pageBodies: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                Text(
                  "Welcome to Lockify",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.mainFont,
                  ),
                ),
                Expanded(
                  child: Lottie.asset(
                    'assets/animations/slide_1.json',
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  'Your secure and smart way to control access to your home.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                Text(
                  'Control Your Door Anywhere',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.mainFont,
                  ),
                ),
                Expanded(
                  child: Lottie.asset(
                    'assets/animations/slide_2.json',
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  'Lock and unlock your door remotely with a single tap.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                Text(
                  'Manage Access with Ease',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.mainFont,
                  ),
                ),
                Expanded(
                  child: Lottie.asset(
                    'assets/animations/slide_3.json',
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  'Add or remove fingerprints and RFID tags in seconds.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                Text(
                  'Stay in Control',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.mainFont,
                  ),
                ),
                Expanded(
                  child: Lottie.asset(
                    'assets/animations/slide_4.json',
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  'Change your password anytime for enhanced security.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
