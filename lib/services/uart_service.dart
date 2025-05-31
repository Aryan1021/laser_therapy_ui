import 'dart:typed_data';
import 'package:usb_serial/usb_serial.dart';

class UARTService {
  UsbPort? _port;

  Future<bool> connect() async {
    List<UsbDevice> devices = await UsbSerial.listDevices();
    if (devices.isEmpty) return false;

    UsbDevice device = devices.first;
    _port = await device.create();

    if (!await _port!.open()) return false;

    await _port!.setDTR(true);
    await _port!.setRTS(true);
    await _port!.setPortParameters(
      9600,
      UsbPort.DATABITS_8,
      UsbPort.STOPBITS_1,
      UsbPort.PARITY_NONE,
    );

    _port!.inputStream?.listen((Uint8List data) {
      final message = String.fromCharCodes(data);
      print('Received: \$message');
    });

    return true;
  }

  void send(String message) {
    _port?.write(Uint8List.fromList(message.codeUnits));
  }

  void disconnect() {
    _port?.close();
  }
}
