import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lockify/database/shared_preferences.dart';
import 'package:lockify/features/app_manger/app_manager_cubit.dart';
import 'package:lockify/features/home/view/home_screen.dart';
import 'package:lockify/features/login/manager/login_cubit.dart';
import 'package:lockify/features/login/manager/login_state.dart';
import 'package:lockify/features/register/view/register_screen.dart';
import 'package:lockify/features/reset_password/view/reset_screen.dart';
import 'package:lockify/generated/l10n.dart';
import 'package:lockify/utils/app_colors.dart';
import 'package:lockify/utils/app_fonts.dart';
import 'package:lockify/utils/app_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final cubit = LoginCubit();

  @override
  void dispose() {
    super.dispose();
    cubit.emailController.dispose();
    cubit.passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            onLoginSuccess();
          } else if (state is LoginFailure) {
            displayToast(state.errorMessage);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundDarkColor,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/lockify_logo.png',
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.h,
                      horizontal: 15.w,
                    ),
                    margin: EdgeInsets.only(
                      bottom: 25.h,
                      left: 30.w,
                      right: 30.w,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Form(
                      key: cubit.formKey,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Text(
                            S().email,
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.mainFont,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          TextFormField(
                            controller: cubit.emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return S().emailRequired;
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: AppColors.primaryColor,
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                            ),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(fontSize: 15.sp),
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: AppColors.primaryColor,
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.primaryColor),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.primaryColor),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Text(
                            S().password,
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.mainFont,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          BlocBuilder<AppManagerCubit, AppManagerState>(
                            buildWhen: (previous, current) =>
                                current is ObscureChange,
                            builder: (context, state) {
                              return TextFormField(
                                controller: cubit.passwordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return S().passwordRequired;
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: cubit.obscure,
                                cursorColor: AppColors.primaryColor,
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                ),
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(fontSize: 15.sp),
                                  prefixIcon: const Icon(
                                    Icons.lock_outline,
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
                                    borderSide: BorderSide(
                                        color: AppColors.primaryColor),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.primaryColor),
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ResetPasswordScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                S().forgetPassword,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 50.h,
                            child:
                                BlocBuilder<AppManagerCubit, AppManagerState>(
                              buildWhen: (previous, current) =>
                                  current is LoadingChange,
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: () {
                                    if (!cubit.loading) {
                                      cubit.login(context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                  ),
                                  child: cubit.loading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          S().signIn,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: AppFonts.mainFont,
                                          ),
                                        ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                S().dontHaveAnAccount,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.sp,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  S().register,
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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

  Future<void> onLoginSuccess() async {
    await PreferenceUtils.setBool(PrefKeys.isLoggedIn, true);
    await PreferenceUtils.setBool(PrefKeys.onBoarding, true);
    await PreferenceUtils.setString(PrefKeys.userName, cubit.userName);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
      (route) => false,
    );
  }
}
