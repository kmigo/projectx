import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

import '../../src/domain/entities/transactions.dart';
import '../blocs/extract/bloc.dart';
import '../pages/extract_home/widgets/style_transaction.dart';


class SearchTransactionDelegate extends SearchDelegate<String?> {
  final ExtractBloc bloc = CoreBinding.get();
  // Os itens filtrados
  List<TransactionEntity> _filteredData = [];

  // Retorna a lista de sugestões
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // limpar a busca
        },
      ),
    ];
  }

  // Retorna o ícone à esquerda na barra de pesquisa
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ''); // retornar ao estado anterior
      },
    );
  }

  // Mostra os resultados de acordo com a busca
  @override
  Widget buildResults(BuildContext context) {

    return BlocBuilder<ExtractBloc, ExtractState>(
      bloc: bloc,
      builder: (context, state) {
         if (state.status == ExtractStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (query.isEmpty) {
      _filteredData = [...bloc.state.transactions];
    } else {
      _filteredData = bloc.state.transactions
          .where((element) =>
              element.payer.name.toLowerCase().contains(query.toLowerCase()) ||
              element.receiver.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    if (_filteredData.isEmpty) {
      return isEmpty(context);
    }
        return ListView.builder(
          itemCount: _filteredData.length,
          itemBuilder: (context, index) {
            final widget =
                StyleTransaction.fromTransaction(_filteredData[index]);
            return widget;
          },
        );
      },
    );
  }

  // Mostra as sugestões de acordo com a busca
  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<ExtractBloc, ExtractState>(
      bloc: bloc,
      builder: (context, state) {
        if (state.status == ExtractStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.transactions.isEmpty) {
          return isEmpty(context);
        }
        if (query.isEmpty) {
          _filteredData = [...bloc.state.transactions];
        } else {
          _filteredData = bloc.state.transactions
              .where((element) =>
                  element.payer.name
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  element.receiver.name
                      .toLowerCase()
                      .contains(query.toLowerCase()))
              .toList();
        }
        return ListView.builder(
          itemCount: _filteredData.length,
          itemBuilder: (context, index) {
            final widget =
                StyleTransaction.fromTransaction(_filteredData[index]);
            return widget;
          },
        );
      },
    );
  }

  Widget isEmpty(context) => Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const UolletiText.contentMedium(
              'Nenhum resultado encontrado',
              priority: UolletiTextPriority.textLight,
            ),
            const Spacer(),
            UolletiButtonIcon(
                icon: const Icon(Icons.arrow_back_ios_new),
                label: 'Voltar',
                onPressed: () {
                  close(context, null);
                })
          ],
        ),
      );
}
