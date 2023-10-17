import 'package:flutter/material.dart';
import 'package:micro_app_account_bank/app/blocs/list_accounts_bank/bloc.dart';
import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';


class ListAccountBankPage extends StatefulWidget {
  const ListAccountBankPage({super.key});

  @override
  State<ListAccountBankPage> createState() => _ListAccountBankPageState();
}

class _ListAccountBankPageState extends State<ListAccountBankPage> {
  final bloc = CoreBinding.get<ListAccountsBankBloc>();
  final blocAuthetication = CoreBinding.get<AuthenticationBloc>();
  @override
  void initState() {
    super.initState();
    bloc.getAllAccountsBank();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(
        title: UolletiText.labelLarge(
          'Contas bancárias',
          color: colorsDS.textPure,
        ),
      ),
      body: BlocBuilder<ListAccountsBankBloc, ListAccountBankState>(
        bloc: bloc,
        builder: (context, state) {
          if (state.status == ListAccountsBankStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
         final receivers = state.receivers;
          final origins = state.origins;

          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
           
                const SizedBox(
                  height: 20,
                ),
                // mostrar as contas de origem
                 Row(
                  children: [
                    const UolletiText.labelXLarge(
                      'Contas origem:',
                      bold: true,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: ()async {
                         final created = await CoreNavigator.pushNamed(AppRoutes.accountBank.registerBankOrigin);
                             if(created != null && created == true){
                               bloc.getAllAccountsBank();
                             }
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.add,size: 15,),
                          Icon(Icons.account_balance_wallet),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Expanded(
                    child: ListView.separated(
                        itemBuilder: (ctx, index) => _TileCard.origin(
                            onTap: () async{
                              final created = await CoreNavigator.pushNamed("${AppRoutes.accountBank.registerBankOrigin}?${StringUtils.id}=${state.origins[index].id}");
                             if(created != null && created == true){
                               bloc.getAllAccountsBank();
                             }
                            },
                            title: origins[index].bankName,
                            subtitle: origins[index].bankName),
                        separatorBuilder: (ctx, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: origins.length)),
                        const SizedBox(
                  height: 20,
                ),
                // mostrar as contas de origem
                 const SizedBox(
                  height: 20,
                ),
                // mostrar as contas de origem
                 Row(
                  children: [
                     const UolletiText.labelXLarge(
                      'Contas destino:',
                      bold: true,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () async{
                         final created = await CoreNavigator.pushNamed(AppRoutes.accountBank.registerBankReceiver);
                             if(created != null && created == true){
                               bloc.getAllAccountsBank();
                             }

                      },
                      child: const Row(
                        children: [
                          Icon(Icons.add,size: 15,),
                          Icon(Icons.pix),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                // mostrar as contas de destino
                Expanded(
                    child: ListView.separated(
                        itemBuilder: (ctx, index) => _TileCard.origin(
                            onTap: () async {
                             final update = await CoreNavigator.pushNamed("${AppRoutes.accountBank.registerBankReceiver}?${StringUtils.id}=${state.receivers[index].id}}");
                             if(update != null && update == true){
                               bloc.getAllAccountsBank();
                             }
                            },
                            title: receivers[index].tagName,
                            subtitle: receivers[index].keyAccountPix),
                        separatorBuilder: (ctx, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: receivers.length)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TileCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  const _TileCard(
      {required this.icon,
      required this.onTap,
      required this.title,
      required this.subtitle});
  // ignore: unused_element
  const _TileCard.receiver(
      {required this.onTap, required this.title, required this.subtitle})
      : icon = Icons.pix;
  const _TileCard.origin(
      {required this.onTap, required this.title, required this.subtitle})
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
            color: colorsDS.backgroundLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: colorsDS.bordersDark),
          ),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(
                height: 10,
              ),Expanded(child: Column(
                children: [
                  UolletiText.labelLarge(title,bold: true,),
                  UolletiText.labelSmall(subtitle),
                ],
              ))

            ],
          ),
        ),
      ),
    );
  }
}
