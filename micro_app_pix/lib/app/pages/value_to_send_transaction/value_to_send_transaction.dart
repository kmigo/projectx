import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

class ValueToSendTransactionPage extends StatefulWidget {
  const ValueToSendTransactionPage({super.key});

  @override
  State<ValueToSendTransactionPage> createState() => _ValueToSendTransactionPageState();
}

class _ValueToSendTransactionPageState extends State<ValueToSendTransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(
        title: UolletiText.labelLarge(
          "Enviar pix",
          color: colorsDS.textPure,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}