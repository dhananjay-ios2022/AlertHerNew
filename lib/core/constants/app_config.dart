
import 'dart:ui';

import 'my_colors.dart';

class NavigationState {
  static bool canAccessOtpScreen = false;
}

/// App configuration constants
class AppDimensions {
  static const double fixedWidthCondition = 1024.0;
  static const double fixedScreenWidth = 393.0;
  static const double fixedScreenHeight = 852.0;

}


Color getColor(int value) {
  switch (value) {
    case 1:
      return MyColors.green;
    case 2:
      return MyColors.green500;
    case 3:
      return MyColors.yellow;
    case 4:
      return MyColors.orange500;
    case 5:
      return MyColors.red;
    default:
      return MyColors.grayDark;
  }
}