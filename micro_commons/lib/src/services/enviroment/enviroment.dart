

import 'dart:convert';

import 'package:micro_core/micro_core.dart';

enum VarEnvs { secret, baseUrl,consumer,xapikey}

enum RemoteConfigVars {apps,phones}

class EnvironmentVariables {
   static FirebaseRemoteConfig? _remoteConfig;

  static Future<void> init() async {
    _remoteConfig = FirebaseRemoteConfig.instance;
    await _remoteConfig!.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours:1),
    ));

    await _remoteConfig!.fetchAndActivate();
    _remoteConfig!.setDefaults({
  "phones":"""{
  "+55": {
    "mask": "(##) #####-####",
    "hint": "(00) 00000-0000",
    "country": "Brasil",
    "is_active": true,
    "abbreviation": "BRA",
    "img": "https://firebasestorage.googleapis.com/v0/b/project-x-a4278.appspot.com/o/brasil.jpg?alt=media&token=de380590-8d00-4f9f-8d42-be9c9441dab1"
  },
  "+1": {
    "mask": "(###) ###-####",
    "hint": "(000) 000-00000",
    "is_activate": false,
    "country": "",
    "abbreviation": "CAN",
    "img": "https://firebasestorage.googleapis.com/v0/b/project-x-a4278.appspot.com/o/canada.jpg?alt=media&token=e6a8af48-b4c2-4daa-957b-476e54ecb89e"
  }
}"""
});
  }

  static String getVariable(VarEnvs varEnv) {
    return dotenv.env[varEnv.name] ?? '';
  }

  static String getRemoteConfigString(RemoteConfigVars varEnv) {
    return _remoteConfig!.getString(varEnv.name);
  }
  
  static Map<String,dynamic> getRemoteConfigMap(RemoteConfigVars varEnv) {

    return json.decode(_remoteConfig!.getString(varEnv.name));
  }
}
