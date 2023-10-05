

import 'package:flutter/material.dart';

import 'package:micro_core/micro_core.dart';


class DialogExitProfile extends StatelessWidget {
  const DialogExitProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:18.0),
      child: Container(
        
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: colorsDS.backgroundPure,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const UolletiText.labelLarge('Tem certeza que deseja sair?', bold: true,),
            const SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: FittedBox(
              fit: BoxFit.scaleDown,
              child: UolletiText.contentMedium('Você poderá entrar nesta conta novamente,\nacessar outra ou criar uma nova.',color: colorsDS.textOutlined,textAlign: TextAlign.center,))),
            const SizedBox(height: 20,),
            UolletiButtonText.textLigth(label: 'Continuar',onPressed: () => CoreNavigator.pop(),),
            const SizedBox(height: 10,),
            UolletiButtonIcon(icon: const Icon(Icons.logout), priority: UolletiButtonPriority.danger,label: 'Sair',onPressed:(){
              CoreNavigator.pop();
              CoreBinding.get<AuthenticationBloc>().add(AuthenticationSignOutEvent());
            }),
            const SizedBox(height: 10,)

          ],
        ),
      ),
    );
  }
}