import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

import '../../blocs/password/bloc.dart';


part 'components/validate_password.dart';
part 'components/validate_new_password.dart';

class ProfilePasswordPage extends StatefulWidget {
  const ProfilePasswordPage({super.key});

  @override
  State<ProfilePasswordPage> createState() => _ProfilePasswordPageState();
}

class _ProfilePasswordPageState extends State<ProfilePasswordPage> {
  final bloc = CoreBinding.get<PasswordBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(
        backgroundColor: colorsDS.backgroundPure,
        title: const UolletiText.labelXLarge(
          'Alterar senha',
          bold: true,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<PasswordBloc, PasswordState>(
        bloc: bloc, 
        listener: (context, state) {
          if(state.status == PasswordStatus.failure){
            showUolletiSnackbar(context, UolletiSnackbar.bottom(backgroundColor: colorsDS.iconsDanger, title: UolletiText.captionLarge(state.failure!.message!,color: colorsDS.textPure,), trailling: const SizedBox(), leading: const SizedBox()), const Duration(seconds: 3));
          }
          if(state.status == PasswordStatus.success){
            CoreNavigator.pop(true);
            UolletiDialogs.dialogGenericState(true,context: context,title: 'Senha alterada com sucesso',message: 'Você já deve usar sua nova senha para acessar o app ou efetuar transações.',onTap: (){
              CoreNavigator.pop();
            });
          }
        },
        builder: (context, state) {
          if(state.status == PasswordStatus.loading){
            return const Center(child: CircularProgressIndicator(),);
          }
          return IndexedStack(
            index: state.step,
            children: [
              ValidatePassword(onChangedPassword: (value) {
                bloc.changedState(state.copyWith(password: value));
              },
              validateDone: state.validatePassword,
              validatePassword: (){

                return state.validatePassword(state.password);
              },
              onDone: bloc.validateCurrentPassword,
              ),
              ValidateNewPassword(
                  onChangedPassword: (value) {
                    bloc.changedState(state.copyWith(newPassword: value));
                  },
                  onChangedConfirmPassword: (value) {
                    bloc.changedState(state.copyWith(confirmPassword: value));
                  },
                  validateDone: state.validatePassword,
                  validatePassword: (){

                 return state.validatePassword(state.newPassword) && state.newPassword == state.confirmPassword;
                  },
                  onDone: bloc.saveNewPassword,
                  ),

            ],
          );
        },
      ),
    );
  }

  
}
