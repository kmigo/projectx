// ignore_for_file: depend_on_referenced_packages, prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:micro_app_account_bank/app/micro_app_account_bank_resolver.dart';
import 'package:micro_app_extract/app/micro_app_extract_resolver.dart';
import 'package:micro_app_home/micro_app_home.dart';
import 'package:micro_app_onboarding/app/micro_app_login_resolver.dart';
import 'package:micro_app_pix/micro_app_pix_transaction.dart';
import 'package:micro_app_profile/micro_app_profile.dart';
import 'package:micro_commons_user/micro_commons_user.dart';

import 'package:micro_core/micro_core.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'config.dart';
import 'pages/camera.dart';
import 'pages/welcome.dart';
void main() async {
  await MyApp.start();
  runApp( const MyApp());
}
class MyApp extends StatefulWidget  {

   const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static Future<void> start()async{
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: 'files/env');
    currentFlavorConfig();
    await Firebase.initializeApp(options: const FirebaseOptions(
    apiKey: 'AIzaSyDkqMNn5xwLEfpT4uT06QAvqSIaqSfAssA',
    appId: '1:591107971587:web:881cd3033f51bfad834c36',
    messagingSenderId: '591107971587',
    projectId: 'project-x-a4278',
    authDomain: 'project-x-a4278.firebaseapp.com',
    databaseURL: 'https://project-x-a4278-default-rtdb.firebaseio.com',
    storageBucket: 'project-x-a4278.appspot.com',
    measurementId: 'G-2ZK837RNR4',
  ));

await EnvironmentVariables.init();
      FlutterError.onError = (errorDetails) {
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      return true;
    };

  }
}

class _MyAppState extends State<MyApp> with BaseApp {
  late final  bloc ;
  @override
  void initState() {
    super.initState();
  registerRoutes();
    CoreBinding.registerSingleton<UolletiKeyboardBloc>( (i) =>UolletiKeyboardBloc());
    
  registerInjections();
  
  initializeInjectionsUser();
  commonsInjections();
bloc = CoreBinding.get<AuthenticationBloc>();



  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      navigatorObservers: [MyNavigatorObserver()],
      routes: routes.map((key, value) => MapEntry(key, (context) =>  value(context,null))),
      onGenerateRoute: generateRoute,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.root,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      builder: (context, child) {
      
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          bloc: bloc,
          listener: (context, state) {
            
            switch (state.status.status) {
              case StatusAuthentication.unknow:
                bloc.add(AuthenticationCurrentUserEvent());
                break;
              case StatusAuthentication.authentication:
                break;
              case StatusAuthentication.signup:
                break;
              case StatusAuthentication.signin:
                break;
              case StatusAuthentication.unauthentication:
                break;
              case StatusAuthentication.signOut:
              CoreNavigator.pushNamedAndRemoveUntil(
                    AppRoutes.root, ModalRoute.withName(AppRoutes.root));
                break;
              case StatusAuthentication.error:
                break;
            }
          },
          child: BlocBuilder<UolletiKeyboardBloc, UolletiKeyboardTypeState>(
            bloc: CoreBinding.get<UolletiKeyboardBloc>(),
            builder: (context, state) {
              
              return Material(child: Column(
                children: [
                  Expanded(child: child ?? const SizedBox()),
                  if ((state.type == UolletiKeyboardType.numeric || state.type == UolletiKeyboardType.numericWithoutObserver) && !state.isHide)
                    const UolletiKeyboardNumeric()
                ],
              ));
            },
          ),
        );
      },
    );
  }
  
  @override

  Map<String, WidgetBuildArgs> get baseRoutes => {
    AppRoutes.root : (context, args) => const WelcomePage(),
    AppRoutes.cameraPage:(context, args) => const CameraPhoto()
  };
  
  @override
  List<MicroApp> get microApps => [
    MicroAppOnboardingResolver(),
    MicroAppHomeResolver(),
    MicroAppProfileResolver(),
    MicroAppExtractResolver(),
    MicroAppPixTransactionResolver(),
    MicroAppAccountBankResolver()

  ];
  commonsInjections(){

    CoreBinding.registerLazySingleton<CacheHelper>((p0) => CacheHelperImpl());

  CoreBinding.registerLazySingleton<ClientHttp>((i) => HttpClientDio(
    baseUrl:EnvironmentVariables.getVariable(VarEnvs.baseUrl),
     signOut: () async {
                await i<SignOutUsecase>().call();
              },
           refreshToken: () async {
                try {
                  await FirebaseAuth.instance.currentUser!
                      .getIdTokenResult(true);
                } catch (e) {
                  debugPrint(e.toString());
                  return null;
                }
              },
              getToken: () async {
                try {
                  return await FirebaseAuth.instance.currentUser!.getIdToken();
                } catch (e) {
                  debugPrint(e.toString());
                  return null;
                }
              } 
    

  ));
}
  
}

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    CoreBinding.get<UolletiKeyboardBloc>().hide();

  }
  @override
void didPush(Route route, Route? previousRoute) {
  super.didPush(route, previousRoute);
  CoreBinding.get<UolletiKeyboardBloc>().hide();

}
@override
void didRemove(Route route, Route? previousRoute) {
  super.didRemove(route, previousRoute);
  CoreBinding.get<UolletiKeyboardBloc>().hide();

}

@override
void didReplace({Route? newRoute, Route? oldRoute}) {
  super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
CoreBinding.get<UolletiKeyboardBloc>().hide();
}



}