import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';


class AccessContainerWidget extends StatefulWidget {
  const AccessContainerWidget({super.key});

  @override
  State<AccessContainerWidget> createState() => _AccessContainerWidgetState();
}

class _AccessContainerWidgetState extends State<AccessContainerWidget> {
  var gradient1 = const Color(0xff03602D);

  var gradient2 = const Color(0xff4DA262);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.getWidth(context),
      height: ScreenSize.getHeight(context) * 0.2,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              gradient1 = Colors.grey;
              gradient2 = Colors.grey;
            setState(() {
              
            });
            CoreNavigator.pushNamed(AppRoutes.onboarding.createAccount);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: ScreenSize.getWidth(context) * 0.8,
              height: ScreenSize.getHeight(context) * 0.08,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(colors: [gradient1, gradient2])),
              child: const Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(
                    "Iniciar",
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                  )
                ],
              )),
            ),
          ),
          Container(
            width: ScreenSize.getWidth(context) * 0.8,
            height: ScreenSize.getHeight(context) * 0.08,
            color: Colors.white,
            child: ElevatedButton(
              onPressed: () {
               
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  elevation: MaterialStateProperty.all(0)),
              child: const  Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(
                    "Entrar na minha conta",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              )),
            ),
          )
        ],
      ),
    );
  }
  

}
