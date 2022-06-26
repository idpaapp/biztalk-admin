import 'package:flutter/widgets.dart';

import 'device_screen_type.dart';
import 'sizing_information.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({Key? key, required this.builder}) : super(key: key);

  final Widget Function(
      BuildContext context, SizingInformation sizingInformation) builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var mediaQuery = MediaQuery.of(context);
        var sizingInformation = SizingInformation(
          orientation: mediaQuery.orientation,
          deviceScreenType: getDeviceType(mediaQuery),
          screenSize: mediaQuery.size,
          localWidgetSize: Size(constraints.maxWidth, constraints.maxHeight),
        );
        return builder(context, sizingInformation);
      },
    );
  }

  DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
    // var orientation = mediaQuery.orientation;
    double deviceWidth = 0;

    /* deviceWidth = (orientation == Orientation.portrait)
        ? mediaQuery.size.width
        : mediaQuery.size.height; */

    deviceWidth = mediaQuery.size.width;

    if (deviceWidth >= 1000.0) return DeviceScreenType.Desktop;
    if (deviceWidth >= 600.0) return DeviceScreenType.Tablet;
    return DeviceScreenType.Mobile;
  }
}
