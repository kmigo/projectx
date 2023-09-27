part of 'ds.dart';

class UolletiCodeInput extends StatefulWidget {
  final int totalCodeInput;
  final ValueChanged<String> onChanged;
  final double height;
  final double width;
  final bool obscureText ;
  final Color? backgroundColor;
  final Function()? onDone;
  final bool Function(String?)? validateDone;
  const UolletiCodeInput(
      {super.key,
      this.totalCodeInput = 4,
      required this.onChanged,
      this.validateDone,
      this.backgroundColor,
       this.obscureText = false,
      this.onDone,
      this.height = 48.0,
      this.width = 48.0});

  @override
  State<UolletiCodeInput> createState() => _UolletiCodeInputState();
}

class _UolletiCodeInputState extends State<UolletiCodeInput> {
  final List<FocusNode> _focusNodes = [];
  final List<TextEditingController> _controllers = [];
  var lastValue = '';
  final _rawKeyboardListenerFocusNode = FocusNode();
  final UolletiKeyboardBloc bloc = CoreBinding.get<UolletiKeyboardBloc>();
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.totalCodeInput; i++) {
      final focus = FocusNode();
      _focusNodes.add(focus);
      _controllers.add(TextEditingController());
    }
    for (int i = 0; i < widget.totalCodeInput; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.isNotEmpty && i != widget.totalCodeInput - 1) {
          _focusNodes[i].unfocus();
          FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
        }
        onChanged();
      });
    }
  }

  onChanged({String? value}) {
    if (value != null) {
      widget.onChanged(value);
      lastValue = value;
       bloc.addValueText(lastValue);
      return;
    }
    final newValue = _controllers.map((controller) => controller.text).join();
    if (newValue != lastValue) {
      widget.onChanged(newValue);
      lastValue = newValue;
      bloc.addValueText(lastValue);
    }
  }

  onClear() {
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].clear();
      try {
        _focusNodes[i].unfocus();
      } catch (e) {
        // error
      }
    }

    onChanged(value: '');
    _focusNodes[0].requestFocus();
  }





  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List<Widget>.generate(
            widget.totalCodeInput,
            (index) => Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.backgroundColor ??  colorsDS.bordersMedium,
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: Center(
                child: RawKeyboardListener(
                  key: Key(index.toString()),
                  focusNode: _rawKeyboardListenerFocusNode,
                  onKey: (event) {
                    final focus = _focusNodes[index];
                    if (event.data.logicalKey.keyLabel == "Backspace" &&
                        index != 0 &&
                        focus.hasPrimaryFocus) {
                      focus.unfocus();
                      FocusScope.of(context)
                          .requestFocus(_focusNodes[index - 1]);
                      onChanged();
                    }
                  },
                  child: Row(
                    children: [
                      Flexible(
                        child: UolletiTextInput(
                          focusNode: _focusNodes[index],
                          onClear: onClear,
                          onDone: widget.onDone,
                          obscureText: widget.obscureText,
                          validateDone: widget.validateDone,
                          controller: _controllers[index],
                          maxLength: 1,
                          maxLines: 1,
                          customKeyboardType: UolletiKeyboardType.numericWithoutObserver,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    _rawKeyboardListenerFocusNode.dispose();
    bloc.hide();
    super.dispose();
  }
}
