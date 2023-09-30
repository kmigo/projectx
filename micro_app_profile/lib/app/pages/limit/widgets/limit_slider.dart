

import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';


class LimitSliderWidget extends StatelessWidget {
  final double valueUsed;
  final double valueTotal;
  const LimitSliderWidget({super.key,required this.valueTotal,required this.valueUsed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UolletiText.labelMedium('Detalhes do limite',bold: true,),
        const SizedBox(height: 10,),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UolletiText.contentSmall('Utilizado'),
            UolletiText.contentSmall('Disponível')
          ],
        ),
        const SizedBox(height: 10,),
        LayoutBuilder(
          builder: (context,constraints) {
            return Container(
              height: 10,
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                color: colorsDS.iconsPositive,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Stack(
                children: [
                  Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: colorsDS.iconsWarning,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    width: constraints.maxWidth * (valueUsed / valueTotal),
                  )
                ],
              ),
            );
          }
        ),
        const SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UolletiText.labelMedium('R\$ ${valueUsed.toStringAsFixed(2)}',color: colorsDS.textDisabled,bold: true,),
            UolletiText.labelMedium('R\$ ${valueTotal.toStringAsFixed(2)}',color: colorsDS.textPositive,bold: true,)
          ],
        ),
      ],
    );
  }
}