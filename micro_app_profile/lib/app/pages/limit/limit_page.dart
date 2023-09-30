
import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

import 'widgets/header.dart';
import 'widgets/info_limit.dart';
import 'widgets/limit_slider.dart';



class LimitPage extends StatefulWidget {
  const LimitPage({super.key});

  @override
  State<LimitPage> createState() => _LimitPageState();
}

class _LimitPageState extends State<LimitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(
        elevation: 0,
        title:  UolletiText.labelXLarge('Limites', bold: true,color: colorsDS.textPure,),
        centerTitle: true,
      ),
      body: Column(
        children:  [
           const HeaderLimitWidget(),
           const SizedBox(height: 20,),
           const Padding(
             padding: EdgeInsets.all(18.0),
             child: LimitSliderWidget(valueTotal: 400.0, valueUsed: 70),
           ),
            const SizedBox(height: 20,),
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: InfoLimit(valueTotal: 400, valueUsed: 70),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                UolletiButton.primary(label: 'Voltar',onPressed: (){},)
              ],
            ),
          )

        ],
      ),
    );
  }
}