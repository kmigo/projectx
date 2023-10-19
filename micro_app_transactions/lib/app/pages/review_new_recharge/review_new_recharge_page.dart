// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:micro_core/micro_core.dart';

import '../../../src/domain/entities/account_bank_origin.dart';
import '../../../src/domain/entities/account_bank_receiver.dart';
import '../../../src/domain/entities/card.dart';
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
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final descriptionController = TextEditingController();
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
      final value =
          realController.text.replaceAll('R\$ ', '').replaceAll(',', '.');
      double realValue = double.parse(value);
      double dolarValue = realValue / conversionRate;
      dolarController.text = "\$ ${dolarValue.toStringAsFixed(2)}";
    });

    dolarController.addListener(() {
      final value =
          dolarController.text.replaceAll('\$', '').replaceAll(' ', '');
      double dolarValue = double.parse(value);
      double realValue = dolarValue * conversionRate;
      realController.text =
          "R\$ ${realValue.toStringAsFixed(2).replaceAll('.', ',')}";
    });
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
                                    UolletiDropDown<AccountBankOriginEntity>(
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const UolletiText.labelLarge(
                                        'Conta de destino'),
                                    UolletiDropDown<AccountBankReceiverEntity>(
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    BlocBuilder<GetCurrencyBloc, GetCurrencyState>(
                                      bloc: blocGetCurrency,
                                      builder: (context, state) {
                                        if(state.status == GetCurrencyStatus.loading){
                                          return const Center(child: CircularProgressIndicator(),);
                                        }

                                        if(state.status == GetCurrencyStatus.error){
                                          return const UolletiText.captionLarge('Erro ao buscar cotação');
                                        }

                                        return Column(
                                          children: [
                                            UolletiTextInput.currency(
                                              currency: "US",
                                              label: "Envia US",
                                              validator:
                                                  HelperInputValidator.required,
                                              controller: dolarController,
                                              onChanged: (value) {},
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            UolletiTextInput.currency(
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
                            UolletiSliderButton(
                                text: 'Arraste para confirmar',
                                onTap: () {
                                  if (formValidateKey.currentState
                                          ?.validate() ==
                                      true) {}
                                })
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
