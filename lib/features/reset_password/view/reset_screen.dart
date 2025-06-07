import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lockify/features/app_manger/app_manager_cubit.dart';
import 'package:lockify/features/reset_password/manager/reset_password_cubit.dart';
import 'package:lockify/features/reset_password/manager/reset_password_state.dart';
import 'package:lockify/generated/l10n.dart';
import 'package:lockify/utils/app_colors.dart';
import 'package:lockify/utils/app_fonts.dart';
import 'package:lockify/utils/app_toast.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final cubit = ResetPasswordCubit();

  @override
  void dispose() {
    super.dispose();
    cubit.emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            onResetPasswordSuccess();
          } else if (state is ResetPasswordFailure) {
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
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
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
                                    cubit.resetPassword(context);
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
                                          S().resetPassword,
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

  void onResetPasswordSuccess() {
    Navigator.pop(context);
    displayToast('Reset password email sent to your account');
  }
}
