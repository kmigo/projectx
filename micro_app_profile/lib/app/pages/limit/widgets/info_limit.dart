

import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';


class InfoLimit extends StatelessWidget {
  final double valueTotal;
  final double valueUsed;
  const InfoLimit({super.key,required this.valueTotal,required this.valueUsed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorsDS.backgroundPure,
        borderRadius: BorderRadius.circular(
          20
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5)
          )
        ],
        border: Border.all(
          color: colorsDS.bordersMedium,
          width: 0.5
        ),

      ),
      child: Column(
        children: [
          _info('Limite total', 'R\$ ${valueTotal.toStringAsFixed(2)}'),
          const SizedBox(height: 10,),
          _info('Limite utilizado', 'R\$ ${valueUsed.toStringAsFixed(2)}'),
          const SizedBox(height: 10,),
          _info('Limite livre',  'R\$ ${valueUsed.toStringAsFixed(2)}')
        ],
      ),

    );
  }

  _info(String title, String subtitle){
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        UolletiText.captionLarge(title,bold: true,),
    UolletiText.contentSmall(subtitle,bold: true,)
        ],
      ),
    );
  }
}