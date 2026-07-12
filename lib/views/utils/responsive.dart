import 'package:flutter/material.dart';

/// Breakpoints for responsive layout
class AppBreakpoints {
  AppBreakpoints._();

  static const double mobile = 480;
  static const double tablet = 768;
  static const double desktop = 1024;
}

/// Determines the current device type based on screen width.
enum DeviceType { mobile, tablet, desktop }

/// Extension on BuildContext for responsive helpers.
extension ResponsiveExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get topPadding => MediaQuery.of(this).padding.top;
  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  DeviceType get deviceType {
    if (screenWidth < AppBreakpoints.mobile) return DeviceType.mobile;
    if (screenWidth < AppBreakpoints.tablet) return DeviceType.tablet;
    return DeviceType.desktop;
  }

  bool get isMobile => deviceType == DeviceType.mobile;
  bool get isTablet => deviceType == DeviceType.tablet;
  bool get isDesktop => deviceType == DeviceType.desktop;

  /// Responsive value: returns [mobile] on phones, [tablet] on tablets, [desktop] on desktops.
  T responsive<T>({required T mobile, T? tablet, T? desktop}) {
    switch (deviceType) {
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.mobile:
        return mobile;
    }
  }

  /// Horizontal padding adapted to screen size
  double get horizontalPadding => responsive(mobile: 16.0, tablet: 24.0, desktop: 32.0);

  /// Standard content padding
  EdgeInsets get contentPadding => EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16.0);
}

/// A widget that builds different layouts based on available width.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppBreakpoints.desktop) {
          return desktop ?? tablet ?? mobile;
        }
        if (constraints.maxWidth >= AppBreakpoints.tablet) {
          return tablet ?? mobile;
        }
        return mobile;
      },
    );
  }
}
