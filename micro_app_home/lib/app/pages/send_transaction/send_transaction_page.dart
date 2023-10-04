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
        title: UolletiText.labelLarge(
          'Novo PIX CARD',
          color: colorsDS.textPure,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UolletiText.labelXLarge('Selecione uma ação:',bold: true,),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _TileCard(
                      icon: Icons.account_balance,
                      onTap: () {
                        CoreNavigator.pushNamed(AppRoutes.accountBank.registerBank);
                      },
                      title: 'CONTA DE ORIGEM',
                      // conta de origem
                      subtitle:
                          'cadastrar uma conta de origem para enviar PIX'),
                  const SizedBox(
                    height: 20,
                  ),
                  _TileCard(
                      icon: Icons.pix,
                      onTap: () {
                        CoreNavigator.pushReplacementNamed(AppRoutes.pixTransaction.registerPix);
                      },
                      title: 'PIX DESTINO',
                      subtitle:
                          'Cadastre uma chave PIX para enviar PIX para um contato'),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class _TileCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  const _TileCard(
      {required this.icon,
      required this.onTap,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 25),
          decoration: BoxDecoration(
            color: colorsDS.backgroundLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: colorsDS.bordersDark),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 150,
                color: colorsDS.iconsLight,
              ),
              const SizedBox(
                height: 10,
              ),
              UolletiText.labelXLarge(
                title,
                bold: true,
              ),
              const SizedBox(
                height: 10,
              ),
              UolletiText.labelLarge(
                subtitle,
                color: colorsDS.textLight,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
