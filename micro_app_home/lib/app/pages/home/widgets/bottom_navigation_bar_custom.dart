import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';


import '../controllers/root_controller.dart';


// ignore: must_be_immutable
class BottomNavigationBarCustom extends StatelessWidget {
  BottomNavigationBarCustom({super.key});
  RootController rootController = CoreBinding.get();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          rootController.changePage(PagesRoot.home);
        },
        child: Container(
          width: ScreenSize.getWidth(context),
          height: ScreenSize.getHeight(context) * 0.1,
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 5, offset: Offset(1, 2))
          ]),
          child: Padding(
            padding: EdgeInsets.only(
              left: ScreenSize.getWidth(context) * 0.3,
              right: ScreenSize.getWidth(context) * 0.3,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 65,
                      height: 35,
                      decoration: BoxDecoration(
                          color: rootController.currentPageRoot.value ==
                                  PagesRoot.home
                              ? colorsDS.primary900
                              : Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(40))),
                      child: Icon(
                        Icons.home_outlined,
                        color: rootController.currentPageRoot.value ==
                                PagesRoot.home
                            ? Colors.white
                            : colorsDS.primary900,
                      ),
                    ),
                     Text(
                      "Inicio",
                      style: TextStyle(color: colorsDS.primary900),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        CoreNavigator.pushNamed(AppRoutes.extract.root);
                      },
                      child: Container(
                        width: 65,
                        height: 35,
                        decoration: BoxDecoration(
                            color: rootController.currentPageRoot.value ==
                                    PagesRoot.statement
                                ? colorsDS.primary900
                                : Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40))),
                        child: Icon(
                          Icons.payment,
                          color: rootController.currentPageRoot.value ==
                                  PagesRoot.statement
                              ? Colors.white
                              : colorsDS.primary900,
                        ),
                      ),
                    ),
                     Text(
                      "Extrato",
                      style: TextStyle(color: colorsDS.primary900),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
