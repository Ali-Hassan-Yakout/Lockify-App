import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lockify/features/app_manger/app_manager_cubit.dart';
import 'package:lockify/features/login/manager/login_state.dart';
import 'package:lockify/generated/l10n.dart';
import 'package:lockify/utils/app_connectivity.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fireStore = FirebaseFirestore.instance;
  final fireAuth = FirebaseAuth.instance;
  String userName = "";
  bool obscure = true;
  bool loading = false;

  Future<void> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    loading = true;
    BlocProvider.of<AppManagerCubit>(context).onLoadingChange();
    try {
      await fireAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      loading = false;
      BlocProvider.of<AppManagerCubit>(context).onLoadingChange();
      String userId = fireAuth.currentUser!.uid;
      await fireStore.collection("users").doc(userId).get().then((value) {
        userName = value['userName'];
      });
      emit(LoginSuccess());
    } catch (error) {
      loading = false;
      BlocProvider.of<AppManagerCubit>(context).onLoadingChange();
      if (await AppConnectivity.checkInternet()) {
        emit(LoginFailure(S().invalidCredentials));
      } else {
        emit(LoginFailure(S().checkYourInternet));
      }
    }
  }
}
