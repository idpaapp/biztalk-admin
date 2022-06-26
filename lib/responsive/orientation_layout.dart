import 'package:flutter/widgets.dart';

class OrientationLayout extends StatelessWidget {
  const OrientationLayout({
    Key? key,
    required this.portrait,
    this.landscape,
  }) : super(key: key);

  final Widget portrait;
  final Widget? landscape;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return landscape ?? portrait;
        }
        return portrait;
      },
    );
  }
}
