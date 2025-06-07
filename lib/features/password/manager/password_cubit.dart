import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lockify/features/password/manager/password_state.dart';
import 'package:lockify/generated/l10n.dart';
import 'package:lockify/utils/app_bluetooth.dart';
import 'package:lockify/utils/app_toast.dart';

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit() : super(PasswordInitial());

  final bluetooth = AppBluetooth(); // Access singleton
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscure1 = true;
  bool obscure2 = true;

  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Set the listener before sending the command
    bluetooth.onDataReceived = (data) {
      if (data == "CHANGED") {
        displayToast(S().passwordChanged);
        emit(PasswordChanged());
      }
    };

    try {
      // Send the change password command
      await bluetooth.sendCommand(
        "1:${currentPasswordController.text}:${newPasswordController.text}",
      );
    } catch (e) {
      displayToast(S().passwordChangeFailed);
    }
  }

}
