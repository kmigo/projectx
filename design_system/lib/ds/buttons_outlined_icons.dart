part of 'ds.dart';

class UolletiButtonsOutlinedIcons extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  const UolletiButtonsOutlinedIcons({super.key,required this.icon,required this.title,required this.subtitle,this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorsDS.bordersDark)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: colorsDS.backgroundLight,
              child: Icon(icon,color: colorsDS.iconsLight,)),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UolletiText.labelMedium(title,bold: true,),
               const  SizedBox(height: 5,),
                UolletiText.captionLarge(subtitle,color: colorsDS.textLight,),
              ],
            ),
            const Spacer(),
             Icon(Icons.arrow_forward_ios,color: colorsDS.iconsMedium,
             size: 14,
             )
          ],
        ),
      ),
    );
  }
}