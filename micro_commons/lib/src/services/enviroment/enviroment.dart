

import 'package:micro_core/micro_core.dart';

enum VarEnvs { secret, baseUrl,consumer,xapikey}

enum RemoteConfigVars {apps,phones}

class EnvironmentVariables {
   FirebaseRemoteConfig? _remoteConfig;

  init() async {
    _remoteConfig = FirebaseRemoteConfig.instance;
    await _remoteConfig!.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours:1),
    ));
    await _remoteConfig!.fetchAndActivate();


  }

  static String getVariable(VarEnvs varEnv) {
    return dotenv.env[varEnv.name] ?? '';
  }

  static String getRemoteConfigString(RemoteConfigVars varEnv) {
    return FirebaseRemoteConfig.instance.getString(varEnv.name);
  }
  static String getRemoteConfigMap(RemoteConfigVars varEnv) {
    return FirebaseRemoteConfig.instance.getString(varEnv.name);
  }
}
