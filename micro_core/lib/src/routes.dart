class AppRoutes {
final _Onboarding onboarding = const _Onboarding(); 

}

class  _Onboarding {
  static const _root  = '/onboarding';
  const _Onboarding();
  final String root = _root;
  final String welcome = '$_root/welcome';
  final String login = '$_root/login';

}