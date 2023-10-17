import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

class TileCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final VoidCallback onEdit;
  final VoidCallback onPay;
  const TileCard({super.key,this.title = '',this.subtitle = '',this.description = '',required this.onEdit, required this.onPay});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colorsDS.bordersMedium,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
       border: Border.all(color: colorsDS.bordersDark)
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorsDS.bordersDark,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child:  Icon(Icons.add_card,color: colorsDS.backgroundMedium,size: 35,),
          ),
          const SizedBox(width: 15,),
           Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5,),
              UolletiText.labelXLarge(title,bold: true,),
              const SizedBox(height: 5,),
              UolletiText.labelLarge(subtitle,color: colorsDS.textLight,),
              const SizedBox(height: 5,),
              UolletiText.labelSmall(description,color: colorsDS.textLight,),
            ],
          )),
           Row(
            children: [
              const SizedBox(width: 10,),
              InkWell(
                onTap: onEdit,
                child: CircleAvatar(
                  backgroundColor: colorsDS.iconsWarning,
                  child: Icon(Icons.edit,color: colorsDS.iconsPure,)),
              ),
              const SizedBox(width: 10,),
              InkWell(
                onTap: onPay,
                child: CircleAvatar(
                  backgroundColor: colorsDS.bordersDark,
                  child: Icon(Icons.savings,color: colorsDS.iconsPositive,)),
              ),
              const SizedBox(width: 10,),
            ],
          )
        ],
      ),
    );
  }
}