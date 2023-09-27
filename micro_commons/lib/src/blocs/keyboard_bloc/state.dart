// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'bloc.dart';

enum UolletiKeyboardType { idle,numeric,numericWithoutObserver }

class UolletiKeyboardTypeState extends Equatable {
  final bool isHide;
  final UolletiKeyboardType type;
  final String text;
  final String value;
  final int? hashCodeWidget;



  const UolletiKeyboardTypeState({
    required this.isHide,
    required this.type,
    required this.text,
     this.value = '',
    this.hashCodeWidget,

  });
  
  @override
  List<Object?> get props => [isHide, type,text,hashCodeWidget,value];

  UolletiKeyboardTypeState copyWith({
    bool? isHide,
    UolletiKeyboardType? type,
    String? text,
    int? hashCodeWidget,
    String? value,

  }) {
    return UolletiKeyboardTypeState(
      isHide: isHide ?? this.isHide,
      type: type ?? this.type,
      text: text ?? this.text,
      hashCodeWidget: hashCodeWidget ?? this.hashCodeWidget,
      value: value ?? this.value,
    );
  }
}
