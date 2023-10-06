import 'package:flutter/material.dart';
import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';

class ValidatePincodeUserPage extends StatefulWidget {
  const ValidatePincodeUserPage({super.key});

  @override
  State<ValidatePincodeUserPage> createState() => _ValidatePincodeUserPageState();
}

class _ValidatePincodeUserPageState extends State<ValidatePincodeUserPage> {

  @override
  Widget build(BuildContext context) {
    return ValidatePincodePage(onContinue: (){
      CoreNavigator.pushNamedAndRemoveUntil(AppRoutes.home.root, ModalRoute.withName(AppRoutes.root));
    });
  }
}