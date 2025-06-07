import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lockify/features/app_manger/app_manager_cubit.dart';
import 'package:lockify/features/password/manager/password_cubit.dart';
import 'package:lockify/generated/l10n.dart';
import 'package:lockify/utils/app_colors.dart';
import 'package:lockify/utils/app_fonts.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = PasswordCubit();
    return BlocProvider(
      create: (context) => cubit,
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
            S().changePassword,
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
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S().currentPassword,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.mainFont,
                  ),
                ),
                SizedBox(height: 20.h),
                BlocBuilder<AppManagerCubit, AppManagerState>(
                  buildWhen: (previous, current) => current is ObscureChange,
                  builder: (context, state) {
                    return TextFormField(
                      maxLength: 8,
                      controller: cubit.currentPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return S().currentPasswordRequired;
                        } else if (value.length < 4) {
                          return S().tooShort;
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: cubit.obscure1,
                      obscuringCharacter: "*",
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
                            cubit.obscure1 = !cubit.obscure1;
                            BlocProvider.of<AppManagerCubit>(context)
                                .onObscureChange();
                          },
                          icon: Icon(
                            cubit.obscure1
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
                Text(
                  S().newPassword,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.mainFont,
                  ),
                ),
                SizedBox(height: 20.h),
                BlocBuilder<AppManagerCubit, AppManagerState>(
                  buildWhen: (previous, current) => current is ObscureChange,
                  builder: (context, state) {
                    return TextFormField(
                      maxLength: 8,
                      controller: cubit.newPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return S().newPasswordRequired;
                        } else if (value.length < 4) {
                          return S().tooShort;
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: cubit.obscure2,
                      obscuringCharacter: "*",
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
                            cubit.obscure2 = !cubit.obscure2;
                            BlocProvider.of<AppManagerCubit>(context)
                                .onObscureChange();
                          },
                          icon: Icon(
                            cubit.obscure2
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
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: () {
                      cubit.changePassword();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      S().confirm,
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
}
