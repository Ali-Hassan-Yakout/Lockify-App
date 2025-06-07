import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lockify/features/app_manger/app_manager_cubit.dart';
import 'package:lockify/features/rfid/manager/rfid_cubit.dart';
import 'package:lockify/features/rfid/manager/rfid_state.dart';
import 'package:lockify/generated/l10n.dart';
import 'package:lockify/utils/app_colors.dart';
import 'package:lockify/utils/app_fonts.dart';

class RfidScreen extends StatefulWidget {
  const RfidScreen({super.key});

  @override
  State<RfidScreen> createState() => _RfidScreenState();
}

class _RfidScreenState extends State<RfidScreen> {
  final cubit = RfidCubit();

  @override
  void initState() {
    super.initState();
    cubit.getRfids();
  }

  @override
  void dispose() {
    cubit.usernameController.dispose();
    cubit.detailsController.dispose();
    cubit.passwordController1.dispose();
    cubit.passwordController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
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
            S().rfids,
            style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.w800,
              fontFamily: AppFonts.mainFont,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<RfidCubit, RfidState>(
          buildWhen: (previous, current) =>
              current is RfidStored ||
              current is RfidObtained ||
              current is RfidDeleted,
          builder: (context, state) {
            return rfidItemBuilder();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addRfidDialog();
          },
          backgroundColor: AppColors.secondaryColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 40.r,
          ),
        ),
      ),
    );
  }

  Widget rfidItemBuilder() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: cubit.rfids.length,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(15.r),
          margin: EdgeInsets.all(15.r),
          decoration: BoxDecoration(
            color: AppColors.toastBackgroundColor,
            border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "${S().uid} : ",
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontFamily: AppFonts.mainFont,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Text(
                    cubit.rfids[index].uid,
                    maxLines: 1,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontFamily: AppFonts.mainFont,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
              Text(
                "${S().userName} : ${cubit.rfids[index].userName}",
                maxLines: 1,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black,
                  fontFamily: AppFonts.mainFont,
                  overflow: TextOverflow.fade,
                ),
              ),
              Text(
                "${S().details} : ${cubit.rfids[index].details}",
                maxLines: 1,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black,
                  fontFamily: AppFonts.mainFont,
                  overflow: TextOverflow.fade,
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    deleteRfidDialog(index);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  label: Text(
                    S().delete,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 25.r,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void addRfidDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: cubit.formKey1,
          child: AlertDialog(
            title: Text(
              S().addRfid,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontFamily: AppFonts.mainFont,
              ),
            ),
            actions: <Widget>[
              TextFormField(
                controller: cubit.usernameController,
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
                  fontFamily: AppFonts.mainFont,
                ),
                decoration: InputDecoration(
                  label: Text(
                    S().userName,
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 16.sp,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                  errorStyle: TextStyle(fontSize: 15.sp),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: AppColors.primaryColor,
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
              ),
              SizedBox(height: 20.h),
              TextFormField(
                controller: cubit.detailsController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return S().detailsRequired;
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                cursorColor: AppColors.primaryColor,
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontFamily: AppFonts.mainFont,
                ),
                decoration: InputDecoration(
                  label: Text(
                    S().details,
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 16.sp,
                      fontFamily: AppFonts.mainFont,
                    ),
                  ),
                  errorStyle: TextStyle(fontSize: 15.sp),
                  prefixIcon: const Icon(
                    Icons.description,
                    color: AppColors.primaryColor,
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
              ),
              SizedBox(height: 20.h),
              BlocBuilder<AppManagerCubit, AppManagerState>(
                buildWhen: (previous, current) => current is ObscureChange,
                builder: (context, state) {
                  return TextFormField(
                    controller: cubit.passwordController1,
                    obscureText: cubit.obscure1,
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
                      label: Text(
                        S().password,
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 16.sp,
                          fontFamily: AppFonts.mainFont,
                        ),
                      ),
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (!cubit.formKey1.currentState!.validate()) return;
                    cubit.addRfid();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    S().confirm,
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

  void deleteRfidDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: cubit.formKey2,
          child: AlertDialog(
            title: Text(
              S().deleteRfid,
              textAlign: TextAlign.center,
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
                    controller: cubit.passwordController2,
                    obscureText: cubit.obscure2,
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
                      label: Text(
                        S().password,
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 16.sp,
                          fontFamily: AppFonts.mainFont,
                        ),
                      ),
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
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (!cubit.formKey2.currentState!.validate()) return;
                    cubit.deleteRfid(index);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    S().confirm,
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
