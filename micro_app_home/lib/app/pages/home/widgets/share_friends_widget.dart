import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';


class ShareFrinedsWidget extends StatelessWidget {
  const ShareFrinedsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize.getHeight(context) * 0.25,
      width: ScreenSize.getWidth(context),
      decoration:  BoxDecoration(
          color: colorsDS.buttonDisabled,
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.green),
              child: const Icon(
                Icons.phone,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
