import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

class SendPixPage extends StatefulWidget {
  const SendPixPage({super.key});

  @override
  State<SendPixPage> createState() => _SendPixPageState();
}

class _SendPixPageState extends State<SendPixPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(),
      body:  Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: colorsDS.backgroundMedium,
              radius: 50,
              child: Icon(Icons.pix,color: colorsDS.backgroundPure,size: 40,),
            )
          ],
        ),
      ),
    );
  }
}