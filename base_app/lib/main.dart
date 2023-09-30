// ignore_for_file: depend_on_referenced_packages, prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:micro_app_home/micro_app_home.dart';
import 'package:micro_app_onboarding/app/micro_app_login_resolver.dart';
import 'package:micro_app_profile/micro_app_profile.dart';
import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

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

    await Firebase.initializeApp(options: const FirebaseOptions(
    apiKey: 'AIzaSyC9vmQG0Qz3sSsIaoYNtsjSy7LS2GLMTWk',
    appId: '1:1008638544397:web:b30ca9d192136fc1412344',
    messagingSenderId: '1008638544397',
    projectId: 'uoleti-staging',
    authDomain: 'uoleti-staging.firebaseapp.com',
    databaseURL: 'https://uoleti-staging-default-rtdb.firebaseio.com',
    storageBucket: 'uoleti-staging.appspot.com',
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
      initialRoute: AppRoutes.root,
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
    AppRoutes.root : (context, args) => const WelcomePage()
  };
  
  @override
  List<MicroApp> get microApps => [
    MicroAppOnboardingResolver(),
    MicroAppHomeResolver(),
    MicroAppProfileResolver()

  ];
  commonsInjections(){
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