import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

class TransactionSucessPage extends StatefulWidget {
  const TransactionSucessPage({super.key});

  @override
  State<TransactionSucessPage> createState() => _TransactionSucessPageState();
}

class _TransactionSucessPageState extends State<TransactionSucessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(
        title: UolletiText.labelLarge('Sucesso',color: colorsDS.textPure,),
      centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100,),
            const Icon(Icons.check_circle_outline,size: 100,color: Colors.green,),
            const SizedBox(height: 20,),
             UolletiText.labelXLarge('Aguardando instruções de deposito da equipe americana para conciliar',color:colorsDS.primary900,),
            const SizedBox(height: 20,),
            UolletiButton.primary(onPressed: (){
              Navigator.pop(context);
            }, label: 'Voltar',)
          ],
        ),
      ),
    );
  }
}