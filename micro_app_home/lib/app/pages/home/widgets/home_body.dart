import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';



import 'share_friends_widget.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
         const Row(
            children:  [
              Text(
                "Convidar amigos",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const ShareFrinedsWidget(),
          const SizedBox(
            height: 8,
          ),
          const Row(
            children:  [
              Text(
                "Envie um convite ao Whastapp de seus amigos e",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              )
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          const Row(
            children:  [
              Text(
                "familiares para negociar com você.",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              )
            ],
          ),
          SizedBox(
            height: ScreenSize.getHeight(context) * 0.04,
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: colorsDS.buttonDisabled,
          ),
          const SizedBox(
            height: 16,
          ),
         const Row(
            children:  [
              Text(
                "Minha uóleti",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 8,
              ),

              ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 65, 138, 67))),
                onPressed: () {

                 // Modular.to.pushNamed(AppRoutes.methodToPay);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      right: ScreenSize.getWidth(context) * 0.24,
                      top: ScreenSize.getHeight(context) * 0.06,
                      bottom: ScreenSize.getHeight(context) * 0.018),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Enviar",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
