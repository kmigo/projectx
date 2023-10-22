// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:micro_app_transactions/src/models/currency.dart';

import 'package:micro_core/micro_core.dart';

import '../../../src/domain/entities/account_bank_origin.dart';
import '../../../src/domain/entities/account_bank_receiver.dart';
import '../../../src/domain/entities/card.dart';
import '../../../src/models/transaction_send.dart';
import '../../blocs/create_transaction/bloc.dart';
import '../../blocs/get_card/bloc.dart';
import '../../blocs/get_currency/bloc.dart';
import '../../blocs/list_accounts_bank/bloc.dart';

class NewRechargeSelect {
  final OriginAccountEntity? _origin;
  final ReceiverAccountEntity? _receiver;
  NewRechargeSelect(this._origin, this._receiver);
  AccountBankReceiverEntity? get receiver {
    return _receiver != null
        ? AccountBankReceiverDTO.fromMap(_receiver!.toMap())
        : null;
  }

  AccountBankOriginEntity? get origin {
    return _origin != null
        ? AccountBankOriginDTO.fromMap(_origin!.toMap())
        : null;
  }

  NewRechargeSelect copyWith({
    AccountBankOriginEntity? origin,
    AccountBankReceiverEntity? receiver,
  }) {
    return NewRechargeSelect(
      _origin?.copyWith(data: origin),
      _receiver?.copyWith(data: receiver),
    );
  }
}

class ReviewNewRechargePage extends StatefulWidget {
  const ReviewNewRechargePage({super.key});

  @override
  State<ReviewNewRechargePage> createState() => _ReviewNewRechargePageState();
}

class _ReviewNewRechargePageState extends State<ReviewNewRechargePage> {
  final bloc = CoreBinding.get<ListAccountsBankBloc>();
  final blocGetCard = CoreBinding.get<GetCardBloc>();
  final blocGetCurrency = CoreBinding.get<GetCurrencyBloc>();
  final blocCreateTransaction = CoreBinding.get<CreateTransactionBloc>();
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final descriptionController = TextEditingController();
  final focusDolar = FocusNode();
  final focusReal = FocusNode();
  double conversionRate =
      5.0; // Taxa de conversão fictícia, atualize conforme necessário
  final formKey = GlobalKey<FormFieldState<NewRechargeSelect>>();
  final formValidateKey = GlobalKey<FormState>();
  String? id;
  @override
  void initState() {
    super.initState();
    bloc.getAllAccountsBank();
    id = CorePageModal.queryParams[StringUtils.id];
    if (id != null) {
      blocGetCard.getCardById(id!);
    }
    realController.addListener(() {
      if(focusDolar.hasFocus){
        return;
      }
      final value =
          realController.text.replaceAll('R\$ ', '').replaceAll(',', '.');
      double realValue = double.parse(value);
      double dolarValue =
          realValue / blocGetCurrency.state.currency!.value.toDouble();
      dolarController.text = "\$ ${dolarValue.toStringAsFixed(2)}";
    });

    dolarController.addListener(() {
      if(focusReal.hasFocus){
        return;
      }
      final value =
          dolarController.text.replaceAll('\$', '').replaceAll(' ', '');
      double dolarValue = double.parse(value);
      double realValue =
          dolarValue * blocGetCurrency.state.currency!.value.toDouble();
      realController.text =
          "R\$ ${realValue.toStringAsFixed(2).replaceAll('.', ',')}";
    });

    blocGetCurrency.getCurrency(
        const CurrencyModel(currencyIn: 'USD', currencyOut: "BRL"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(
        title: UolletiText.labelXLarge(
          'Revisar recarga',
          color: colorsDS.textPure,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BlocConsumer<ListAccountsBankBloc, ListAccountBankState>(
          bloc: bloc,
          listener: (context, state) {},
          builder: (context, state) {
            if (state.status == ListAccountsBankStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final receivers = state.receivers;
            final origins = state.origins;

            return BlocBuilder<GetCardBloc, GetCardState>(
              bloc: blocGetCard,
              builder: (context, stateGetCard) {
                if (stateGetCard.status == GetCardStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return FormField<NewRechargeSelect>(
                    key: formKey,
                    initialValue: NewRechargeSelect(
                        stateGetCard.card?.originAccountEntity,
                        stateGetCard.card?.receiverAccount),
                    builder: (stateForm) {
                      return Form(
                        key: formValidateKey,
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const UolletiText.labelXLarge(
                                        'Nova Recarga'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const UolletiText.labelLarge(
                                        'Conta de origem'),
                                    IgnorePointer(
                                      ignoring: true,
                                      child: UolletiDropDown<AccountBankOriginEntity>(
                                          value: stateForm.value?.origin,
                                          items: origins,
                                          validator: (e) {
                                            return HelperInputValidator.required(
                                                e?.id);
                                          },
                                          onChanged: (value) {
                                            stateForm.didChange(stateForm.value
                                                ?.copyWith(origin: value));
                                          },
                                          onChild: (value) =>
                                              UolletiText.labelLarge(
                                                  value.bankName)),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const UolletiText.labelLarge(
                                        'Conta de destino'),
                                    IgnorePointer(
                                      ignoring: true,
                                      child: UolletiDropDown<AccountBankReceiverEntity>(
                                          value: stateGetCard
                                                      .card
                                                      ?.originAccountEntity
                                                      .data !=
                                                  null
                                              ? AccountBankReceiverDTO.fromMap(
                                                  stateGetCard.card!.receiverAccount.data
                                                      .toMap()
                                                    ..['id'] = stateGetCard
                                                        .card!.receiverAccount.id)
                                              : null,
                                          items: receivers,
                                          validator: (e) =>
                                              HelperInputValidator.required(
                                                  e?.id),
                                          onChanged: (value) {
                                            stateForm.didChange(stateForm.value
                                                ?.copyWith(receiver: value));
                                          },
                                          onChild: (value) =>
                                              UolletiText.labelLarge(value.tagName)),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    BlocBuilder<GetCurrencyBloc,
                                        GetCurrencyState>(
                                      bloc: blocGetCurrency,
                                      builder: (context, state) {
                                        if (state.status ==
                                            GetCurrencyStatus.loading) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }

                                        if (state.status ==
                                            GetCurrencyStatus.error) {
                                          return const UolletiText.captionLarge(
                                              'Erro ao buscar cotação');
                                        }

                                        return Column(
                                          children: [
                                            UolletiTextInput.currency(
                                              currency: "US",
                                              label: "Envia US",
                                              focusNode: focusDolar,
                                              validator:
                                                  HelperInputValidator.required,
                                              controller: dolarController,
                                              onChanged: (value) {},
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            UolletiTextInput.currency(
                                              focusNode: focusReal,
                                              currency: "R\$",
                                              label: "RECEBE BRL",
                                              controller: realController,
                                              validator:
                                                  HelperInputValidator.required,
                                              onChanged: (value) {},
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    UolletiTextInput(
                                      label: 'Descrição',
                                      controller: descriptionController,
                                      maxLines: 3,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            BlocConsumer<CreateTransactionBloc, CreateTransactionState>(
                              bloc: blocCreateTransaction,
                              listener: (ctx,state){
                                if(state.status == CreateTransactionStatus.success){
                                  CoreNavigator.pushNamedAndRemoveUntil(AppRoutes.transactions.success, ModalRoute.withName(AppRoutes.home.root));
                                }
                                if(state.status == CreateTransactionStatus.error){
                                  UolletiDialogs.dialogShowGeneric(UolletiSnackbar.bottom(backgroundColor: colorsDS.iconsDanger, title: UolletiText.labelLarge(state.failure!.message!)));
                                }
                              },
                              builder: (context, state) {
                                if(state.status == CreateTransactionStatus.loading){
                                  return const Center(child: CircularProgressIndicator(),);
                                }
                                return UolletiSliderButton(
                                    text: 'Arraste para confirmar',
                                    onTap: () {
                                      if (formValidateKey.currentState
                                              ?.validate() ==
                                          true) {
                                            blocCreateTransaction.createTransaction(
                                              TransactionSend(
                                                cardId: blocGetCard.state.card!.id,
                                                amount: double.parse(dolarController.text.replaceAll('\$', '').replaceAll(' ', '')),
                                                description: descriptionController.text,
                                                quotation: blocGetCurrency.state.currency!.value,
                                              )
                                            );
                                          }
                                    });
                              },
                            )
                          ],
                        ),
                      );
                    });
              },
            );
          },
        ),
      ),
    );
  }
}
