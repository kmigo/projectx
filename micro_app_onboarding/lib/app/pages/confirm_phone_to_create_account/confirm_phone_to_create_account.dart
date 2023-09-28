import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

import '../../bloc/confirm_phone_to_create_account_bloc/bloc.dart';
part 'components/send_phone_number.dart';
part 'components/confirm_phone_sms_code.dart';

class ConfirmPhoneToCreatedAccount extends StatefulWidget {
  const ConfirmPhoneToCreatedAccount({super.key});

  @override
  State<ConfirmPhoneToCreatedAccount> createState() =>
      _ConfirmPhoneToCreatedAccount();
}

class _ConfirmPhoneToCreatedAccount
    extends State<ConfirmPhoneToCreatedAccount> {
  final bloc = CoreBinding.get<ConfirmPhoneToCreateAccountBloc>();
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
      body: BlocConsumer<ConfirmPhoneToCreateAccountBloc,
          ConfirmPhoneToCreateAccountState>(
        bloc: bloc,
        listener: (context, state) {
          if (state.status == ConfirmPhoneToCreateAccountStatus.confirmed) {
            //CoreNavigator.pushReplacementNamed(routeName);
          }
        },
        builder: (context, state) {

          if (state.verificationId != null) {
            return ConfirmPhoneSmsCodeComponent(
              smsCode: state.smsCode,
              error: state.status == ConfirmPhoneToCreateAccountStatus.error,
              onContinue: bloc.confirmPhone,
              errorText: state.error,
              isLoading: state.status == ConfirmPhoneToCreateAccountStatus.loading,
              onChanged: (value) {
                bloc.changeSmsCode(value);
              },
            );
          }

          return SendPhoneNumberComponent(
            errorText: state.error,
            isLoading:
                state.status == ConfirmPhoneToCreateAccountStatus.loading,
            phoneChoice: state.phoneItemConfigModel,
            onChanged: (value) {
              bloc.changePhoneChoice(value);
            },
            phoneController: phoneController,

            phoneCountryAvaibles: phones,
            onContinue: () => bloc.verifyPhoneSend(phoneController.text),
          );
        },
      ),
    );
  }
}
