

import 'package:flutter/material.dart';
import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';

import '../../blocs/phone_number/bloc.dart';

part 'components/send_sms_to_phone_number.dart';
part 'components/validate_sms_code.dart';
class PersonalPhonePage extends StatefulWidget {
  const PersonalPhonePage({super.key});

  @override
  State<PersonalPhonePage> createState() => _PersonalPhonePageState();
}

class _PersonalPhonePageState extends State<PersonalPhonePage> {
  final bloc = CoreBinding.get<PhoneNumberBloc>();
  @override
  Widget build(BuildContext context) {
    return VerifyPhonePage(updatePhone: true, onContinue: (phone){
      print('phone atualizado $phone');
    }, verifyToCreate: true, verifyToLogin: false);
  }
}
