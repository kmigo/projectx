

import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';



class TakePhotoBackDocument extends StatelessWidget {
  final String typeDocument;
  final Function(dynamic) onChange;


  const TakePhotoBackDocument({super.key, required this.onChange,required this.typeDocument});

  @override
  Widget build(BuildContext context) {
    return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: [
                CircleAvatar(
              radius: 32,
              backgroundColor: colorsDS.backgroundMedium,
              child: Icon(Icons.person_outline,size:30,color: colorsDS.iconsPure,),
            ),
            const SizedBox(height: 16,),
            const UolletiText.labelXLarge('Verso do documento',bold: true,),
            const SizedBox(height: 16,),
            UolletiText.contentMedium('Siga as instruções abaixo',color: colorsDS.textLight,),
            const SizedBox(height: 36,),
            _info(Icons.flip_camera_android_outlined ,'Vire o documento para fotografar o <b>verso</b>' ),
             const SizedBox(height: 16,),
            _info(Icons.remove ,'Retire o documento do plástico' ),
             const SizedBox(height: 16,),
            _info(Icons.light_mode_outlined ,'Esteja em local bem iluminado e evite\nsombras sobre o documento' ),
            const SizedBox(height: 16,),
            _info(Icons.rectangle_outlined ,'Coloque o documento em uma superfície\nlisa e enquadre todos os 4 cantos do\ndocumento.' ),

           
              ],
            )),
             UolletiButtonIcon(icon: const Icon(Icons.photo_camera_outlined), label: 'Tirar foto',preFixIcon: false,
           onPressed : ()async{
            final photo = await CoreNavigator.pushNamed(AppRoutes.cameraPage);
            if(photo != null){

              final filename = '${typeDocument}_verse.jpg'; 

             final decodedBytes = base64Decode((photo as String).split(',').last);

              onChange(CustomMultipartFile.generateFile(filename, decodedBytes));
            }
           },
            ),
            const SizedBox(height: 16,),
          ],
        );
  }

  _info(IconData icon, String text){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon,color: colorsDS.iconsLight,),
        const SizedBox(width: 8,),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: UolletiText.contentMedium(text,textAlign: TextAlign.start,)),
        ),
      ],
    );
  }
}