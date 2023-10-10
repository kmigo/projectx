import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';





// ignore: must_be_immutable
class BottomNavigationBarCustom extends StatelessWidget {
   const  BottomNavigationBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      decoration:  BoxDecoration(
          color: colorsDS.backgroundMedium,
          ),

      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 20,),
          _TileButton(icon: Icons.add_card, backgroundColor: colorsDS.bordersMedium, onTap: (){
            CoreNavigator.pushNamed(AppRoutes.accountBank.sendTransaction);

          }),
          const SizedBox(width: 20,),
          _TileButton(icon: Icons.history, backgroundColor: colorsDS.bordersMedium, onTap: (){}),
        ],
      ),
    );
  }
}

class _TileButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onTap;
  const _TileButton({required this.icon,required this.backgroundColor ,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(4)
            ),
        child: Icon(icon,color: colorsDS.primary900,),
      ),
    );
  }
}
