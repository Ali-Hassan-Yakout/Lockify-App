import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lockify/features/fingerprint/manager/fingerprint_state.dart';
import 'package:lockify/generated/l10n.dart';
import 'package:lockify/models/fingerprint.dart';
import 'package:lockify/utils/app_bluetooth.dart';
import 'package:lockify/utils/app_connectivity.dart';
import 'package:lockify/utils/app_toast.dart';

class FingerprintCubit extends Cubit<FingerprintState> {
  FingerprintCubit() : super(FingerprintInitial());

  final bluetooth = AppBluetooth();
  List<Fingerprint> fingerprints = [];
  final usernameController = TextEditingController();
  final detailsController = TextEditingController();
  final passwordController1 = TextEditingController();
  final passwordController2 = TextEditingController();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  bool obscure1 = true;
  bool obscure2 = true;
  bool saved = false;
  bool deleted = false;
  bool invalid = false ;
  final fireStore = FirebaseFirestore.instance;
  final fireAuth = FirebaseAuth.instance;

  Future<void> addFingerprint() async {
    saved = false;
    invalid = false;
    bluetooth.onDataReceived = (data) {
      int id = int.tryParse(data) ?? -1;
      if (id >= 0 && id <= 127) {
        if (!saved) {
          saved = true;
          saveFingerprint(id);
        }
      } else if (data == "Invalid") {
        if (!invalid){
          invalid = true;
          displayToast(S().invalidPassword);
        }
      }
    };

    try {
      await bluetooth.sendCommand(
        "2:${passwordController1.text}",
      );
    } catch (e) {
      displayToast(S().commandFailed);
    }
  }

  Future<void> saveFingerprint(int id) async {
    try {
      String userId = fireAuth.currentUser!.uid;
      await fireStore
          .collection('users')
          .doc(userId)
          .collection('fingerprints')
          .doc("$id")
          .set({
        'id': id,
        'userName': usernameController.text,
        'details': detailsController.text,
      });
      fingerprints.add(
        Fingerprint(
          id: id,
          userName: usernameController.text,
          details: detailsController.text,
        ),
      );
      usernameController.text = "";
      detailsController.text = "";
      passwordController1.text = "";
      displayToast(S().fingerprintStored);
      emit(FingerprintStored());
    } catch (e) {
      displayToast(S().fingerprintStorageFailed);
    }
  }

  Future<void> deleteFingerprint(int index) async {
    deleted = false;
    invalid = false;
    bluetooth.onDataReceived = (data) async {
      if (data == "0") {
        if (!deleted) {
          deleted = true;
          String userId = fireAuth.currentUser!.uid;
          await fireStore
              .collection('users')
              .doc(userId)
              .collection('fingerprints')
              .doc('${fingerprints[index].id}')
              .delete();
          fingerprints.removeAt(index);
          passwordController2.text = "";
          emit(FingerprintDeleted());
          displayToast(S().fingerprintDeleted);
        }
      } else if (data == "Invalid") {
        if(!invalid){
          invalid = true;
          displayToast(S().invalidPassword);
        }
      }
    };
    try {
      if (!await AppConnectivity.checkBluetooth()) {
        displayToast(S().notConnectedToSmartLock);
        return;
      }
      await bluetooth.sendCommand(
        "5:${fingerprints[index].id}:${passwordController2.text}",
      );
    } catch (e) {
      displayToast(S().fingerprintDeleteFailed);
    }
  }

  Future<void> getFingerprints() async {
    try {
      String userId = fireAuth.currentUser!.uid;
      await fireStore
          .collection('users')
          .doc(userId)
          .collection('fingerprints')
          .get()
          .then((value) {
        fingerprints.clear();
        for (var doc in value.docs) {
          fingerprints.add(Fingerprint.fromMap(doc.data()));
        }
      });
      emit(FingerprintObtained());
    } catch (e) {
      displayToast(S().obtainingFingerprintsFailed);
    }
  }
}
