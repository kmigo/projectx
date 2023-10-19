part of '../new_card_page.dart';
class _TileCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final bool? isSelected;
  const _TileCard(
      {required this.icon,
      required this.onTap,
      required this.title,
      required this.onEdit,
      required this.subtitle,
      this.isSelected
      });
  const _TileCard.receiver(
      {required this.onTap, required this.title,required this.onEdit ,required this.subtitle,this.isSelected})
      : icon = Icons.pix;
  const _TileCard.origin(
      {required this.onTap, required this.title,required this.onEdit ,required this.subtitle,this.isSelected})
      : icon = Icons.account_balance_outlined;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
          width: double.infinity,
          padding:  const EdgeInsets.all( 10),
          decoration: BoxDecoration(
            
            color: isSelected == true? colorsDS.backgroundMedium :  colorsDS.backgroundLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: colorsDS.bordersDark),
          ),
          child: Row(
            children: [
              Expanded(child: Row(
                children: [
                  Icon(icon, color:  isSelected ==true ? colorsDS.textPure  :  colorsDS.backgroundMedium ,),
              const SizedBox(
                height: 10,
              )
                ],
              )),Expanded(child: Column(
                children: [
                  UolletiText.labelLarge(title,bold: true,color: isSelected ==true ? colorsDS.textPure  :  colorsDS.backgroundMedium , ),
                  UolletiText.labelSmall(subtitle, color: isSelected ==true ? colorsDS.textPure  :  colorsDS.backgroundMedium ,),
                ],
              )),
              Expanded(child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: onEdit,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isSelected ==true ? colorsDS.textPure  :  colorsDS.backgroundMedium ,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.edit,color: isSelected ==true ? colorsDS.backgroundMedium  :  colorsDS.textPure ,),
                  ),
                ),
              ))

            ],
          ),
        ),
      ),
    );
  }
}
