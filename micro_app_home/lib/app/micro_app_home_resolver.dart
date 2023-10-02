
import 'package:micro_app_home/app/pages/send_transaction/send_transaction_page.dart';
import 'package:micro_core/micro_core.dart';

import 'pages/home/controllers/root_controller.dart';
import 'pages/home/pages/home_page.dart';

class MicroAppHomeResolver extends MicroApp {
  @override
  void Function() get injectionRegister => (){
    CoreBinding.registerLazySingleton<RootController>((i) => RootController());
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