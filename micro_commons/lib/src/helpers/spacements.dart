part of 'helpers.dart';

class Spacements {
  static double smallSpacement(BuildContext context) {
    return ScreenSize.getHeight(context) * 0.03;
  }

  static double mediumSpacement(BuildContext context) {
    return ScreenSize.getHeight(context) * 0.05;
  }

  static double largeSpacement(BuildContext context) {
    return ScreenSize.getHeight(context) * 0.1;
  }
}
