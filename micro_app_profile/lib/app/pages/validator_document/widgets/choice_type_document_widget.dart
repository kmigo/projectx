

import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';


class ChoiceTypeRadioButton {
  final String type;
  final String label;
  const ChoiceTypeRadioButton({required this.type,required this.label});
}

class ChoiceTypeDocumentWidget extends StatelessWidget {
  final String? type;
  final Function(String?) onPressed;
  final List<ChoiceTypeRadioButton> children;
  const ChoiceTypeDocumentWidget({super.key, this.type,required this.onPressed,required this.children});

  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: type,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: [
                CircleAvatar(
              radius: 32,
              backgroundColor: colorsDS.backgroundMedium,
              child: Icon(Icons.photo_camera_outlined,size:30,color: colorsDS.iconsPure,),
            ),
            const SizedBox(height: 16,),
            const UolletiText.labelXLarge('Vamos tirar fotos de seu documento',bold: true,),
            const SizedBox(height: 16,),
            UolletiRichText.contentMedium('Para sua segurança, precisamos de fotos da\n<b>frente</b> e <b>verso</b> de seu documento pessoal',color: colorsDS.textLight,),
            const SizedBox(height: 26,),
            const UolletiText.captionMedium('Selecione o documento que você tem em\nmãos:',),
            const SizedBox(height: 16,),
            ...children.map((e) => Row(
              children: [
                Radio<String>(
                  value: e.type,
                  activeColor: colorsDS.iconsLight,
                  groupValue: state.value,
                  onChanged: (value){
                    state.didChange(value);
                  },
                ),
                const SizedBox(width: 10,),
                UolletiText.contentLarge(e.label),
              ],
            )).toList(),
              ],
            )),
            UolletiButtonIcon(icon: const Icon(Icons.arrow_forward), label: 'Continuar',preFixIcon: false,
            onPressed: state.value != null ? ()  => onPressed.call(state.value) : null,
            ),
            const SizedBox(height: 16,),
          ],
        );
      }
    );
  }
}