import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

class SendTransactionPage extends StatefulWidget {
  const SendTransactionPage({super.key});

  @override
  State<SendTransactionPage> createState() => _SendTransactionPageState();
}

class _SendTransactionPageState extends State<SendTransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(
        title:  UolletiText.labelLarge('Enviar',color: colorsDS.textPure,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UolletiText.labelLarge('Selecione como deseja enviar'),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    CoreNavigator.pushNamed(AppRoutes.pixTransaction.selectKeys);
                  },
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical:25),
                      decoration: BoxDecoration(
                        color: colorsDS.backgroundLight,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: colorsDS.bordersDark),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.pix,size: 150,color: colorsDS.iconsLight ,),
                          const SizedBox(height: 10,),
                           UolletiText.labelLarge('Utilize CPF/CNPJ, telefone, email ou\nchaves aleatórias', color: colorsDS.textLight, textAlign: TextAlign.center,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}