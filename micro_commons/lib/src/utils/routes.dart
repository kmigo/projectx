// ignore_for_file: library_private_types_in_public_api

class AppRoutes {
static const  _Onboarding onboarding =  _Onboarding(); 
static String root = '/';

}

class  _Onboarding {
  static const _root  = '/onboarding';
  const _Onboarding();
  final String root = _root;
  final String welcome = '$_root/welcome';
  final String createAccount = '$_root/create-account';
  final String login = '$_root/login';
}