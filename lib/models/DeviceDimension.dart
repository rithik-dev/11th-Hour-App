import 'package:flutter/cupertino.dart';

class DeviceDimension extends ChangeNotifier {
  double height;
  double width;

  DeviceDimension({this.height, this.width});

  void updateDeviceInProvider({DeviceDimension device}) {
    this.width = device.width;
    this.height = device.height;
    notifyListeners();
  }
}
