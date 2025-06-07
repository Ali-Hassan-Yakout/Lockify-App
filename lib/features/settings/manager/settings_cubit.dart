import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lockify/database/shared_preferences.dart';
import 'package:lockify/features/settings/manager/settings_state.dart';


class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  final fireAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  Future<void> signOut() async {
    try {
      fireAuth.signOut();
      await PreferenceUtils.setBool(PrefKeys.isLoggedIn, false);
      await PreferenceUtils.setString(PrefKeys.userName, "");
      emit(SignOutSuccess());
    } catch (e) {
      emit(SignOutFailure(e.toString()));
    }
  }
}
