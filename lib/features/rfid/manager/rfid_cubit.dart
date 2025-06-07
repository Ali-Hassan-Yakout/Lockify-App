import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lockify/features/rfid/manager/rfid_state.dart';
import 'package:lockify/generated/l10n.dart';
import 'package:lockify/models/rfid.dart';
import 'package:lockify/utils/app_bluetooth.dart';
import 'package:lockify/utils/app_connectivity.dart';
import 'package:lockify/utils/app_toast.dart';

class RfidCubit extends Cubit<RfidState> {
  RfidCubit() : super(RfidInitial());

  final bluetooth = AppBluetooth();
  List<Rfid> rfids = [];
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
  bool invalid = false;
  final fireStore = FirebaseFirestore.instance;
  final fireAuth = FirebaseAuth.instance;

  Future<void> addRfid() async {
    saved = false;
    invalid = false;
    bluetooth.onDataReceived = (data) {
      if (data.startsWith("UID:")) {
        if (!saved) {
          saved = true;
          saveRfid(data.substring(4));
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
        "3:${passwordController1.text}",
      );
    } catch (e) {
      displayToast(S().commandFailed);
    }
  }

  Future<void> saveRfid(String uid) async {
    try {
      String userId = fireAuth.currentUser!.uid;
      await fireStore
          .collection('users')
          .doc(userId)
          .collection('rfids')
          .doc(uid)
          .set({
        'uid': uid,
        'userName': usernameController.text,
        'details': detailsController.text,
      });
      rfids.add(
        Rfid(
          uid: uid,
          userName: usernameController.text,
          details: detailsController.text,
        ),
      );
      usernameController.text = "";
      detailsController.text = "";
      passwordController1.text = "";
      displayToast(S().rfidStored);
      emit(RfidStored());
    } catch (e) {
      displayToast(S().rfidStorageFailed);
    }
  }

  Future<void> deleteRfid(int index) async {
    deleted = false;
    invalid = false;
    bluetooth.onDataReceived = (data) async {
      if (data == "1") {
        if(!deleted){
          deleted = true;
          String userId = fireAuth.currentUser!.uid;
          await fireStore
              .collection('users')
              .doc(userId)
              .collection('rfids')
              .doc(rfids[index].uid)
              .delete();
          rfids.removeAt(index);
          emit(RfidDeleted());
          displayToast(S().rfidDeleted);
        }
      } else if(data == "Invalid"){
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
        "4${rfids[index].uid}${passwordController2.text}",
      );
    } catch (e) {
      displayToast(S().rfidDeleteFailed);
    }
  }

  Future<void> getRfids() async {
    try {
      String userId = fireAuth.currentUser!.uid;
      await fireStore
          .collection('users')
          .doc(userId)
          .collection('rfids')
          .get()
          .then((value) {
        rfids.clear();
        for (var doc in value.docs) {
          rfids.add(Rfid.fromMap(doc.data()));
        }
      });
      emit(RfidObtained());
    } catch (e) {
      displayToast(S().obtainingRfidsFailed);
    }
  }
}
