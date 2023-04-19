import 'package:flutter/widgets.dart';
import 'package:windows_border_test/src/bindings/device_frame_widget_binding.dart';

void runDeviceFrameApp(Widget app) {
  DeviceFrameWidgetBinding.ensureInitialized()
    ..attachRootWidget(
      DeviceFrameApp(
        child: RepaintBoundary(
          key: DeviceFrameWidgetBinding.instance!.deviceScreenKey,
          child: app,
        ),
      ),
    )
    ..scheduleWarmUpFrame();
}

class DeviceFrameApp extends StatefulWidget {
  const DeviceFrameApp({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<DeviceFrameApp> createState() => _DeviceFrameAppState();
}

class _DeviceFrameAppState extends State<DeviceFrameApp> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
