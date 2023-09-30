part of 'ds.dart';

class UolletiTextInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? maxLength;
  final String? Function(String?)? validator;
  final UolletiKeyboardType? customKeyboardType;
  final TextAlign? textAlign;
  final FocusNode? focus;
  final Function()? onDone;
  final InputDecoration? decoration;
  final Function()? onClear;
  final bool Function(String?)? validateDone;
  final bool? obscureText;
  final bool? enabled;
  final String? errorText;
  const UolletiTextInput(
      {super.key,
      this.maxLength,
      this.errorText,
      this.customKeyboardType,
      this.validator,
      this.maxLines,
      this.controller,
      this.enabled,
      this.prefixIcon,
      this.validateDone,
      this.initialValue,
      this.obscureText,
      this.decoration,
      this.textAlign,
      this.focus,
      this.focusNode,
      this.onDone,
      this.onClear,
      this.onChanged,
      this.inputFormatters,
      this.hintText});
   UolletiTextInput.cpf(
      {super.key,
      this.maxLength,
      this.customKeyboardType,
      this.validator,
      this.maxLines,
      this.controller,
      this.enabled,
      this.prefixIcon,
      this.validateDone,
      this.initialValue,
      this.obscureText,
      this.decoration,
      this.textAlign,
      this.focus,
      this.focusNode,
      this.errorText,
      this.onDone,
      this.onClear,
      this.onChanged}): inputFormatters = [  CpfInputFormatter()],hintText = MaskHintText.cpf;
    UolletiTextInput.phone(
      {super.key,
      this.maxLength,
      this.customKeyboardType,
      this.validator,
      this.maxLines,
      this.controller,
      this.errorText,
      this.enabled,
      this.prefixIcon,
      this.validateDone,
      this.initialValue,
      this.obscureText,
      this.decoration,
      this.textAlign,
      this.focus,
      this.focusNode,
      this.onDone,
      this.onClear,
      this.onChanged}): inputFormatters = [PhoneInputFormatter()],hintText = MaskHintText.maskPhoneCountry('s');

  @override
  State<UolletiTextInput> createState() => _UolletiTextInputState();
}

class _UolletiTextInputState extends State<UolletiTextInput> {
  FocusNode? _focusNode;
  TextEditingController? _controller;
  final bloc = CoreBinding.get<UolletiKeyboardBloc>();
  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();

    if(widget.customKeyboardType != null || widget.controller != null){

       _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
       _controller?.addListener(_observerKeyboarding);
    }


    _focusNode?.addListener(_start
    );
  }
  _observerKeyboarding(){

        if(widget.customKeyboardType != UolletiKeyboardType.numericWithoutObserver){
           bloc.addValueText(_controller?.text ?? '');
        }

        if(_controller?.text.isEmpty == true){
          bloc.addValueText('');
        }
       
        widget.onChanged?.call(_controller!.text);

  }
  _start(){
    if(![UolletiKeyboardType.numericWithoutObserver,UolletiKeyboardType.numeric].contains(widget.customKeyboardType)) return;
      if (_focusNode?.hasFocus == true) {
        bloc.init(
            type: widget.customKeyboardType,
            text: _controller?.text ?? '',
            hashCodeWidget: _controller.hashCode,
            validateDone: widget.validateDone,
            onDone :(){
                _focusNode?.unfocus();
              widget.onDone?.call();
              },
            transformText: _inputFormatter,
            maxLength: widget.maxLength,
            onClear: widget.onClear);
        bloc.show();
      } 
    
  }
  @override
  void dispose() {
    _focusNode?.removeListener(_start);
    _controller?.removeListener(_observerKeyboarding);
    _controller?.dispose();
    _focusNode?.dispose();
    super.dispose();
  }

  String? _inputFormatter(String? text) {
    if (text == null) return text;
    if (widget.inputFormatters?.isNotEmpty == true) {
      widget.inputFormatters?.forEach((element) {
        if (text!.length >= 2) {
          text = element
              .formatEditUpdate(
                  TextEditingValue(text: text!.substring(0, text!.length - 1)),
                  TextEditingValue(text: text!))
              .text;
        }
      });
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<UolletiKeyboardBloc, UolletiKeyboardTypeState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.hashCodeWidget != _controller.hashCode) return;
        if(![UolletiKeyboardType.numericWithoutObserver,UolletiKeyboardType.numeric].contains(widget.customKeyboardType)) return;
        _controller?.text = state.text;
      },
      child: TextFormField(
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        initialValue: _controller != null? null: widget.initialValue,
        enabled: widget.enabled,
        onChanged: widget.onChanged,
        controller: _controller,
        obscureText: widget.obscureText ?? false,
        validator: widget.validator,
        textAlign: widget.textAlign ?? TextAlign.start,
        focusNode: _focusNode,
        readOnly: widget.customKeyboardType != null,
        inputFormatters: widget.inputFormatters,
        decoration: widget.decoration ??
            InputDecoration(
              hintText: widget.hintText,
              prefixIcon: widget.prefixIcon,
              errorText: widget.errorText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
      ),
    );
  }
}
