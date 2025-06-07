import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lockify/features/app_manger/app_manager_cubit.dart';
import 'package:lockify/features/login/view/login_screen.dart';
import 'package:lockify/features/register/manager/register_cubit.dart';
import 'package:lockify/features/register/manager/register_state.dart';
import 'package:lockify/generated/l10n.dart';
import 'package:lockify/utils/app_colors.dart';
import 'package:lockify/utils/app_fonts.dart';
import 'package:lockify/utils/app_toast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final cubit = RegisterCubit();

  @override
  void dispose() {
    super.dispose();
    cubit.userNameController.dispose();
    cubit.phoneController.dispose();
    cubit.emailController.dispose();
    cubit.passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            onRegisterSuccess();
          } else if (state is RegisterFailure) {
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
                    padding: EdgeInsets.all(15.r),
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
                            S().userName,
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.mainFont,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          TextFormField(
                            controller: cubit.userNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return S().usernameRequired;
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            cursorColor: AppColors.primaryColor,
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                            ),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(fontSize: 15.sp),
                              prefixIcon: const Icon(
                                Icons.person_outlined,
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
                          TextFormField(
                            controller: cubit.passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return S().passwordRequired;
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
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
                          Text(
                            S().confirmPassword,
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return S().confirmationRequired;
                                  } else if (value !=
                                      cubit.passwordController.text) {
                                    return S().thosePasswordDidntMatch;
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
                              );
                            },
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
                                    cubit.register(context);
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
                                          S().signUp,
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
                                S().alreadyHaveAnAccount,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.sp,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                    (route) => false,
                                  );
                                },
                                child: Text(
                                  S().login,
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            ],
                          )
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

  void onRegisterSuccess() {
    cubit.saveUserData(
      userName: cubit.userNameController.text,
      email: cubit.emailController.text,
    );
    Navigator.pop(context);
    displayToast(S().accountCreated);
  }
}
