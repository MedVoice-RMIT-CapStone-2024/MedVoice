# med_voice

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Configurations when running the app

This project is being developed under Flutter sdk version 3.19.5. Make sure your local IDE's sdk version the same as us.

After cloning the project, make sure to flutter pub get to install the app's neccessary library packages for the build.

Locate and run the main.dart file to start building the application.

## Backend

The app talks to [medvoice-service](https://github.com/medvoice-research/medvoice-service)
over its `/recordings` API (multipart upload -> transcript + SOAP/ICD-10/PHI
document; list, get, delete).

Set `Constants.baseUrl` in `lib/data/network/constants.dart` to your server:
`http://localhost:8000/` for the emulator, your LAN IP or an ngrok URL for a
physical device.
