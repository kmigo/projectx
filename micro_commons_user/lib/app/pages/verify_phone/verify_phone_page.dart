

import 'package:flutter/material.dart';

import 'package:micro_core/micro_core.dart';

import '../../blocs/verify_phone/bloc.dart';


part 'components/phone_number.dart';
part 'components/sms_code.dart';


class VerifyPhonePage extends StatefulWidget {
  final Function(String) onContinue;
  final bool verifyToCreate;
  final bool verifyToLogin;
  final Widget? child;
  final bool updatePhone;
  const VerifyPhonePage({super.key,required this.updatePhone,required this.onContinue,required this.verifyToCreate, required this.verifyToLogin, this.child});

  @override
  State<VerifyPhonePage> createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  final bloc = CoreBinding.get<VerifyPhoneBloc>();
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
      body: BlocConsumer<VerifyPhoneBloc, LoginPhoneState>(
        bloc: bloc,
        listener: (context, state) {
          if(state.status == LoginPhoneStatus.confirmed){

              widget.onContinue.call(state.getPhoneFormated());
            }

        },
        builder: (context, state) {
          if(state.status == LoginPhoneStatus.confirmed){
            if(widget.child != null){
              return widget.child!;
            }
            return const Center(
              child: Material(child: UolletiText.labelXLarge('Aguarde você será redirecionado',bold: true,)),
            );
          }

          if(state.verificationId != null){
            return ConfirmPhoneSmsCodeComponent(
              isLoading: state.status == LoginPhoneStatus.loading,
              error: false,
              onChanged: (value) {
                bloc.changeSmsCode(value);
              },
              smsCode: state.smsCode,
              onContinue: () => bloc.confirmPhone(widget.updatePhone),
            );
          }
          
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
                  onContinue: () => bloc.verifyPhoneSend(phoneController.text,verifyToLogin: widget.verifyToLogin,veryToCreateAccount: widget.verifyToCreate),
                );
        },
      )
      );
  }
}