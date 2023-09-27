part of 'ds.dart';

class UolletiDropDown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool isExpanded;
  final Widget Function(T) onChild;
  const UolletiDropDown(
      {super.key,
      required this.items,
      required this.onChanged,
      this.validator,
      required this.onChild,
      this.value,
      this.isExpanded = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: colorsDS.bordersDark)),
        child: DropdownButtonFormField<T>(
          value: value,
          decoration:const InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none
          ),
          items: items
              .map<DropdownMenuItem<T>>(
                  (e) => DropdownMenuItem(value: e,child: onChild(e),))
              .toList(),
          onChanged: onChanged,
          validator: validator,
          selectedItemBuilder: (context) => items
              .map<Widget>((e) => onChild(e))
              .toList()
              .cast<Widget>(),
          isExpanded: isExpanded,
        ));
  }
}

class UolletiDropDownSimple<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool isExpanded;
  final Widget Function(T) onChild;
  const UolletiDropDownSimple(
      {super.key,
      required this.items,
      required this.onChanged,
      this.validator,
      required this.onChild,
      this.value,
      this.isExpanded = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: colorsDS.bordersDark)),
        child: DropdownButton<T>(
          value: value,
          underline: const SizedBox(),
          items: items
              .map<DropdownMenuItem<T>>(
                  (e) => DropdownMenuItem(value: e,child: onChild(e),))
              .toList(),
          onChanged: onChanged,
          selectedItemBuilder: (context) => items
              .map<Widget>((e) => onChild(e))
              .toList()
              .cast<Widget>(),
          isExpanded: isExpanded,
        ));
  }
}
