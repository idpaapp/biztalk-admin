import 'package:flutter/widgets.dart';

import 'device_screen_type.dart';
import 'responsive_builder.dart';

class ScreenTypeLayout extends StatelessWidget {
  const ScreenTypeLayout({
    Key? key,
    required this.desktop,
    this.tablet,
    this.mobile,
  }) : super(key: key);

  final Widget desktop;
  final Widget? tablet;
  final Widget? mobile;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        switch (sizingInformation.deviceScreenType) {
          case DeviceScreenType.desktop:
            return desktop;
          case DeviceScreenType.tablet:
            return tablet ?? desktop;
          case DeviceScreenType.mobile:
            return mobile ?? desktop;
        }
      },
    );
  }
}
