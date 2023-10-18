import 'package:flutter/material.dart';
import 'package:micro_app_account_bank/app/blocs/get_card/bloc.dart';
import 'package:micro_app_account_bank/src/domain/entities/account_bank_origin.dart';
import 'package:micro_app_account_bank/src/domain/entities/card.dart';
import 'package:micro_core/micro_core.dart';

import '../../../src/domain/entities/account_bank_receiver.dart';
import '../../blocs/list_accounts_bank/bloc.dart';

class NewRechargePage extends StatefulWidget {
  const NewRechargePage({super.key});

  @override
  State<NewRechargePage> createState() => _NewRechargePageState();
}

class _NewRechargePageState extends State<NewRechargePage> {
  final bloc = CoreBinding.get<ListAccountsBankBloc>();
  final blocGetCard = CoreBinding.get<GetCardBloc>();
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final descriptionController = TextEditingController();
  double conversionRate = 5.0; // Taxa de conversão fictícia, atualize conforme necessário

  String? id;
  @override
  void initState() {
    super.initState();
    bloc.getAllAccountsBank();
    id = CorePageModal.queryParams[StringUtils.id];
    if(id!=null){
      blocGetCard.getCardById(id!);
    }
    realController.addListener(() {
      final value = realController.text.replaceAll('R\$ ','').replaceAll(',','.');
      double realValue = double.parse(value);
      double dolarValue = realValue / conversionRate;
      dolarController.text = dolarValue.toStringAsFixed(2);
    });

    dolarController.addListener(() {
       final value = realController.text.replaceAll('\$','');
      double dolarValue = double.parse(value);
      double realValue = dolarValue * conversionRate;
      realController.text = realValue.toStringAsFixed(2);
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
          listener: (context, state) {
            // TODO: implement listener
          },
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
                if(stateGetCard.status == GetCardStatus.loading){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const UolletiText.labelXLarge('Nova Recarga'),
                            const SizedBox(
                              height: 20,
                            ),
                            const UolletiText.labelLarge('Conta de origem'),
                            UolletiDropDown<AccountBankOriginEntity>(
                                value: stateGetCard.card?.originAccountEntity.data != null ? AccountBankOriginDTO.fromMap(stateGetCard.card!.originAccountEntity.data.toMap()..['id']=stateGetCard.card!.originAccountEntity.id) : null,
                                items: origins,
                                onChanged: (value) {},
                                onChild: (value) =>
                                    UolletiText.labelLarge(value.bankName)),
                            const SizedBox(
                              height: 20,
                            ),
                            const UolletiText.labelLarge('Conta de destino'),
                            UolletiDropDown<AccountBankReceiverEntity>(
                                value:   stateGetCard.card?.originAccountEntity.data != null ? AccountBankReceiverDTO.fromMap(stateGetCard.card!.receiverAccount.data.toMap()..['id']=stateGetCard.card!.receiverAccount.id) : null,
                                items: receivers,
                                onChanged: (value) {},
                                onChild: (value) =>
                                    UolletiText.labelLarge(value.tagName )),
                            const SizedBox(
                              height: 20,
                            ),
                            UolletiTextInput.currency(
                              currency: "US",
                              label: "Envia US",
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
                              onChanged: (value) {},
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
                        text: 'Arraste para confirmar', onTap: () {
                          if(id !=null){

                          }else{
                            
                          }
                        })
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
