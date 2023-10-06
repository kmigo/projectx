import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

import '../../blocs/validate_code/bloc.dart';

class ValidatePincodePage extends StatefulWidget {
  final String? title;
  final VoidCallback onContinue;
  final Widget? child;
  const ValidatePincodePage(
      {super.key, this.title, this.child, required this.onContinue});

  @override
  State<ValidatePincodePage> createState() => _ValidatePincodePageState();
}

class _ValidatePincodePageState extends State<ValidatePincodePage> {
  final bloc = CoreBinding.get<ValidPinCodeBloc>();
  String code = '';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ValidPinCodeBloc, ValidPinCodeState>(
      bloc: bloc,
      listener: (context, state) {
        if(ValidPinCodeStatus.success == state.status){
          widget.onContinue();
          }
      },
      builder: (context, state) {

        if(ValidPinCodeStatus.success == state.status){
          if(widget.child != null){
              return widget.child!;
          }
          return const Center(
            child: Material(child: UolletiText.labelXLarge('Aguarde você será redirecionado',bold: true,)),
          );
       
        }
        return Scaffold(
          appBar: UolletiAppBar(
            title: UolletiText.labelLarge(widget.title ?? 'Validar PINCODE',color: colorsDS.textPure,),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: colorsDS.backgroundMedium,
                    child: Icon(
                      Icons.password,
                      color: colorsDS.iconsPure,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const UolletiText.labelXLarge('Valide seu PINCODE'),
                  const SizedBox(
                    height: 20,
                  ),
                   UolletiText.contentMedium(
                      'Informe seu PINCODE para continuar',color: colorsDS.textLight,),
                  if(state.failure!= null)...[
                    const SizedBox(height: 20,),
                    UolletiText.contentMedium(
                      state.failure!.message!,color: colorsDS.iconsDanger,),
                  ],
                  const SizedBox(
                    height: 20,
                  ),
                  UolletiCodeInput(
                      totalCodeInput: 6,
                      validateDone: (value) => value!.length == 6,
                      onDone: () => bloc.validCode(code),
                      backgroundColor: state.failure != null ? colorsDS.backgroundPositive : colorsDS.bordersMedium,
                      onChanged: (value) {
                        code = value;
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
