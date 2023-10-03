import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

class SelectKeysPage extends StatefulWidget {
  const SelectKeysPage({super.key});

  @override
  State<SelectKeysPage> createState() => _SelectKeysPageState();
}

class _SelectKeysPageState extends State<SelectKeysPage> {
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
        padding: const EdgeInsets.all(18.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CircleAvatar(
            backgroundColor: colorsDS.backgroundMedium,
            radius: 50,
            child: Icon(
              Icons.pix,
              color: colorsDS.backgroundPure,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          UolletiText.labelXLarge(
            "Para quem você quer enviar?",
            color: colorsDS.textPure,
          ),
          const SizedBox(
            height: 20,
          ),
          UolletiRichText.contentMedium(
            'Selecione um tipo de <b>chave PIX</b> para enviar',
            color: colorsDS.textLight,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                   UolletiButtonsOutlinedIcons(
                    icon: Icons.qr_code,
                    title: "CPF ou CNPJ",
                    subtitle: "Ex: ###.###.###-##",
                    onTap: (){
                      
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   UolletiButtonsOutlinedIcons(
                    icon: Icons.qr_code,
                    title: "Telefone",
                    subtitle: "Ex: (##) #####-####",
                     onTap: (){},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   UolletiButtonsOutlinedIcons(
                    icon: Icons.qr_code,
                    title: "Email",
                    subtitle: "Ex: example@exmaple.com",
                     onTap: (){},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   UolletiButtonsOutlinedIcons(
                    icon: Icons.qr_code,
                    title: "Chave aleatória",
                    subtitle: "Ex: 12sd34sd5sdf67sdf8sd9sfd0",
                     onTap: (){},
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
