// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;

const String flavorDev = '''
    apiKey: "AIzaSyDkqMNn5xwLEfpT4uT06QAvqSIaqSfAssA",
  authDomain: "project-x-a4278.firebaseapp.com",
  databaseURL: "https://project-x-a4278-default-rtdb.firebaseio.com",
  projectId: "project-x-a4278",
  storageBucket: "project-x-a4278.appspot.com",
  messagingSenderId: "591107971587",
  appId: "1:591107971587:web:881cd3033f51bfad834c36"
''';

const String flavorProd = '''
   apiKey: "AIzaSyDkqMNn5xwLEfpT4uT06QAvqSIaqSfAssA",
  authDomain: "project-x-a4278.firebaseapp.com",
  databaseURL: "https://project-x-a4278-default-rtdb.firebaseio.com",
  projectId: "project-x-a4278",
  storageBucket: "project-x-a4278.appspot.com",
  messagingSenderId: "591107971587",
  appId: "1:591107971587:web:881cd3033f51bfad834c36"
''';

String currentFlavorConfig() {
  // flutter run -d chrome --dart-define=flavor=dev
  const flavor = String.fromEnvironment("flavor", defaultValue: "dev");
  if (flavor == "prod") {
    return flavorProd;
  }
  return flavorDev;
}

void createFirebaseLibraryScript() {
  html.ScriptElement script = html.ScriptElement();
  script.src = "https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js";
  script.type = "text/javascript";
  html.document.head!.append(script);
}

void createScriptElement() {
  /// Create a new JS element
  html.ScriptElement script = html.ScriptElement();

  /// Add the inline Firebase configuration
  script.innerHtml = '''
    // Your web app's Firebase configuration
    var firebaseConfig = {
      ${currentFlavorConfig()}
    };
    // Initialize Firebase
    firebase.initializeApp(firebaseConfig);
  ''';

  /// On that script element, add the `type` and `id` properties
  script.type = "text/javascript";
  script.id = "firebase-config-script";

  /// Append the script to the head of the document
  html.document.head!.append(script);
}

