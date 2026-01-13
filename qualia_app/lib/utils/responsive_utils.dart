import 'package:flutter/material.dart';

/// Responsive breakpoints
class ResponsiveBreakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
}

/// Responsive utility functions
extension ResponsiveContext on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < ResponsiveBreakpoints.mobile;
  bool get isTablet => MediaQuery.of(this).size.width >= ResponsiveBreakpoints.mobile && 
                       MediaQuery.of(this).size.width < ResponsiveBreakpoints.tablet;
  bool get isDesktop => MediaQuery.of(this).size.width >= ResponsiveBreakpoints.tablet;
  
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}

/// Helper functions
bool isMobile(BuildContext context) => context.isMobile;
bool isTablet(BuildContext context) => context.isTablet;
bool isDesktop(BuildContext context) => context.isDesktop;
