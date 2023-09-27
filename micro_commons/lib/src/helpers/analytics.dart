

part of 'helpers.dart';

class HelperAnalytcs {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
       static Future<void> sendAnalyticsEvent(String event,Map<String,dynamic> data) async {

    await analytics.logEvent(
      name: event,
      parameters: data,
    );
  }
}