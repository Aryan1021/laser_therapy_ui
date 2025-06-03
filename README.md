# Laser Therapy UI

A Flutter application that provides a user interface for configuring and monitoring laser therapy sessions via UART communication over USB.

---

## 📱 Features

- Configure laser treatment parameters:
  - Intensity
  - Frequency
  - Duration
- Communicate with external hardware using UART over USB
- Real-time data stream via USB serial
- Safe Mode screen on connection failure
- Treatment timer with progress display

---

## 🖼️ UI Design

👉 [View UI Design on Canva](https://www.canva.com/design/DAGpOXTpQTw/9HVbYzxGD-u-u16Cm1Ux9A/view?utm_content=DAGpOXTpQTw&utm_campaign=designshare&utm_medium=link2&utm_source=uniquelinks&utlId=hbbd024986e)

---

## 🔌 UART Integration

This app uses [`usb_serial`](https://pub.dev/packages/usb_serial) to connect to a USB device via UART.

---

## Permissions

Ensure these are added in `AndroidManifest.xml`:

<uses-permission android:name="android.hardware.usb.host" />
<uses-feature android:name="android.hardware.usb.host" />

---

## device_filter.xml

Create android/app/src/main/res/xml/device_filter.xml with your USB Vendor and Product IDs:
<resources>
    <usb-device vendor-id="2341" product-id="0043" />
</resources>
Find your USB IDs via lsusb (Linux/macOS) or Device Manager (Windows).

---

### Manifest Registration

Inside your <activity> tag in AndroidManifest.xml:
<intent-filter>
    <action android:name="android.hardware.usb.action.USB_DEVICE_ATTACHED" />
</intent-filter>

<meta-data
    android:name="android.hardware.usb.action.USB_DEVICE_ATTACHED"
    android:resource="@xml/device_filter" />

---

## 🚀 Getting Started

1. Clone the repo:
   git clone https://github.com/your-username/laser_therapy_ui.git
   cd laser_therapy_ui

2. Install dependencies:
   flutter pub get

3. Run the app on Android:
   flutter run

4. Connect your UART-enabled USB device (OTG supported).

---

## 🧪 Testing

- UART messages are logged via console.
- Received messages are displayed in real time in the UI.
- Safe Mode screen triggers on failed connections.

---

## 📦 Dependencies

- usb_serial
- google_fonts

---

## 🛠 TODO

- Add animation for UART connection state
- Support device disconnection handling
- Add logging/export features

---

## 📄 License

MIT License. See LICENSE.
