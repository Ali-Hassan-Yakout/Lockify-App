# 🔐 Lockify – Smart Door Lock System

**Lockify** is a smart, multi-factor door locking system that combines **fingerprint (R307S)**, **RFID (PN532)**, and **mobile app password authentication** for secure and convenient access control. Designed and built from scratch, Lockify includes a custom PCB, a Flutter-based mobile app, and Arduino-powered firmware.

This project demonstrates the integration of embedded systems with modern mobile technologies to deliver a scalable, secure, and user-friendly smart lock solution.

---

## 🚀 Features

- 🔐 Unlock using:
  - Fingerprint (R307S Sensor)
  - RFID Card (PN532 NFC Module)
  - Mobile App Password
- 📱 Flutter Mobile App
  - Bluetooth control via HM-10
  - Add/delete fingerprints and RFID tags
  - Change lock password
  - Dark mode and real-time feedback
- 💾 Secure Firebase storage for credentials
- 🔔 LED indicators and buzzer alerts
- 🧠 Custom-designed PCB using EasyEDA
- 🔧 Arduino firmware with real-time authentication logic

---

## 📱 Mobile App

Built using Flutter, the Lockify mobile app offers:

- Remote unlocking via password
- Fingerprint and RFID management
- Real-time success/error dialogs
- Dark/light mode UI
- Bluetooth communication with HM-10

---

## 🛠️ Hardware Components

| Component             | Description                          |
|----------------------|--------------------------------------|
| Arduino Microcontroller | ATmega328P (custom PCB or Uno)    |
| Fingerprint Sensor   | R307S Optical Sensor                 |
| RFID Module          | PN532 NFC                            |
| Bluetooth Module     | HM-10                                |
| Lock Mechanism       | 12V Solenoid Lock controlled by Relay|
| Display              | 16x2 I2C LCD                         |
| Buzzer & LEDs        | Status indication and alerts         |

---

## 🧩 PCB Design

Designed in **EasyEDA**, the custom PCB:
- Integrates all modules compactly
- Includes regulated power supply and protections
- Supports external programming via ISP
- Comes with provided Gerber files for manufacturing

---

## ⚙️ Installation

1. Assemble hardware using the provided schematic/PCB.
2. Flash the Arduino firmware (`/firmware`) to the ATmega328P.
3. Install the mobile app (source in `/flutter_app`) and pair with the HM-10 module.
4. Use the app to register fingerprints, RFID tags, and set your password.
5. Enjoy secure access control with Lockify!

---

## 📷 Interface

> [Mobile](https://drive.google.com/file/d/1NjUE8evuCRzGWF_NQTcrb2HZdYM41f_H/view?usp=drive_link)
> [Embedded](https://drive.google.com/file/d/1ZTTSjq7mYW8YOeCLef8pRwO5g1CNkfME/view?usp=drive_link)


---

## 👨‍💻 Developed By

**Ali Hassan Yakout Elsayed**  
Graduation Project – Faculty of Computers & Artificial Intelligence  
Modern University for Technology and Information (MTI)  

---
