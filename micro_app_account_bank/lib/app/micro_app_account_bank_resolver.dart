import 'package:micro_app_account_bank/app/pages/register_account_bank/register_account_bank_page.dart';
import 'package:micro_core/micro_core.dart';

class MicroAppAccountBankResolver extends MicroApp {
  @override
  void Function() get injectionRegister => (){};

  @override
  String get microAppName =>AppRoutes.accountBank.microAppName;

  @override
  Map<String, WidgetBuildArgs> get routes => {
    AppRoutes.accountBank.registerBank : (ctx,args) => const RegisterAccountBankPage(),
  };

}