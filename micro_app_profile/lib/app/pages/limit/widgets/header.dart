import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';


class HeaderLimitWidget extends StatelessWidget {
  const HeaderLimitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorsDS.primary900,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UolletiText.labelSmall(
                    'Limite total',
                    color: colorsDS.textDisabled,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      UolletiText.contentSmall('R\$  ',color: colorsDS.textPure,),
                      UolletiText.headingLarge('400,00',bold: true,color: colorsDS.textPure,)
                    ],
                  )
                    ],
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: colorsDS.backgroundPure,
                    ),
                child: Row(
                  children: [
                    Icon(Icons.price_change_outlined,color: colorsDS.iconsLight,),
                    const SizedBox(width: 5,),
                    UolletiText.labelMedium('Aumentar',color: colorsDS.textPrimary,bold: true,)
                  ],
                ),
              )

            ],
          )
        ],
      ),
    );
  }
}
