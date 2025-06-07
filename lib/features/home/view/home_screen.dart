import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lockify/database/shared_preferences.dart';
import 'package:lockify/features/app_manger/app_manager_cubit.dart';
import 'package:lockify/features/home/manager/home_cubit.dart';
import 'package:lockify/features/home/manager/home_state.dart';
import 'package:lockify/features/manage_access/view/manage_access_screen.dart';
import 'package:lockify/features/settings/view/settings_screen.dart';
import 'package:lockify/generated/l10n.dart';
import 'package:lockify/utils/app_colors.dart';
import 'package:lockify/utils/app_fonts.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final cubit = HomeCubit();

  @override
  void initState() {
    super.initState();
    cubit.userName = PreferenceUtils.getString(PrefKeys.userName);
    cubit.lockController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    cubit.lockController.reverse();
    cubit.connectToBluetooth();

    FlutterBluePlus.adapterState.listen((state) {
      if (state == BluetoothAdapterState.off ||
          state == BluetoothAdapterState.unavailable) {
        setState(() {
          cubit.isConnected = false;
          cubit.connectedDevice = null;
        });
      }
    });
  }

  @override
  void dispose() {
    cubit.lockController.dispose();
    cubit.passwordController.dispose();
    cubit.connectionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<AppManagerCubit, AppManagerState>(
                buildWhen: (previous, current) => current is LanguageChange,
                builder: (context, state) {
                  return Text(
                    S().welcome,
                    style: TextStyle(
                      fontSize: 25.sp,
                      color: AppColors.primaryColor,
                      fontFamily: AppFonts.mainFont,
                    ),
                  );
                },
              ),
              Text(
                cubit.userName,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppColors.secondaryColor,
                  fontFamily: AppFonts.mainFont,
                ),
              ),
            ],
          ),
          actions: [
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) => current is ConnectionChange,
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    if (!cubit.isConnected) {
                      cubit.connectToBluetooth();
                    }
                  },
                  icon: cubit.isConnected
                      ? Icon(
                          Icons.bluetooth_connected,
                          color: Colors.blueAccent,
                          size: 30.r,
                        )
                      : Icon(
                          Icons.bluetooth_disabled,
                          size: 30.r,
                        ),
                );
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Lottie.asset(
                controller: cubit.lockController,
                "assets/animations/unlock.json",
                repeat: false,
                width: 200.w,
                height: 200.h,
              ),
              BlocBuilder<AppManagerCubit, AppManagerState>(
                buildWhen: (previous, current) => current is LanguageChange,
                builder: (context, state) {
                  return BlocBuilder<HomeCubit, HomeState>(
                    buildWhen: (previous, current) =>
                        current is LockStatusChanged,
                    builder: (context, state) {
                      return Text(
                        cubit.unLocked ? S().unlocked : S().locked,
                        style: TextStyle(
                          fontSize: 25.sp,
                          color: AppColors.primaryColor,
                          fontFamily: AppFonts.mainFont,
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 100.h),
              InkWell(
                onTap: () {
                  if (!cubit.unLocked) {
                    unlockDialog();
                  }
                },
                child: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: 70.r,
                  child: Icon(
                    Icons.lock_open_rounded,
                    color: Colors.white,
                    size: 70.r,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ManageAccessScreen(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.secondaryColor,
                      radius: 50.r,
                      child: Icon(
                        Icons.key_sharp,
                        color: Colors.white,
                        size: 50.r,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.secondaryColor,
                      radius: 50.r,
                      child: Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 50.r,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void unlockDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: cubit.formKey,
          child: AlertDialog(
            title: Text(
              S().enterPassword,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontFamily: AppFonts.mainFont,
              ),
            ),
            actions: <Widget>[
              BlocBuilder<AppManagerCubit, AppManagerState>(
                buildWhen: (previous, current) => current is ObscureChange,
                builder: (context, state) {
                  return TextFormField(
                    controller: cubit.passwordController,
                    obscureText: cubit.obscure,
                    obscuringCharacter: "*",
                    maxLength: 8,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S().passwordRequired;
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: AppColors.primaryColor,
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: AppFonts.mainFont,
                    ),
                    decoration: InputDecoration(
                      errorStyle: TextStyle(fontSize: 15.sp),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: AppColors.primaryColor,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          cubit.obscure = !cubit.obscure;
                          BlocProvider.of<AppManagerCubit>(context)
                              .onObscureChange();
                        },
                        icon: Icon(
                          cubit.obscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (!cubit.formKey.currentState!.validate()) {
                      return;
                    }
                    cubit.unlockDoor();
                    Navigator.pop(context);
                    cubit.passwordController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    S().unlock,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
