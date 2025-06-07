import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:lockify/features/home/manager/home_state.dart';
import 'package:lockify/generated/l10n.dart';
import 'package:lockify/utils/app_bluetooth.dart';
import 'package:lockify/utils/app_toast.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  late final AnimationController lockController;
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  BluetoothDevice? connectedDevice;
  final AppBluetooth bluetooth = AppBluetooth();
  StreamSubscription<BluetoothConnectionState>? connectionSubscription;

  String userName = "";
  bool isConnected = false;
  bool unLocked = false;
  bool obscure = true;
  bool handled = false;

  Future<void> connectToBluetooth() async {
    bool isBluetoothOn = await FlutterBluePlus.adapterState
        .map((state) => state == BluetoothAdapterState.on)
        .first;

    if (!isBluetoothOn) {
      displayToast(S().pleaseTurnOnBluetooth);
      return;
    }

    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    FlutterBluePlus.scanResults.listen((results) async {
      for (ScanResult result in results) {
        if (result.device.platformName == "HMSoft") {
          await result.device.connect();
          connectedDevice = result.device;
          isConnected = true;
          bluetooth.setDevice(result.device);
          emit(ConnectionChange());
          monitorConnection(result.device);
          return;
        }
      }
    });
  }

  void monitorConnection(BluetoothDevice device) {
    connectionSubscription =
        device.connectionState.listen((BluetoothConnectionState state) async {
      isConnected = state == BluetoothConnectionState.connected;
      emit(ConnectionChange());

      if (state == BluetoothConnectionState.connected) {
        bluetooth.setDevice(device);
        await bluetooth.init();
      }

      if (state == BluetoothConnectionState.disconnected) {
        connectToBluetooth();
      }
    });
  }

  Future<void> unlockDoor() async {
    try {
      if (isConnected) {
        handled = false;
        bluetooth.onDataReceived = (data) {
          if (data == "Grant" && !handled) {
            unLocked = true;
            handled = true;
            lockController.forward();
            emit(LockStatusChanged());
            Timer(
              const Duration(seconds: 7),
              () {
                unLocked = false;
                handled = true;
                lockController.reverse();
                emit(LockStatusChanged());
              },
            );
          } else if (data == "Deny" && !handled) {
            displayToast(S().invalidPassword);
          }
        };
        await bluetooth.sendCommand("UNLOCK:${passwordController.text}");
      } else {
        displayToast(S().notConnectedToSmartLock);
      }
    } catch (e) {
      displayToast(S().errorSendingUnlockCommand);
    }
  }

  void onLockStatusChange() => emit(LockStatusChanged());
}
