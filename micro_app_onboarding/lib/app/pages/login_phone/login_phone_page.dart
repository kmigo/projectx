import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

import '../../bloc/login_phone/bloc.dart';
part 'components/phone_number.dart';

class LoginPhonePage extends StatefulWidget {
  const LoginPhonePage({super.key});

  @override
  State<LoginPhonePage> createState() => _LoginPhonePageState();
}

class _LoginPhonePageState extends State<LoginPhonePage> {
  final bloc = CoreBinding.get<LoginPhoneBloc>();
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
    return Scaffold(
      appBar: UolletiAppBar(),
      body: BlocConsumer<LoginPhoneBloc, LoginPhoneState>(
        bloc: bloc,
        listener: (context, state) {

        },
        builder: (context, state) {
          
          return SendPhoneNumberComponent(
                  errorText: state.error,
                  isLoading:
                      state.status == LoginPhoneStatus.loading,
                  phoneChoice: state.phoneItemConfigModel,
                  onChanged: (value) {
                    bloc.changePhoneChoice(value);
                  },
                  phoneController: phoneController,
      
                  phoneCountryAvaibles: phones,
                  onContinue: () => bloc.verifyPhoneSend(phoneController.text),
                );
        },
      )
      );
  }
}