import 'package:micro_app_home/app/pages/home/pages/home_page.dart';
import 'package:micro_core/micro_core.dart';

import 'pages/home/controllers/root_controller.dart';

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
  };

}