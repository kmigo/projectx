

import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: UolletiAppBar(
        backgroundColor: colorsDS.backgroundPure,
        title: const UolletiText.labelXLarge(
          'Telefone',
          bold: true,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<PhoneNumberBloc, PhoneNumberUpdateState>(
        bloc: bloc,
        listener: (context, state) {
          if(state.status == PhoneNumberUpdateStatus.success){
            CoreNavigator.pop();
            UolletiDialogs.dialogGenericState(true, context: context, title: 'Telefone alterado com sucesso', message: 'Telefone atualizado com sucesso',onTap: (){
              CoreNavigator.pop();
            });
          }
          if(state.status == PhoneNumberUpdateStatus.failure){
            UolletiDialogs.dialogGenericState(false, context: context, message: state.failure!.message,onTap: (){
              CoreNavigator.pop();
            });
          }
        },
        builder: (context, state) {
          return IndexedStack(
            index: state.step,
            children: [
              SendSmsToPhoneNumber(
                isLoading: state.status == PhoneNumberUpdateStatus.loading,
                validatePhone: (){
                  return HelperValidator.phone(state.phoneNumber);
                },
                onChanged: (value) {
                  bloc.changedState(state.copyWith(phoneNumber: value.replaceAll(RegExp(r'\D'), '')));
                },
                onTap: bloc.validatePhoneNumber,
              ),
              ValidateSmsCode(
                isLoading: state.status == PhoneNumberUpdateStatus.loading,
                onChangedSmsCode: (value){
                bloc.changedState(state.copyWith(smsCode: value));
              }, onDone: bloc.updatePhone)
            ],
          );
        },
      ),
    );
  }
}
