import 'package:flutter/material.dart';
import 'package:micro_app_home/app/pages/home/widgets/tile_card.dart';

import 'package:micro_core/micro_core.dart';

import '../../blocs/card_list/bloc.dart';
import 'widgets/bottom_navigation_bar_custom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = CoreBinding.get<CardListBloc>();

  @override
  void initState() {
    super.initState();
    bloc.getCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigationBarCustom(),
      appBar: UolletiAppBar(
        logo: UolletiImageLogo.simpleLogo,
        profile: UolletiImageProfile.profile,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BlocConsumer<CardListBloc, CardListState>(
          bloc: bloc,
          listener: (context, state) {

          },
          builder: (context, state) {
            if(state.status == CardListStatus.loading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.separated(itemBuilder: (ctx,index){
                    final card = state.cards[index];
                    return TileCard(
                          title: card.name,
                          subtitle: "PIX",
                          description: card.receiverAccount.data.keyAccountPix,
                          onEdit: () async {
                             final create = await CoreNavigator.pushNamed(
                                "${AppRoutes.accountBank.newCardAccountBank}?${StringUtils.id}=${card.id}",
                                );
                              if(create == true){
                                bloc.getCards();
                              }
                          },
                          onPay: () {
                            CoreNavigator.pushNamed(
                                "${AppRoutes.transactions.reviewNewRecharge}?${StringUtils.id}=${card.id}",
                                );

                          });
                  }, separatorBuilder: (ctx,index) => const SizedBox(height: 5,), 
                  itemCount: state.cards.length);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
         final result =  await CoreNavigator.pushNamed(AppRoutes.accountBank.newCardAccountBank);
         if(result == true){
           bloc.getCards();
         }

        },
        backgroundColor: colorsDS.primary900,
        child: const Icon(Icons.add),
      ),
    );
  }
}
