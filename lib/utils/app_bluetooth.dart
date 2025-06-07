import 'dart:convert';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class AppBluetooth {
  static final AppBluetooth _instance = AppBluetooth._internal();

  BluetoothDevice? _device;
  BluetoothCharacteristic? writeCharacteristic;
  BluetoothCharacteristic? notifyCharacteristic;
  Function(String)? onDataReceived;

  factory AppBluetooth() => _instance;

  AppBluetooth._internal(); // Private constructor

  // Set Bluetooth device
  void setDevice(BluetoothDevice device) {
    _device = device;
  }

  Future<void> init() async {
    if (_device != null) {
      List<BluetoothService> services = await _device!.discoverServices();

      for (var service in services) {
        for (var characteristic in service.characteristics) {
          print("Characteristic UUID: ${characteristic.uuid}, Properties: ${characteristic.properties}");

          // Match HM-10 UUID (FFE1)
          if (characteristic.uuid.toString().toLowerCase() == "ffe1") {
            if (characteristic.properties.writeWithoutResponse) {
              writeCharacteristic = characteristic;
              print("Writable characteristic found: ${characteristic.uuid}");
            }

            if (characteristic.properties.notify) {
              notifyCharacteristic = characteristic;
              await notifyCharacteristic!.setNotifyValue(true);
              print("Notification characteristic found: ${characteristic.uuid}");

              notifyCharacteristic!.lastValueStream.listen((data) {
                try {
                  // Try decoding the data as UTF-8
                  String receivedData = utf8.decode(data, allowMalformed: true);
                  print("Received from HM-10: $receivedData");
                  if (onDataReceived != null) {
                    onDataReceived!(receivedData);
                  }
                } on FormatException catch (e) {
                  // Handle invalid UTF-8 data
                  print("Invalid UTF-8 data received: $e");
                  print("Raw data: $data");
                }
              });
            }
          }
        }
      }
    } else {
      print("No connected device.");
    }
  }

  Future<void> sendCommand(String command) async {
    if (writeCharacteristic != null) {
      print("Sending command: $command");
      await writeCharacteristic!.write(utf8.encode(command), withoutResponse: true);
    } else {
      print("No writable characteristic found!");
    }
  }
}
