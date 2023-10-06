import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

class LoginPiCode extends StatefulWidget {
  const LoginPiCode({super.key});

  @override
  State<LoginPiCode> createState() => _LoginPiCodeState();
}

class _LoginPiCodeState extends State<LoginPiCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(
        title: UolletiText.labelXLarge(
          'Digite seu PIN',
          color: colorsDS.textPure,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: colorsDS.bordersMedium,
              child: const Icon(
                Icons.password,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20,),
            UolletiText.labelXLarge(
              'Digite seu PIN para acessar sua conta',
              color: colorsDS.textPure,
              bold: true,
            ),
            const SizedBox(height: 20,),
            UolletiText.contentMedium(
              'Senha de acesso',
              color: colorsDS.textLight,
            ),
            const SizedBox(height: 20,),
            UolletiCodeInput(
              totalCodeInput: 6,
              onChanged: (value){
              },
              )
          ],
        ),
      ),
    );
  }
}