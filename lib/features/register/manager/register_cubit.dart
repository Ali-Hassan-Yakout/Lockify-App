import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lockify/features/app_manger/app_manager_cubit.dart';
import 'package:lockify/features/register/manager/register_state.dart';
import 'package:lockify/generated/l10n.dart';
import 'package:lockify/utils/app_connectivity.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscure = true;
  bool loading = false;

  Future<void> register(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    loading = true;
    BlocProvider.of<AppManagerCubit>(context).onLoadingChange();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      loading = false;
      BlocProvider.of<AppManagerCubit>(context).onLoadingChange();
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      loading = false;
      BlocProvider.of<AppManagerCubit>(context).onLoadingChange();
      if (e.code == 'weak-password') {
        emit(RegisterFailure(S().thePasswordProvidedIsTooWeak));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(S().theAccountAlreadyExistsForThatEmail));
      }
    } catch (e) {
      loading = false;
      BlocProvider.of<AppManagerCubit>(context).onLoadingChange();
      if (await AppConnectivity.checkInternet()) {
        emit(RegisterFailure(S().registrationFailed));
      } else {
        emit(RegisterFailure(S().checkYourInternet));
      }
    }
  }

  Future<void> saveUserData({
    required String userName,
    required String email,
  }) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'userId': userId,
      'userName': userName,
      'email': email,
    });
  }
}
