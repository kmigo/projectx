

import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';


class BottomSheetPhotoProfile extends StatelessWidget {
  const BottomSheetPhotoProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
     
      decoration: BoxDecoration(
         color: colorsDS.backgroundPure,
 borderRadius:const  BorderRadius.only(

  topLeft: Radius.circular(20),
  topRight: Radius.circular(20),
 )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(onPressed: (){
            CoreNavigator.pop();
          }, icon: const Icon(Icons.close,)),
          const SizedBox(height: 20,),
          _row(Icons.add_a_photo_outlined, 'Nova foto de perfil'),
          const SizedBox(height: 20,),
          _row(Icons.sync, 'Importar do whatsapp'),
          const SizedBox(height: 20,),
          _row(Icons.delete_outline, 'Remover foto de perfil',color: colorsDS.buttonsDanger,),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
  _row(IconData icon, String label,{Color? color}){
    return Row(
      children: [
        Icon(icon,color: color ?? colorsDS.iconsLight,),
        const SizedBox(width: 10,),
        UolletiText.contentMedium(label,color: color ?? colorsDS.textBlack,)
      ],
    );
  }
}