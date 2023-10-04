import 'package:flutter/material.dart';

import 'package:micro_core/micro_core.dart';


import '../controllers/root_controller.dart';
import '../widgets/bottom_navigation_bar_custom.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RootController rootController = CoreBinding.get();

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
        body: Column());
  }
}
