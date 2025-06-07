import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lockify/features/app_manger/app_manager_cubit.dart';
import 'package:lockify/features/reset_password/manager/reset_password_state.dart';
import 'package:lockify/generated/l10n.dart';
import 'package:lockify/utils/app_connectivity.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool loading = false;

  Future<void> resetPassword(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    loading = true;
    BlocProvider.of<AppManagerCubit>(context).onLoadingChange();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text,
      );
      loading = false;
      BlocProvider.of<AppManagerCubit>(context).onLoadingChange();
      emit(ResetPasswordSuccess());
    } catch (error) {
      loading = false;
      BlocProvider.of<AppManagerCubit>(context).onLoadingChange();
      if (await AppConnectivity.checkInternet()) {
        emit(ResetPasswordFailure(S().resetPasswordFailed));
      } else {
        emit(ResetPasswordFailure(S().checkYourInternet));
      }
    }
  }
}
