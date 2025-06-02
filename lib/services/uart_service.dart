import 'dart:typed_data';
import 'dart:async';
import 'package:usb_serial/usb_serial.dart';

class UARTService {
  UsbPort? _port;
  final StreamController<String> _controller = StreamController.broadcast();

  Stream<String> get onData => _controller.stream;

  Future<bool> connect() async {
    print('>> Trying to connect UART...');

    List<UsbDevice> devices = await UsbSerial.listDevices();
    print('>> USB Devices Found: ${devices.length}');
    if (devices.isEmpty) {
      print('>> No USB devices detected.');
      return false;
    }

    // Just pick the first device (improve later to match filter)
    UsbDevice device = devices.first;

    _port = await device.create();
    if (_port == null) {
      print('>> Failed to create port');
      return false;
    }

    bool opened = await _port!.open();
    if (!opened) {
      print('>> Failed to open port');
      return false;
    }

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
      print('>> UART Received: $message');
      _controller.add(message);
    });

    print('>> UART connection established.');
    return true;
  }

  void send(String message) {
    if (_port != null) {
      final bytes = Uint8List.fromList(message.codeUnits);
      _port!.write(bytes);
      print('>> UART Sent: $message');
    }
  }

  void disconnect() {
    _port?.close();
    _controller.close();
    print('>> UART disconnected.');
  }
}
