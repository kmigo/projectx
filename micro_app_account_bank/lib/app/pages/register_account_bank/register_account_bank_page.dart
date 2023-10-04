import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

class RegisterAccountBankPage extends StatefulWidget {
  const RegisterAccountBankPage({super.key});

  @override
  State<RegisterAccountBankPage> createState() => _RegisterAccountBankPageState();
}

class _RegisterAccountBankPageState extends State<RegisterAccountBankPage> {
  String? id ;
  @override
  void initState() {
    super.initState();
    id = CorePageModal.queryParams[StringUtils.id];

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(
        title: UolletiText.labelXLarge(
          'Nova conta bancária',
          color: colorsDS.textPure,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}