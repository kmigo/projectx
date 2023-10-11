import 'package:flutter/material.dart';
import 'package:micro_app_account_bank/src/models/account_create_model.dart';
import 'package:micro_app_account_bank/src/models/account_create_receiver_model.dart';
import 'package:micro_commons_user/micro_commons_user.dart';

import 'package:micro_core/micro_core.dart';

import '../../blocs/register_account_bank_receiver/bloc.dart';

class RegisterAccountBankReceiverPage extends StatefulWidget {
  const RegisterAccountBankReceiverPage({super.key});

  @override
  State<RegisterAccountBankReceiverPage> createState() =>
      _RegisterAccountBankReceiverPageState();
}

class _RegisterAccountBankReceiverPageState
    extends State<RegisterAccountBankReceiverPage> {
  String? id;
  String? method;
  String? keyPayment;
  late bool update;
  final TextEditingController _keyController = TextEditingController();
  final bloc = CoreBinding.get<RegisterAccountBankReceiverBloc>();
  final blocUser = CoreBinding.get<AuthenticationBloc>();
  final TextEditingController _cardNameController = TextEditingController();
  String _typeBeneficiarySelected = '';
  final TextEditingController _nameBeneficiaryController =
      TextEditingController();
  String typeKeySelected = '';
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    id = CorePageModal.queryParams[StringUtils.id];
    method = CorePageModal.queryParams[StringUtils.method];
    keyPayment = CorePageModal.queryParams[StringUtils.keyPayment];
    update = id?.isNotEmpty == true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(
        title: UolletiText.labelLarge(
          update ? 'Atualizar PIX CARD' : 'Novo PIX CARD',
          color: colorsDS.textPure,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<RegisterAccountBankReceiverBloc,
          RegisterAccountBankReceiverState>(
        bloc: bloc,
        listener: (context, state) {
          if (state.status == RegisterAccountBankReceiverStatus.error) {
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
          if (state.status == RegisterAccountBankReceiverStatus.success) {
            CoreNavigator.pop(true);
          }
        },
        builder: (context, state) {
            if (state.status == RegisterAccountBankReceiverStatus.loading) {
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.pix,
                          size: 30,
                          color: colorsDS.backgroundMedium,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        UolletiText.labelXLarge(
                          'Informações de contato',
                          bold: true,
                          color: colorsDS.backgroundMedium,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    UolletiTextInput(
                      label: 'Nome do cartão',
                      hintText: 'Aluguel Barra',
                      controller: _cardNameController,
                      validator: HelperInputValidator.required,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const UolletiText.labelLarge(
                      'Tipo de beneficiario',
                      bold: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    UolletiDropDown(
                      items: const ['Pessoa Júridica', 'Pessoa Fisica'],
                      validator: HelperInputValidator.required,
                      onChanged: (choice) {
                        _typeBeneficiarySelected = choice!;
                      },
                      onChild: (value) => UolletiText.labelMedium(value),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    UolletiTextInput(
                      label: 'Nome do beneficiario',
                      hintText: 'Thomas Edison',
                      controller: _nameBeneficiaryController,
                      validator: HelperInputValidator.required,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const UolletiText.labelLarge(
                      'Tipo de chave PIX',
                      bold: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: _setKey,
                      child: IgnorePointer(
                          ignoring: true,
                          child: UolletiDropDown<String>(
                            items: const [
                              'CPF',
                              'CHAVE ALEATORIA',
                              'CNPJ',
                              "TELEFONE",
                              "EMAIL"
                            ],
                            validator: HelperInputValidator.required,
                            onChanged: (choice) {
                              typeKeySelected = choice!;
                            },
                            onChild: (value) => UolletiText.labelMedium(value),
                            value: _typeKey(),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: _setKey,
                      child: IgnorePointer(
                        ignoring: true,
                        child: UolletiTextInput(
                          label: 'Chave PIX',
                          hintText: '123.456.789-10',
                          validator: HelperInputValidator.required,
                          controller: _keyController,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    UolletiButton.primary(
                        label: 'CRIAR',
                        onPressed: () async {
                          if (formKey.currentState?.validate() == false) return;
                          bloc.create(AccountCreateModel(
                              type: 'RECEIVER_ACCOUNT',
                              data: AccountBankReceiverModel(
                                tagName: _cardNameController.text,
                                typeBeneficiary: _typeBeneficiarySelected,
                                beneficiaryName:
                                    _nameBeneficiaryController.text,
                                typeKeyAccountPix: method!,
                                keyAccountPix: keyPayment!,
                              ),
                              name: _cardNameController.text,
                              userId: blocUser.state.status.user?.id ?? '1'));
                        }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _setKey() async {
    await CoreNavigator.pushNamed(AppRoutes.pixTransaction.selectKeys);
    if (CorePageModal.args != null) {
      final args = (CorePageModal.args as KeyPixTypeModel);
      setState(() {
        keyPayment = args.key;
        method = args.type;
        _keyController.text = keyPayment!;
      });
    }
  }

  String? _typeKey() {
    if (method == null) return null;
    final type = stringToEnumMethod(method!);
    switch (type) {
      case StringUtilsMethodsEnum.cpf:
        return 'CPF';
      case StringUtilsMethodsEnum.cnpj:
        return 'CNPJ';
      case StringUtilsMethodsEnum.email:
        return 'EMAIL';
      case StringUtilsMethodsEnum.phone:
        return 'TELEFONE';
      case StringUtilsMethodsEnum.random:
        return 'CHAVE ALEATORIA';
      default:
        return null;
    }
  }
}
