import 'package:flutter/material.dart';
import 'package:micro_app_account_bank/src/models/account_create_model.dart';
import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';

import '../../blocs/register_account_bank/bloc.dart';

class RegisterAccountBankPage extends StatefulWidget {
  const RegisterAccountBankPage({super.key});

  @override
  State<RegisterAccountBankPage> createState() =>
      _RegisterAccountBankPageState();
}

class _RegisterAccountBankPageState extends State<RegisterAccountBankPage> {
  String? id;
  final bloc = CoreBinding.get<RegisterAccountBankBloc>();
  final blocUser = CoreBinding.get<AuthenticationBloc>();
  final TextEditingController _nameBankController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _routeNumberController = TextEditingController();
  final TextEditingController _accountHolderNameController =
      TextEditingController();
  final TextEditingController _labelController = TextEditingController();
  String? checking;
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
      body: BlocConsumer<RegisterAccountBankBloc, RegisterAccountBankState>(
        listener: (ctx, state) {
          if (state.status == RegisterAccountBankStatus.error) {
            UolletiSnackbar.bottom(
              backgroundColor: colorsDS.iconsDanger,
              title: const UolletiText.contentMedium(
                  'Desulpe houve algum erro, tente novamente'),
            );
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
                    items: const ['Checking'],
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
                    controller: _accountNumberController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  UolletiTextInput(
                    label: 'Numero de rota',
                    controller: _routeNumberController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  UolletiTextInput(
                    label: 'Nome do titular da conta',
                    controller: _accountHolderNameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  UolletiTextInput(
                    label: 'Label',
                    controller: _labelController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  UolletiButton.primary(
                    label: id != null ? 'Atualizar' : 'Salvar',
                    onPressed: id != null
                        ? null
                        : () => bloc.create(AccountCreateModel(
                            type: 'Checking',
                            data: {},
                            name: _nameBankController.text,
                            userId: blocUser.state.status.user?.id ?? '1')),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
