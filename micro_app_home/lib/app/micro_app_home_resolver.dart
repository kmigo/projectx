
import 'package:micro_app_home/app/pages/send_transaction/send_transaction_page.dart';
import 'package:micro_core/micro_core.dart';


import 'pages/home/home_page.dart';

class MicroAppHomeResolver extends MicroApp {
  @override
  void Function() get injectionRegister => (){

  };

  @override

  String get microAppName => AppRoutes.home.microAppName;

  @override
  // TODO: implement routes
  Map<String, WidgetBuildArgs> get routes => {
    AppRoutes.home.root : (ctx,args) => const HomePage(),
    AppRoutes.home.sendTransaction : (ctx,args) => const SendTransactionPage(),
  };

}