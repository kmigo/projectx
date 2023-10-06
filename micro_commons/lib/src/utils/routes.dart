// ignore_for_file: library_private_types_in_public_api

class AppRoutes {
static const  _Onboarding onboarding =  _Onboarding(); 
static const _Home home =  _Home(); 
static const _Profile profile =  _Profile();
static const _Extract extract =  _Extract();
static const _SendTransaction sendTransaction =  _SendTransaction();
static const _PixTransaction pixTransaction =  _PixTransaction();
static const _AccountBank accountBank =  _AccountBank();
static String root = '/';
static String cameraPage = '/camera-page';

}

class  _Onboarding {
  static const _root  = '/onboarding';
  const _Onboarding();
  final String root = _root;
  final String microAppName = 'micro_app_onboarding';
  final String validatePin = '$_root/validate-pin';
  final String createAccount = '$_root/create-account';
  final String createPin = '$_root/create-pin';
  final String login = '$_root/login';
}

class _Home {
  static const _root = '/home';
  const _Home();
  final String root = _root;
  final String microAppName = 'micro_app_home';
  final String sendTransaction = '$_root/send-transaction';

}

class _Profile {
  static const _root = '/profile';
  const _Profile();
  final String root = _root;
  final String microAppName = 'micro_app_profile';
  final String address = '$_root/address';
  final String fingerprint = '$_root/fingerprint';
  final String limit = '$_root/limit';
  final String password = '$_root/password';
  final String phoneNumber = '$_root/phone-number';
  final String personal = "$_root/personal";
  final String selfie = '$_root/selfie';
  final String validatorDocument = '$_root/validator-document';
}

class _Extract {
  static const _root = '/extract';
  const _Extract();
  final String root = _root;
  final String microAppName = 'micro_app_extract';
  final String filter = '$_root/filter';
  final String extract = '$_root/extract';
  final String extractDetail = '$_root/extract-detail';
}

class _SendTransaction {
  static const _root = '/send-transaction';
  const _SendTransaction();
  final String root = _root;
  final String microAppName = 'micro_app_send_transaction';
}

class _PixTransaction {
  static const _root = '/pix-transaction';
  final String microAppName = 'micro_app_pix_transaction';
  const _PixTransaction();
  final String root = _root;
  final String selectKeys = '$_root/select-keys';
  final String queryPixKey = '$_root/query-pix-key';
  final String reviewUserBeforeSendPix = '$_root/review-user-before-send-pix';
  final String registerPix = '$_root/register-pix';
}

class _AccountBank {
  static const _root = '/account-bank';
  const _AccountBank();
  final String root = _root;
  final String microAppName = 'micro_app_account_bank';
  final String registerBank = '$_root/register-bank';
}