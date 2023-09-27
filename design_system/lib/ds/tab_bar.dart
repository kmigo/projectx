part of 'ds.dart';

class UolletiTabBar<T> extends StatelessWidget {
  final T? value;
  final List<T> tabs;
  final void Function(T)? onChanged;
  final String Function(T) labelBuilder;
  final Color backgroundSelectColor;
  final Color labelColor;
  final Color unselectedLabelColor;
  final Color backgroundUnselectedColor;
  const UolletiTabBar(
      {super.key,
      this.value,
      required this.tabs,
      this.onChanged,
      required this.backgroundSelectColor,
      required this.labelColor,
      required this.unselectedLabelColor,
      required this.labelBuilder,
      required this.backgroundUnselectedColor});
   UolletiTabBar.defaultStyle(
      {super.key,
      this.value,
      required this.tabs,
      required this.labelBuilder,
      this.onChanged}):
      backgroundSelectColor = colorsDS.primary900,
      labelColor = colorsDS.textPure,
      unselectedLabelColor = colorsDS.textLight,
      backgroundUnselectedColor = colorsDS.backgroundLight;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        
        decoration: BoxDecoration(
          color: backgroundUnselectedColor,
        ),
        child: Row(
          children: tabs.map<Widget>((e) {
            final activate = e == value;
            return Expanded(
              child: InkWell(
                onTap: (){
                  if(onChanged != null){
                    onChanged!(e);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  color: activate ? backgroundSelectColor : backgroundUnselectedColor,
                alignment: Alignment.center,
                child: activate ?  UolletiText.captionXLarge(labelBuilder(e),color:labelColor,bold: true,) : UolletiText.captionLarge(labelBuilder(e),color: unselectedLabelColor,bold: false,),
          ),
              ),
            ); }).toList(),
        ),
      ),
    );
  }
}
