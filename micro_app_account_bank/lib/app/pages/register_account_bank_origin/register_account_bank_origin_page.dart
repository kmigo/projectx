import 'package:flutter/material.dart';
import 'package:micro_app_account_bank/app/blocs/register_account_bank_origin/bloc.dart';
import 'package:micro_app_account_bank/src/models/account_create_model.dart';
import 'package:micro_app_account_bank/src/models/account_create_origin_model.dart';
import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';

class RegisterAccountBankOriginPage extends StatefulWidget {
  const RegisterAccountBankOriginPage({super.key});

  @override
  State<RegisterAccountBankOriginPage> createState() =>
      _RegisterAccountBankOriginPageState();
}

class _RegisterAccountBankOriginPageState
    extends State<RegisterAccountBankOriginPage> {
  String? id;
  final bloc = CoreBinding.get<RegisterAccountBankOriginBloc>();
  final blocUser = CoreBinding.get<AuthenticationBloc>();
  final TextEditingController _nameBankController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _routeNumberController = TextEditingController();
  final TextEditingController _accountHolderNameController =
      TextEditingController();
  final TextEditingController _labelController = TextEditingController();
  String? checking;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    id = CorePageModal.queryParams[StringUtils.id];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(
        title: UolletiText.labelXLarge(
          id != null ? "Atualizar conta bancaria" : 'Nova conta bancária',
          color: colorsDS.textPure,
        ),
      ),
      body:
          BlocConsumer<RegisterAccountBankOriginBloc, RegisterAccountBankState>(
        listener: (ctx, state) {
          if (state.status == RegisterAccountBankStatus.error) {
            showUolletiSnackbar(
                context,
                UolletiSnackbar.bottom(
                  backgroundColor: colorsDS.iconsDanger,
                  title: UolletiText.contentMedium(
                    state.failure ??
                        'Desulpe houve algum erro, tente novamente',
                    color: colorsDS.textPure,
                  ),
                ),
                const Duration(seconds: 3));
          }
          if(state.status == RegisterAccountBankStatus.success){
            CoreNavigator.pop(true);
          }
        },
        bloc: bloc,
        builder: (context, state) {
          if (state.status == RegisterAccountBankStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: Icon(
                            Icons.account_balance_outlined,
                            color: colorsDS.iconsPure,
                            size: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        UolletiText.labelXLarge(
                          'Informe os dados da sua conta bancária',
                          color: colorsDS.primary900,
                          bold: true,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    UolletiTextInput(
                      label: 'Nome do banco',
                      hintText: 'Nome do banco',
                      validator: HelperInputValidator.required,
                      controller: _nameBankController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const UolletiText.labelLarge(
                      'Conta',
                      bold: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    UolletiDropDown(
                      items: const [
                        'DEFAULT',
                        'RECEIVER_ACCOUNT',
                        'ORIGIN_ACCOUNT'
                      ],
                      validator: HelperInputValidator.required,
                      onChanged: (value) {
                        checking = value;
                      },
                      value: checking,
                      
                      onChild: (value) => UolletiText.labelLarge(value),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    UolletiTextInput(
                      label: 'Numero da conta',
                      validator: HelperInputValidator.required,
                      controller: _accountNumberController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    UolletiTextInput(
                      label: 'Numero de rota',
                      validator: HelperInputValidator.required,
                      controller: _routeNumberController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    UolletiTextInput(
                      validator: HelperInputValidator.required,
                      label: 'Nome do titular da conta',
                      controller: _accountHolderNameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    UolletiTextInput(
                      label: 'Label',
                      validator: HelperInputValidator.required,
                      controller: _labelController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    UolletiButton.primary(
                      label: id != null ? 'Atualizar' : 'Salvar',
                      onPressed: id != null
                          ? null
                          : () {
                            if(formKey.currentState?.validate() == true){
                              bloc.create(AccountCreateModel(
                            type: 'ORIGIN_ACCOUNT',
                            data: AccountBankOriginModel(
                                bankName: _nameBankController.text,
                                account: checking!,
                                accountNumber: _accountNumberController.text,
                                routingNumber: _routeNumberController.text,
                                accountHolder:
                                    _accountHolderNameController.text,
                                label: _labelController.text),
                            name: _labelController.text,
                            userId: blocUser.state.status.user!.id));
                            }
                          },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
