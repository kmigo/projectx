import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

class ReviewNewRechargePage extends StatefulWidget {
  const ReviewNewRechargePage({super.key});

  @override
  State<ReviewNewRechargePage> createState() => _ReviewNewRechargePageState();
}

class _ReviewNewRechargePageState extends State<ReviewNewRechargePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(
        title: const UolletiText.labelXLarge('Revisar recarga'),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const UolletiText.labelXLarge('Nova Recarga'),
              const SizedBox(height: 20,),
              Container(
                height: 200,
                color: colorsDS.backgroundMedium,
              ),
              const SizedBox(height: 20,),
              const UolletiText.labelLarge('Conta de Origem'),
              UolletiDropDown(items: const ['Wells Fargo'], onChanged: (bank){}, 
              onChild: (bank) => UolletiText.labelLarge(bank)),
              const SizedBox(height: 20,),
              UolletiButton.primary(label: 'Continuar', onPressed: (){})
            ],
          ),
        ),
      ),
    );
  }
}