import 'package:flutter/material.dart';
import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return VerifyPhonePage(onContinue: (phone){
      CoreNavigator.pushReplacementNamed(AppRoutes.onboarding.validatePin);
    },
     verifyToCreate: false, verifyToLogin: true);
  }
}