import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';


class AlertDoneReport extends StatelessWidget {
  const AlertDoneReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.hourglass_empty_outlined,size: 80,color: colorsDS.iconsMedium,),
        const SizedBox(height: 12,),
        const UolletiText.labelXLarge('Problema reportado',bold: true,),
        const SizedBox(height: 8,),
         UolletiText.contentLarge('Em breve, você será contatado por\nemail e/ou mensagem de texto (SMS)\ncom mais informações sobre como\nproceder.',textAlign: TextAlign.center,bold: false,color:colorsDS.textOutlined ,),
        const SizedBox(height: 15,),
        UolletiButton.primary(label: 'OK', onPressed: () => CoreNavigator.pop(),),
      ],
    );
  }
}