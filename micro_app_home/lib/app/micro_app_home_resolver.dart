

import 'package:micro_core/micro_core.dart';


import '../src/datasources/card.dart';
import '../src/repositories/card.dart';
import '../src/usecase/get_card.dart';
import 'blocs/card_list/bloc.dart';
import 'pages/home/home_page.dart';

class MicroAppHomeResolver extends MicroApp {
  @override
  void Function() get injectionRegister => (){
    // Datasources
    CoreBinding.registerLazySingleton<CardDatasource>((i) => CardDatasourceImpl(i()));
    // Repositories
    CoreBinding.registerLazySingleton<CardRepository>((i) => CardRepositoryImpl(i()));
    // Usecases
    CoreBinding.registerLazySingleton<GetCardUsecase>((i) => GetCardUsecaseImpl(i()));
    // Bloc
    CoreBinding.registerLazySingleton((i) => CardListBloc(i()));

  };

  @override
  String get microAppName => AppRoutes.home.microAppName;

  @override
  Map<String, WidgetBuildArgs> get routes => {
    AppRoutes.home.root : (ctx,args) => const HomePage(),

  };

}