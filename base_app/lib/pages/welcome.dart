import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

import 'components/access_widget.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
            child: Container(
          color: colorsDS.primary900,
          child: Column(
            children: [
              SizedBox(
                  width: ScreenSize.getWidth(context),
                  height: ScreenSize.getHeight(context) * 0.1,
                  child: Center(
                    child: Image.asset('files/logo.png'),
                  )),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('files/person-background-onboarding.png'),
                    alignment: Alignment.bottomRight,
                  )),
                ),
              ),
              const AccessContainerWidget()
            ],
          ),
        )),
      ]),
    );
  }
}
