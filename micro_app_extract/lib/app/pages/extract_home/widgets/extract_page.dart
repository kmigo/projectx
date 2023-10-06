// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors_in_immutables, unused_element

import 'package:flutter/material.dart';
import 'package:micro_commons_user/micro_commons_user.dart';


import 'package:micro_core/micro_core.dart';
import '../../../blocs/extract/bloc.dart';
import 'extract_header.dart';
import 'style_transaction.dart';


class ExtractPage extends StatefulWidget {
  const ExtractPage({super.key});

  @override
  State<ExtractPage> createState() => _ExtractPageState();
}

class _ExtractPageState extends State<ExtractPage> {
  final ExtractBloc bloc = CoreBinding.get();
  final AuthenticationBloc authBloc = CoreBinding.get();
  @override
  void initState() {
    super.initState();
    bloc.getTransactions(authBloc.state.status.user?.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ExtractHeaderWidget(),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: BlocConsumer<ExtractBloc, ExtractState>(
            listener: (ctx, state) {
              if (state.status == ExtractStatus.failure) {
                UolletiDialogs.dialogGenericState(false,context: context,onTap: (){
                  CoreNavigator.pop();
                });
              }
            },
            bloc: bloc,
            builder: (context, state) {
              if ([ExtractStatus.idle, ExtractStatus.loading]
                  .contains(state.status)) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.transactions.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                                radius: 20,
                                backgroundColor: colorsDS.bordersMedium,
                                child: Icon(
                                  Icons.hourglass_empty_outlined,
                                  color: colorsDS.iconsWarning,
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            const UolletiText.labelMedium(
                              'Nenhuma transação encontrada',
                              bold: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const UolletiText.contentSmall(
                                'Você ainda não enviou ou recebeu dinheiro aqui \nna sua Uóleti'),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.only(left: 18.0),
                      child: UolletiText.labelLarge(
                        'Minha uóleti',
                        bold: true,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          UolletiExtraLargeIconButton.outlined(
                              icon: Icon(Icons.savings_outlined,size:32,color: colorsDS.bordersDark,), label: 'Receber'),
                          UolletiExtraLargeIconButton.fill(
                              icon: Icon(Icons.send_outlined,size: 32,color: colorsDS.textPure,), label: 'Enviar')
                        ],
                      ),
                    )
                  ],
                );
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18.0, horizontal: 15),
                child: ListView.separated(
                  separatorBuilder: (ctx, index) => const Divider(),
                  itemCount: state.transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = state.transactions[index];
                    return StyleTransaction.fromTransaction(transaction);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
