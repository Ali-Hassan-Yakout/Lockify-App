import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lockify/database/shared_preferences.dart';
import 'package:lockify/features/app_manger/app_manager_cubit.dart';
import 'package:lockify/features/login/view/login_screen.dart';
import 'package:lockify/features/settings/manager/settings_cubit.dart';
import 'package:lockify/features/settings/manager/settings_state.dart';
import 'package:lockify/generated/l10n.dart';
import 'package:lockify/utils/app_colors.dart';
import 'package:lockify/utils/app_fonts.dart';
import 'package:lockify/utils/app_toast.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final cubit = SettingsCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is SignOutSuccess) {
            onSignOutSuccess();
          } else if (state is SignOutFailure) {
            displayToast(state.errorMessage);
          }
        },
        child: Scaffold(
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
              S().settings,
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w800,
                fontFamily: AppFonts.mainFont,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
              top: 15.h,
              bottom: 30.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                settingItem(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16.r),
                          topLeft: Radius.circular(16.r),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return Padding(
                          padding: EdgeInsets.all(15.r),
                          child: BlocBuilder<AppManagerCubit, AppManagerState>(
                            buildWhen: (previous, current) =>
                                current is LanguageChange,
                            builder: (context, state) {
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      PreferenceUtils.setString(
                                        PrefKeys.language,
                                        'ar',
                                      );
                                      BlocProvider.of<AppManagerCubit>(context)
                                          .onLanguageChange();
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(bottom: 15.h),
                                      padding: EdgeInsets.all(15.r),
                                      decoration: BoxDecoration(
                                        color: AppColors.backgroundLightColor,
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                            "assets/images/ar.png",
                                            width: 30.w,
                                            height: 30.h,
                                          ),
                                          Text(
                                            'العربية',
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                          PreferenceUtils.getString(
                                                    PrefKeys.language,
                                                    'en',
                                                  ) ==
                                                  'ar'
                                              ? Icon(
                                                  Icons.check_circle_rounded,
                                                  color:
                                                      AppColors.secondaryColor,
                                                  size: 30.r,
                                                )
                                              : Text(
                                                  'AR',
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      PreferenceUtils.setString(
                                        PrefKeys.language,
                                        'en',
                                      );
                                      BlocProvider.of<AppManagerCubit>(context)
                                          .onLanguageChange();
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(15.r),
                                      decoration: BoxDecoration(
                                        color: AppColors.backgroundLightColor,
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                            "assets/images/en.png",
                                            width: 30.w,
                                            height: 30.h,
                                          ),
                                          Text(
                                            'English',
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                          PreferenceUtils.getString(
                                                    PrefKeys.language,
                                                    'en',
                                                  ) ==
                                                  'en'
                                              ? Icon(
                                                  Icons.check_circle_rounded,
                                                  color:
                                                      AppColors.secondaryColor,
                                                  size: 30.r,
                                                )
                                              : Text(
                                                  'EN',
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  icon: Icons.language,
                  title: S().language,
                ),
                settingItem(
                  onTap: () {},
                  icon: Icons.color_lens_rounded,
                  title: S().theme,
                  toggle: ElevatedButton(
                    onPressed: () {
                      PreferenceUtils.setBool(
                        PrefKeys.theme,
                        !PreferenceUtils.getBool(PrefKeys.theme),
                      );
                      BlocProvider.of<AppManagerCubit>(context).onThemeChange();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: const CircleBorder(),
                      backgroundColor: Colors.white,
                      elevation: 7,
                    ),
                    child: BlocBuilder<AppManagerCubit, AppManagerState>(
                      buildWhen: (previous, current) => current is ThemeChange,
                      builder: (context, state) {
                        return Icon(
                          PreferenceUtils.getBool(PrefKeys.theme)
                              ? Icons.nightlight_outlined
                              : Icons.light_mode_outlined,
                          color: AppColors.primaryColor,
                        );
                      },
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: () {
                      cubit.signOut();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      S().signOut,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                        fontFamily: AppFonts.mainFont,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget settingItem({
    required GestureTapCallback onTap,
    required IconData icon,
    required String title,
    Widget? toggle,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          color: AppColors.toastBackgroundColor,
          border: Border.all(
            color: AppColors.toastBackgroundColor,
            width: 2.5.w,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: AppColors.primaryColor,
              size: 40.r,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontFamily: AppFonts.mainFont,
              ),
            ),
            toggle ??
                Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.primaryColor,
                  size: 30.r,
                ),
          ],
        ),
      ),
    );
  }

  void onSignOutSuccess() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false,
    );
  }
}
