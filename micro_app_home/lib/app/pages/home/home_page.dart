import 'package:flutter/material.dart';
import 'package:micro_app_home/app/pages/home/widgets/tile_card.dart';

import 'package:micro_core/micro_core.dart';



import 'widgets/bottom_navigation_bar_custom.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {

    super.initState();
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
          child: Column(
            children: [
              TileCard(
                title: "Aluguel barra",
                subtitle: "PIX",
                description: "R\$ 1.000,00",
                onEdit: (){}, onPay: (){})
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            CoreNavigator.pushNamed(AppRoutes.accountBank.newCardAccountBank);
          },
          backgroundColor: colorsDS.primary900,
          child: const Icon(Icons.add),
        ),
        );
  }
}
