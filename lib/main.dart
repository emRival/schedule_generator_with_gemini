import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:schedule_generator/ui/home_screen.dart';

void main() {
  runApp(DevicePreview(
      // jika di web, ubah menjadi true
      enabled: true,
      defaultDevice: Devices.ios.iPhone13ProMax,
      devices: [Devices.ios.iPhone13ProMax],
      builder: (context) => MaterialApp(
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
          )));
}
