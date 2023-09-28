import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

class CreatePincodePage extends StatefulWidget {
  const CreatePincodePage({super.key});

  @override
  State<CreatePincodePage> createState() => _CreatePincodePageState();
}

class _CreatePincodePageState extends State<CreatePincodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(),
      body:  Padding(
        padding: EdgeInsets.all(
          ScreenSize.getHeight(context) * 0.05
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                
              ),
            ),

            UolletiButton.primary(label: 'Continuar',onPressed: (){})
            
          ],
        ),
      ),
    );
  }
}