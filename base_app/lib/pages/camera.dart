import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

class CameraPhoto extends StatefulWidget {
  const CameraPhoto({super.key});

  @override
  State<CameraPhoto> createState() => _CameraPhotoState();
}

class _CameraPhotoState extends State<CameraPhoto> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: UolletiAppBar(
        centerTitle: true,
        title: UolletiText.labelLarge('Tirar foto',color: colorsDS.backgroundPure,),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: colorsDS.backgroundPure,),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: colorsDS.primary900,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: colorsDS.backgroundPure,
            width: size.width,
            height: size.height * 0.55,
            child: const Scanner(clickToCapture: true,),
          )
        ],
      ),
    );
  }
}