import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:windows_border_test/devices/device_info.dart';

class DeviceFrameWidget extends StatefulWidget {
  const DeviceFrameWidget({
    super.key,
    required this.deviceInfo,
    required this.child,
  });

  final DeviceInfo deviceInfo;
  final Widget child;

  @override
  State<DeviceFrameWidget> createState() => _DeviceFrameWidgetState();
}

class _DeviceFrameWidgetState extends State<DeviceFrameWidget>
    with WidgetsBindingObserver {
  final _repaintBoundaryKey = GlobalKey();
  late MediaQueryData _mediaQuery;

  @override
  void initState() {
    super.initState();

    _mediaQuery = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    _mediaQuery = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Widget _buildApp(BuildContext context) {
    final deviceInfo = widget.deviceInfo;

    return MediaQuery(
      data: _mediaQuery.copyWith(
        size: deviceInfo.screenSize,
        viewPadding: deviceInfo.viewPadding,
        padding: deviceInfo.viewPadding,
        devicePixelRatio: deviceInfo.scaleFactor,
      ),
      child: FittedBox(
        fit: BoxFit.fill,
        child: SizedBox(
          width: deviceInfo.screenSize.width,
          height: deviceInfo.screenSize.height,
          child: widget.child,
        ),
      ),
    );
  }

  Widget _buildFrame(BuildContext context, Widget child) {
    final frameInfo = widget.deviceInfo.frame!;

    return FittedBox(
      fit: BoxFit.fill,
      child: SizedBox(
        width: frameInfo.size.width,
        height: frameInfo.size.height,
        child: frameInfo.builder(context, child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final frame = widget.deviceInfo.frame;

    late final Widget child;

    if (frame != null) {
      child = _buildFrame(context, _buildApp(context));
    } else {
      child = _buildApp(context);
    }

    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RepaintBoundary(
          key: _repaintBoundaryKey,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
