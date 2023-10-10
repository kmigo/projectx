import 'package:flutter/material.dart';
import 'package:micro_app_account_bank/app/blocs/list_accounts_bank/bloc.dart';
import 'package:micro_app_account_bank/src/domain/entities/account_bank_receiver.dart';
import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';

import '../../../src/domain/entities/account_bank_origin.dart';

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
          'Novo PIX CARD',
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
          // filtrando as contas de origem e destino
          final receiversAccount = state.accountsBank
              .where((element) => state.isReceiverAccountBank(element))
              .toList();
          final originsAccount = state.accountsBank
              .where((element) => !state.isReceiverAccountBank(element))
              .toList();

          // convertendo para entidades
          final receivers = receiversAccount
              .map<AccountBankReceiverEntity>(
                  (e) => AccountBankReceiverDTO.fromMap(e.data))
              .toList();
          final origins = originsAccount
              .map<AccountBankOriginEntity>(
                  (e) => AccountBankOriginDTO.fromMap(e.data))
              .toList();

          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UolletiText.labelXLarge(
                  'Selecione uma ação:',
                  bold: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                // mostrar as contas de origem
                Expanded(
                    child: ListView.separated(
                        itemBuilder: (ctx, index) => _TileCard.origin(
                            onTap: () {},
                            title: origins[index].bankName,
                            subtitle: origins[index].accountNumber),
                        separatorBuilder: (ctx, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: origins.length)),
                // mostrar as contas de destino
                Expanded(
                    child: ListView.separated(
                        itemBuilder: (ctx, index) => _TileCard.origin(
                            onTap: () {},
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
          //padding: const EdgeInsets.symmetric(vertical: 25),
          decoration: BoxDecoration(
            color: colorsDS.backgroundLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: colorsDS.bordersDark),
          ),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
