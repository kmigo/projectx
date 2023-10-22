// ignore_for_file: unused_element

part of 'ds.dart';

class UolletiKeyboardNumeric extends StatefulWidget {
  const UolletiKeyboardNumeric({super.key});

  @override
  State<UolletiKeyboardNumeric> createState() => _UolletiKeyboardNumericState();
}

class _UolletiKeyboardNumericState extends State<UolletiKeyboardNumeric> {
  final columns = List.generate(3, (index) => index+1);
  final rows = List.generate(3, (index) => index );
  final bloc = CoreBinding.get<UolletiKeyboardBloc>();
  int digit = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height * 0.5;
    final heightButton = height * 0.18;
    final widthButton = size.width * 0.22;
    return SizedBox(
      height: height,
      width: size.width,
      child: Material(
        color: colorsDS.backgroundLight,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: columns.map<Widget>((colum) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: rows.map((row) {
                          digit++;
                          return _ButtonTileKeyboard.primary(
                            value: digit,
                            onTap: (value) => bloc.addText('$value'),
                            height: heightButton,
                            width: widthButton,
                            child: Center(
                                child: UolletiText.displaySmall(
                              '$digit',
                              color: colorsDS.textPure,
                              bold: true,
                            )),
                          );
                        }).toList(),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ButtonTileKeyboard.backspace(
                    onTap: (p0) {
                      bloc.backspace();
                    },
                    height: heightButton,
                    width: widthButton,
                    child: Center(
                        child: Icon(
                      Icons.backspace,
                      color: colorsDS.iconsDanger,
                    )),
                  ),
                  _ButtonTileKeyboard.primary(
                    onTap: (value) => bloc.addText('0'),
                    height: heightButton,
                    width: widthButton,
                    child: Center(
                        child: UolletiText.displaySmall(
                      '0',
                      color: colorsDS.textPure,
                      bold: true,
                    )),
                  ),
                  BlocConsumer<UolletiKeyboardBloc, UolletiKeyboardTypeState>(
                    bloc: bloc,
                    listener: (context, state) {

                    },
                    builder: (context, state) {
                      bool validateDone = false;

                      if(bloc.validateDone != null){
                        validateDone = bloc.validateDone!(state.value);

                      }
                      return _ButtonTileKeyboard.done(
                        onTap: (value) {
                          bloc.done();
                        },
                        height: heightButton,
                        width: widthButton,
                        colorBackground: validateDone ?  colorsDS.iconsPositive : colorsDS.backgroundNegative,
                        child: Center(
                            child: Icon(
                          Icons.arrow_forward,
                          color: validateDone ? colorsDS.iconsPure : colorsDS.iconsDisabled,
                        )),
                      );
                    },
                  ),
                ],
              ),
              //const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}

class _ButtonTileKeyboard extends StatelessWidget {
  final int? value;
  final Widget child;
  final double height;
  final double width;
  final Color colorBackground;
  final Function(int?)? onTap;
  const _ButtonTileKeyboard(
      {required this.child,
      required this.height,
      this.value,
      this.onTap,
      required this.width,
      required this.colorBackground});
  _ButtonTileKeyboard.primary(
      {required this.child,
      required this.height,
      this.onTap,
      this.value,
      required this.width})
      : colorBackground = colorsDS.primary900;
  _ButtonTileKeyboard.backspace(
      {required this.child,
      required this.height,
      this.onTap,
      this.value,
      required this.width})
      : colorBackground = colorsDS.backgroundNegative;
  const _ButtonTileKeyboard.done(
      {required this.child,
      required this.height,
      this.onTap,
      this.value,
      required this.colorBackground,
      required this.width});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
          onPressed: () {
            onTap?.call(value);
          },
  style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(1),
            backgroundColor:
               MaterialStatePropertyAll<Color>(colorBackground),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ))),
          child: SizedBox(
            height: height,
            width: width,
            child: child),
        );
  }
}
