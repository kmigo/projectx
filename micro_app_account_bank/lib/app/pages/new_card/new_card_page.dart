// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_element
import 'package:flutter/material.dart';
import 'package:micro_app_account_bank/app/pages/new_card/dialogs/name_card.dart';
import 'package:micro_app_account_bank/src/models/card.dart';
import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';

import '../../blocs/get_card/bloc.dart';
import '../../blocs/list_accounts_bank/bloc.dart';
part 'components/tile_card.dart';

class SelectedsAccounts {
  final String? originId;
  final String? receiverId;
  const SelectedsAccounts({this.originId, this.receiverId});

  SelectedsAccounts copyWith({
    String? originId,
    String? receiverId,
  }) {
    return SelectedsAccounts(
      originId: originId ?? this.originId,
      receiverId: receiverId ?? this.receiverId,
    );
  }
}

class NewCardPage extends StatefulWidget {
  const NewCardPage({super.key});

  @override
  State<NewCardPage> createState() => _NewCardPageState();
}

class _NewCardPageState extends State<NewCardPage> {
  final bloc = CoreBinding.get<ListAccountsBankBloc>();
  final blocUser = CoreBinding.get<AuthenticationBloc>();
  final blocGetCard = CoreBinding.get<GetCardBloc>();

  final _formKeySelected = GlobalKey<FormFieldState<SelectedsAccounts>>();
  String? id;
  @override
  void initState() {
    super.initState();
   
    id = CorePageModal.queryParams[StringUtils.id];
     bloc.getAllAccountsBank().then((value) {
       if (id != null) {
      blocGetCard.getCardById(id!);
    }
     });
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(
        title: UolletiText.labelXLarge(
          id != null ? "Atualizar Card" :'Novo Card',
          color: colorsDS.textPure,
        ),
        centerTitle: true,
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
            return FormField<SelectedsAccounts>(
                initialValue: const SelectedsAccounts(),
                key: _formKeySelected,
                builder: (stateFormField) {
                  return BlocConsumer<GetCardBloc, GetCardState>(
                    bloc: blocGetCard,
                    listener: (context, stateGetCard) {
                      if (stateGetCard.status == GetCardStatus.updated) {
                        CoreNavigator.pop(true);
                        showUolletiSnackbar(context, UolletiSnackbar.bottomSuccess(message: 'Card atualizado!!!'), const Duration(seconds: 4));
                      }
                      if(stateGetCard.status == GetCardStatus.error){
                        showUolletiSnackbar(context, UolletiSnackbar.bottomError(message: 'Erro ao atualizar card!!!'), const Duration(seconds: 4));
                      }
                      if(stateGetCard.status == GetCardStatus.success){
                        stateFormField.didChange(SelectedsAccounts(originId: stateGetCard.card?.originAccountEntity.id,receiverId: stateGetCard.card?.receiverAccount.id));
                      }
                    },
                    builder: (context, stateGetCard) {
                      if(stateGetCard.status == GetCardStatus.loading){
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Column(
                        children: [
                         if(id == null)  UolletiText.labelXLarge(
                            'Crie um novo card para realizar pagamentos',
                            bold: true,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          UolletiText.labelMedium(
                            'Informe uma conta de origem e uma de destino para deixar pré defino um card de pagamento',
                            color: colorsDS.textLight,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const UolletiText.labelXLarge(
                                'Contas de origem:',
                                bold: true,
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () async {
                                  final created = await CoreNavigator.pushNamed(
                                      AppRoutes.accountBank.registerBankOrigin);
                                  if (created != null && created == true) {
                                    bloc.getAllAccountsBank();
                                  }
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      size: 15,
                                    ),
                                    Icon(Icons.account_balance_outlined),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                              child: ListView.separated(
                            itemBuilder: (_, index) => _TileCard.origin(
                              onEdit: ()async{
                                final created = await CoreNavigator.pushNamed(
                                      "${AppRoutes.accountBank.registerBankOrigin}?${StringUtils.id}=${origins[index].id}");
                                  if (created != null && created == true) {
                                    bloc.getAllAccountsBank();
                                  }
                              },
                              onTap: () {
                                stateFormField.didChange(stateFormField.value!
                                    .copyWith(originId: origins[index].id));
                              },
                              title: origins[index].bankName,
                              subtitle: origins[index].label,
                              isSelected: stateFormField.value?.originId ==
                                  origins[index].id,
                            ),
                            itemCount: origins.length,
                            separatorBuilder: (_, index) => const SizedBox(
                              height: 5,
                            ),
                          )),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const UolletiText.labelXLarge(
                                'Contas destino:',
                                bold: true,
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () async {
                                  final created = await CoreNavigator.pushNamed(
                                      AppRoutes
                                          .accountBank.registerBankReceiver);
                                  if (created != null && created == true) {
                                    bloc.getAllAccountsBank();
                                  }
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      size: 15,
                                    ),
                                    Icon(Icons.pix),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                              child: ListView.separated(
                            itemBuilder: (_, index) => _TileCard.origin(
                              onEdit: () async{
                                final created = await CoreNavigator.pushNamed(
                                      "${AppRoutes.accountBank.registerBankReceiver}?${StringUtils.id}=${receivers[index].id}");
                                  if (created != null && created == true) {
                                    bloc.getAllAccountsBank();
                                  }
                              },
                              onTap: () {
                                stateFormField.didChange(stateFormField.value!
                                    .copyWith(receiverId: receivers[index].id));
                              },
                              title: receivers[index].tagName,
                              subtitle: receivers[index].beneficiaryName,
                              isSelected: stateFormField.value?.receiverId ==
                                  receivers[index].id,
                            ),
                            itemCount: receivers.length,
                            separatorBuilder: (_, index) => const SizedBox(
                              height: 5,
                            ),
                          )),
                          const SizedBox(
                            height: 20,
                          ),
                          UolletiButton.primary(
                              label: id != null ? "Atualizar" : 'Criar card',
                              onPressed: () async {
                                if (stateFormField.value?.originId != null &&
                                    stateFormField.value?.receiverId != null ) {
                                  final result =
                                      await UolletiDialogs.dialogShowGeneric(
                                          NameCardDialog(
                                            updated: id != null,
                                            nameCard: stateGetCard.card?.name ,
                                            onUpdated: (name) {
                                              CoreNavigator.pop();
                                              final selected = stateFormField.value!;
                                              if(selected.originId == null || selected.receiverId == null){
                                                return;
                                              }
                                              blocGetCard.updateCard(CardModel(originAccountId: selected.originId!, receiverAccountId: selected.receiverId!, name: name, userId: blocUser.state.status.user?.id ?? ''), id!);

                                            },
                                              originAcountId:
                                                  stateFormField
                                                          .value?.originId ??
                                                      '',
                                              receiverAcountId: stateFormField
                                                      .value?.receiverId ??
                                                  '',
                                              userId: blocUser
                                                      .state.status.user?.id ??
                                                  ''),
                                          barrierDismissible: false);
                                  if (result == true) {
                                    CoreNavigator.pop(true);
                                  }
                                  return;
                                }
                              }),
                        ],
                      );
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}
