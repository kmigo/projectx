part of 'ds.dart';

class UolletiSliderButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  const UolletiSliderButton({super.key,required this.text,required this.onTap});

  @override
  State<UolletiSliderButton> createState() => _UolletiSliderButtonState();
}

class _UolletiSliderButtonState extends State<UolletiSliderButton> {

  double _sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return FormField<double>(
      initialValue: _sliderValue,
      builder: (state) {
        return GestureDetector(
          onPanUpdate: (details) {

              _sliderValue += details.delta.dx;
              if (_sliderValue > MediaQuery.of(context).size.width - 70) {
                _sliderValue = MediaQuery.of(context).size.width - 70;
              }
              if (_sliderValue < 0) _sliderValue = 0;
              state.didChange(_sliderValue);

          },
          onPanEnd: (details) {
              widget.onTap.call();
              _sliderValue = 0;
      state.didChange(_sliderValue);
          },
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: Text(widget.text),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 100),
                left: _sliderValue,
                child: Container(
                  height: 60,
                  width: 70,
                  color: Colors.blue,
                  child: const Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}





