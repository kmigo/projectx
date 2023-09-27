
part of 'ds.dart';

class UolletiSwitch extends StatelessWidget {
  final bool isSwitched ;
  final VoidCallback onChanged;
  final double height;
  final double width;
  const UolletiSwitch({super.key, required this.isSwitched, required this.onChanged, this.height = 14.0, this.width = 27.0});

  @override
  Widget build(BuildContext context) {

    return Center(
          child: GestureDetector(
            onTap: onChanged,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: isSwitched ? colorsDS.iconsPositive : Colors.transparent,
                border: Border.all(color: colorsDS.iconsMedium,width: 1.9)
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal:  height * .1),
                child: Stack(
                  children: [
                    Align(
                      alignment: isSwitched?  Alignment.centerRight : Alignment.centerLeft,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: height * .5,
                        width: height * .5,
                        decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSwitched ? colorsDS.backgroundPure : colorsDS.iconsPositive,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
  }
}