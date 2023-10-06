import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';


import '../../blocs/create_pincode/bloc.dart';

class CreatePincodePage extends StatefulWidget {
  final String? phone;
  final Widget? child;
  final VoidCallback? onContinue;
  const CreatePincodePage({super.key, this.phone,this.onContinue,this.child});

  @override
  State<CreatePincodePage> createState() => _CreatePincodePageState();
}

class _CreatePincodePageState extends State<CreatePincodePage> {
  final bloc = CoreBinding.get<CreatePinCodeBloc>();
  String? phone;
  @override
  void initState() {
    super.initState();
    phone = CorePageModal.queryParams['phone'] ?? widget.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(),
      body: Padding(
        padding: EdgeInsets.all(ScreenSize.getHeight(context) * 0.05),
        child: BlocConsumer<CreatePinCodeBloc, CreatePinCodeState>(
          bloc: bloc,
          listener: (context, state) {
            if(state.status == CreatePinCodeStatus.success){
              if(widget.onContinue != null){
                widget.onContinue!.call();
                return;
              }
              CoreNavigator.pushNamedAndRemoveUntil(AppRoutes.home.root, ModalRoute.withName(AppRoutes.root));
            }
          },
          builder: (context, state) {
            if(state.status == CreatePinCodeStatus.success){
              if(widget.child != null){
                return widget.child!;
              }
              return const Center(
                child: Material(child: UolletiText.captionXLarge('Pin criado com sucesso, aguarde você será redicionado',bold: true,)),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: colorsDS.backgroundMedium,
                          child: const Icon(Icons.password),
                        ),
                        SizedBox(
                          height: ScreenSize.getHeight(context) * 0.02,
                        ),
                        const UolletiText.labelXLarge('Crie um PIN de acesso'),
                        SizedBox(
                          height: ScreenSize.getHeight(context) * 0.02,
                        ),
                        UolletiText.contentMedium(
                          'O PIN é uma senha de 6 dígitos que você usará para acessar o aplicativo.',
                          color: colorsDS.textLight,
                        ),
                        SizedBox(
                          height: ScreenSize.getHeight(context) * 0.01,
                        ),
                        UolletiCodeInput(
                            validateDone: (value) => value?.length == 6,
                            totalCodeInput: 6,
                             onDone: () => bloc.createAccount(phone!),
                            onChanged: (value) {
                              bloc.changePinCode(value);
                            }),
                        SizedBox(
                          height: ScreenSize.getHeight(context) * 0.02,
                        ),
                        if(state.error != null)...[
                          UolletiText.contentMedium(
                            state.error!,
                            color: colorsDS.textDanger,
                          ),
                          SizedBox(
                            height: ScreenSize.getHeight(context) * 0.01,
                          ),
                        ],
                        UolletiText.contentMedium(
                          'Confirme o Pin',
                          color: colorsDS.textLight,
                        ),
                        SizedBox(
                          height: ScreenSize.getHeight(context) * 0.01,
                        ),
                        UolletiCodeInput(
                            validateDone: (value) => value?.length == 6,
                            totalCodeInput: 6,
                            onDone: () => bloc.createAccount(phone!),
                            onChanged: (value) {
                              bloc.changeConfirmPinCode(value);
                            }),
                      ],
                    ),
                  ),
                ),
                UolletiButton.primary(
                  disabled: state.pinCode.length != 6 || state.confirmPinCode.length != 6,
                  label: 'Continuar', onPressed: () {
                    bloc.createAccount(phone!);
                  })
              ],
            );
          },
        ),
      ),
    );
  }
}
