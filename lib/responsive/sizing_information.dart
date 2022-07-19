import 'package:flutter/widgets.dart';

import 'device_screen_type.dart';

class SizingInformation {
  SizingInformation({
    required this.orientation,
    required this.deviceScreenType,
    required this.screenSize,
    required this.localWidgetSize,
  });

  final Orientation orientation;
  final DeviceScreenType deviceScreenType;
  final Size screenSize;
  final Size localWidgetSize;

  @override
  String toString() {
    return 'Orientation: $orientation\n' 'DeviceScreenType: $deviceScreenType\n' 'ScreenSize: $screenSize\n' 'LocalWidgetSize: $localWidgetSize\n';
  }
}
