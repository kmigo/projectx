// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

import '../../blocs/list_accounts_bank/bloc.dart';

class SelectedsAccounts {
  final String? originId;
  final String? receiverId;
  const SelectedsAccounts({ this.originId,  this.receiverId});

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

class NewCardAccountsBankPage extends StatefulWidget {
  const NewCardAccountsBankPage({super.key});

  @override
  State<NewCardAccountsBankPage> createState() =>
      _NewCardAccountsBankPageState();
}

class _NewCardAccountsBankPageState extends State<NewCardAccountsBankPage> {
  final bloc = CoreBinding.get<ListAccountsBankBloc>();

  @override
  void initState() {
    super.initState();
    bloc.getAllAccountsBank();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(
        title: UolletiText.labelXLarge(
          'Novo Card',
          color: colorsDS.textPure,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BlocConsumer<ListAccountsBankBloc, ListAccountBankState>(
          bloc: bloc,
          listener: (context, state) {
          },
          builder: (context, state) {
            if(state.status == ListAccountsBankStatus.loading){
              return const Center(child: CircularProgressIndicator(),);
            }
            final receivers = state.receivers;
            final origins = state.origins;
            return FormField<SelectedsAccounts>(
              initialValue: const SelectedsAccounts(),
              builder: (stateFormField) {
                return Column(
                  children: [
                    const UolletiText.labelXLarge(
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
                    const UolletiText.labelLarge(
                      'Conta de origem',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(child: ListView.separated(itemBuilder: (_,index) =>
                     _TileCard.origin(onTap: (){
                        stateFormField.didChange(stateFormField.value!.copyWith(originId: origins[index].id));
                     }, title: origins[index].bankName, subtitle:origins[index].label,isSelected: stateFormField.value?.originId == origins[index].id, ),
                     itemCount: origins.length,
                      separatorBuilder: (_,index) => const SizedBox(height: 5,),
                      )),
                     const SizedBox(
                      height: 20,
                    ),
                    const UolletiText.labelLarge(
                      'Conta de origem',

                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     Expanded(child: ListView.separated(itemBuilder: (_,index) =>
                     _TileCard.origin(onTap: (){
                        stateFormField.didChange(stateFormField.value!.copyWith(receiverId: receivers[index].id));
                     }, title: receivers[index].tagName, subtitle:receivers[index].beneficiaryName ,isSelected: stateFormField.value?.receiverId == receivers[index].id,),
                     itemCount: receivers.length,
                      separatorBuilder: (_,index) => const SizedBox(height: 5,),
                      )),
                    const SizedBox(
                      height: 20,
                    ),
                    UolletiButton.primary(label: 'Criar card', onPressed: (){
                      CoreNavigator.pushNamed(AppRoutes.accountBank.newRecharge);
                    }),
                  ],
                );
              }
            );
          },
        ),
      ),
    );
  }
}


class _TileCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool? isSelected;
  const _TileCard(
      {required this.icon,
      required this.onTap,
      required this.title,
      required this.subtitle,
      this.isSelected
      });
  const _TileCard.receiver(
      {required this.onTap, required this.title, required this.subtitle,this.isSelected})
      : icon = Icons.pix;
  const _TileCard.origin(
      {required this.onTap, required this.title, required this.subtitle,this.isSelected})
      : icon = Icons.account_balance_outlined;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
          width: double.infinity,
          padding:  const EdgeInsets.all( 10),
          decoration: BoxDecoration(
            
            color: isSelected == true? colorsDS.backgroundMedium :  colorsDS.backgroundLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: colorsDS.bordersDark),
          ),
          child: Row(
            children: [
              Icon(icon, color:  isSelected ==true ? colorsDS.textPure  :  colorsDS.backgroundMedium ,),
              const SizedBox(
                height: 10,
              ),Expanded(child: Column(
                children: [
                  UolletiText.labelLarge(title,bold: true,color: isSelected ==true ? colorsDS.textPure  :  colorsDS.backgroundMedium , ),
                  UolletiText.labelSmall(subtitle, color: isSelected ==true ? colorsDS.textPure  :  colorsDS.backgroundMedium ,),
                ],
              ))

            ],
          ),
        ),
      ),
    );
  }
}
