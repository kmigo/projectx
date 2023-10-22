import 'package:flutter/material.dart';
import 'package:micro_commons_user/micro_commons_user.dart';

import 'package:micro_core/micro_core.dart';





part 'components/phone_number.dart';
part 'components/sms_code.dart';

class RegisterPhone extends StatefulWidget {
  const RegisterPhone({super.key});

  @override
  State<RegisterPhone> createState() =>
      _RegisterPhone();
}

class _RegisterPhone
    extends State<RegisterPhone> {

  final List<PhoneItemConfigModel> phones = [];
  final phoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    phones.addAll(PhoneItemsConfigModel.fromMap(
            EnvironmentVariables.getRemoteConfigMap(RemoteConfigVars.phones))
        .phones);
  }

  @override
  Widget build(BuildContext context) {
    return VerifyPhonePage(
      updatePhone: false,
      onContinue: (phone){
       CoreNavigator.pushReplacementNamed("${AppRoutes.onboarding.createPin}?phone=$phone");
    }, verifyToCreate: true, verifyToLogin: false);
  }
}
