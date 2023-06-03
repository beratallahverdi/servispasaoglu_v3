import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// A simple widget that builds different things on different platforms.
class PlatformWidget extends StatelessWidget {
  const PlatformWidget({
    Key? key,
    required this.androidBuilder,
    required this.iosBuilder,
  }) : super(key: key);

  final Widget androidBuilder;
  final Widget iosBuilder;

  @override
  Widget build(context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidBuilder;
      case TargetPlatform.iOS:
        return iosBuilder;
      default:
        assert(false, 'Unexpected platform $defaultTargetPlatform');
        return const SizedBox.shrink();
    }
  }
}
