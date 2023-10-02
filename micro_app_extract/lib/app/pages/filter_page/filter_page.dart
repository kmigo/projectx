
import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

import '../../../src/domain/entities/transactions.dart';
import '../../blocs/extract/bloc.dart';
import '../extract_home/widgets/style_transaction.dart';


class _TabFilter<T> extends Equatable {
  final String label;
  final bool Function(T) filter;
  const _TabFilter({required this.label, required this.filter});
  @override
  List<Object> get props => [label];
}

class _MonthFilter extends Equatable {
  final DateTime date;
  final bool Function(TransactionEntity) filter;
  const _MonthFilter({required this.date, required this.filter});
  @override
  List<Object> get props => [date];
}

class ExtractFilterPage extends StatefulWidget {
  const ExtractFilterPage({super.key});

  @override
  State<ExtractFilterPage> createState() => _ExtractFilterPageState();
}

class _ExtractFilterPageState extends State<ExtractFilterPage> {
  final ExtractBloc bloc = CoreBinding.get();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: FormField<_TabFilter<TransactionEntity>>(
                  initialValue: _TabFilter(label: 'Todas', filter: (e) => true),
                  builder: (tabState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UolletiText.labelMedium(
                          'Período',
                          color: colorsDS.textLight,
                          bold: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<ExtractBloc, ExtractState>(
                          bloc: bloc,
                          builder: (context, state) {
                            return UolletiDropDown<_MonthFilter>(
                                items: state
                                    .months()
                                    .map((e) => _MonthFilter(
                                        date: e,
                                        filter: (transaction) =>state.equalDateByTransaction(e, transaction) ))
                                    .toList(),
                                onChanged: (value) {},
                                onChild: (e) => UolletiText.labelLarge(
                                    HelperDate.getMonthYearName(e.date)));
                          }, 
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        UolletiTabBar<
                            _TabFilter<TransactionEntity>>.defaultStyle(
                          tabs: [
                            _TabFilter(label: 'Todas', filter: (e) => true),
                            _TabFilter(
                                label: 'Saidas',
                                filter: (e) =>
                                    e.action == TransactionAction.cashOut),
                            _TabFilter(
                                label: 'Entradas',
                                filter: (e) =>
                                    e.action == TransactionAction.cashIn)
                          ],
                          labelBuilder: (e) => e.label,
                          onChanged: (value) {
                            tabState.didChange(value);
                          },
                          value: tabState.value,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                            child: BlocBuilder<ExtractBloc, ExtractState>(
                          bloc: bloc,
                          builder: (context, state) {
                            if (state.status == ExtractStatus.loading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            final transaction = state.transactions
                                .where((e) => tabState.value!.filter(e))
                                .toList();
                            return ListView.separated(
                                separatorBuilder: (ctx, index) =>
                                    const Divider(),
                                itemCount: transaction.length,
                                itemBuilder: (ctx, index) {
                                  return StyleTransaction.fromTransaction(
                                      transaction[index]);
                                });
                          },
                        )),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                             UolletiExtraLargeIconButton(icon: Icon(Icons.undo,size: 32,color: colorsDS.iconsLight,), label: 'Voltar',
                            backgroundColor: colorsDS.textPure,
                            iconColor: colorsDS.iconsLight,
                            borderColor: colorsDS.bordersDark,
                            ),
                            UolletiExtraLargeIconButton(icon: Icon(Icons.find_in_page_outlined,size: 32,color: colorsDS.textPure,), label: 'Extrato completo',
                            backgroundColor: colorsDS.primary900,
                            iconColor: colorsDS.textPure,
                            borderColor: Colors.transparent
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    );
                  }),
            ),
          )
        ],
      )),
    );
  }
}
