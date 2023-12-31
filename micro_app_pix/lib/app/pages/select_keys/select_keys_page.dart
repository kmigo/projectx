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
          "Consultar pix",
          color: colorsDS.textPure,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: colorsDS.backgroundMedium,
                radius: 30,
                child: Icon(
                  Icons.pix,
                  color: colorsDS.backgroundPure,
                ),
              ),
              const Spacer(),

            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const UolletiText.labelXLarge(
            "Para quem você quer enviar?",
    bold: true,
          ),
          const SizedBox(
            height: 15,
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
                    icon: Icons.badge_outlined,
                    title: "CPF",
                    subtitle: "Ex: ###.###.###-##",
                    onTap: (){
                      CoreNavigator.pushNamed("${AppRoutes.pixTransaction.queryPixKey}?${StringUtils.method}=${StringUtilsMethodsEnum.cpf.name}");
                    },
                  ), const SizedBox(
                    height: 20,
                  ),
                   UolletiButtonsOutlinedIcons(
                    icon: Icons.business_outlined,
                    title: "CNPJ",
                    subtitle: "Ex: ###.###.###-##",
                    onTap: (){
                      CoreNavigator.pushNamed("${AppRoutes.pixTransaction.queryPixKey}?${StringUtils.method}=${StringUtilsMethodsEnum.cnpj.name}");
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   UolletiButtonsOutlinedIcons(
                    icon: Icons.phone,
                    title: "Telefone",
                    subtitle: "Ex: (##) #####-####",
                     onTap: (){
                        CoreNavigator.pushNamed("${AppRoutes.pixTransaction.queryPixKey}?${StringUtils.method}=${StringUtilsMethodsEnum.phone.name}");
                     },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   UolletiButtonsOutlinedIcons(
                    icon: Icons.alternate_email_outlined,
                    title: "Email",
                    subtitle: "Ex: example@exmaple.com",
                     onTap: (){
                        CoreNavigator.pushNamed("${AppRoutes.pixTransaction.queryPixKey}?${StringUtils.method}=${StringUtilsMethodsEnum.email.name}");
                     },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
               
                   UolletiButtonsOutlinedIcons(
                    icon: Icons.vpn_key_outlined,
                    title: "Chave aleatória",
                    subtitle: "Ex: 12sd34sd5sdf67sdf8sd9sfd0",
                     onTap: (){
                        CoreNavigator.pushNamed("${AppRoutes.pixTransaction.queryPixKey}?${StringUtils.method}=${StringUtilsMethodsEnum.random.name}");
                     },
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
