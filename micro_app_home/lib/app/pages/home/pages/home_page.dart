import 'package:flutter/material.dart';

import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';


import '../controllers/root_controller.dart';
import '../widgets/bottom_navigation_bar_custom.dart';
import '../widgets/header_home.dart';
import '../widgets/home_body.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RootController rootController = CoreBinding.get();

  final AuthenticationBloc _authenticationBloc = CoreBinding.get();
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBarCustom(),
        appBar: AppBar(
          title: Image.asset('files/logo.png'),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.notifications_none_outlined,
                color: Colors.white,
              ),
            )
          ],
          elevation: 0,
          backgroundColor: colorsDS.primary900,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              // TODO: adicionar micro app de profile
              //onTap: () => Modular.to.pushNamed(AppRoutes.profile),
              child: Container(
                width: 40,
                height: 40,
                decoration:  BoxDecoration(
                    shape: BoxShape.circle, color: colorsDS.primary900),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          bloc: _authenticationBloc,
          listener: (context, state) {
            
          },
          builder: (context, state) {
            return SizedBox.expand(
              child: Obx(
                () {

                  if (rootController.currentPageRoot.value == PagesRoot.home) {
                    return Column(
                      children: [
                        const  HeaderHome(),
                        SizedBox(height: ScreenSize.getHeight(context) * 0.03),
                        const Expanded(child: HomeBody()),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  }
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:  [
                      HeaderHome(),
                      // TODO: criar micro app para extrato
                      // Expanded(child: ExtractPage()),
                      ],
                  );
                },
              ),
            );
          },
        ));
  }
}
