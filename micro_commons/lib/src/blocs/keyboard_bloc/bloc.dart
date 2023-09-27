




import 'package:micro_core/micro_core.dart';

part 'state.dart';

class UolletiKeyboardBloc extends Cubit<UolletiKeyboardTypeState> {
  UolletiKeyboardBloc() : super( const UolletiKeyboardTypeState(isHide: true, type: UolletiKeyboardType.idle,text: ''));
  int? maxLength;
  String? Function(String?)? transformText;
  Function()? onDone;
  Function()? onClear;
  bool Function(String?)? validateDone;
  void show() => emit(state.copyWith(isHide: false));
  void hide() => emit(state.copyWith(isHide: true));
  void addText(String text) {
    text = state.text + text;
    if(maxLength != null && text.length > maxLength!){
      return;
    }
    if(transformText != null){
      text = transformText!(text) ?? '';
    }
    emit(state.copyWith(text: text));
  }

  addValueText(String text) => emit(state.copyWith(value: text));
  void backspace(){
    onClear?.call();
    emit(state.copyWith(text: state.text.substring(0,state.text.length - 1)));

  }
  void done(){
    if(validateDone?.call(state.value) == true){
          hide();
    addValueText('');
    onDone?.call();
    }

  }
  void init({UolletiKeyboardType? type ,required String text, int? hashCodeWidget,bool Function(String?)? validateDone ,Function()? onDone ,String? Function(String?)? transformText, int? maxLength , Function()? onClear}) {
    emit(state.copyWith(text: text,type: type,hashCodeWidget: hashCodeWidget));
    this.onDone = onDone;
    this.onClear = onClear;
    this.transformText = transformText;
    this.validateDone = validateDone;
    this.maxLength = maxLength;
    }
}