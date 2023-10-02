import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

import '../../../../src/models/report_model.dart';


class ReportBottomSheet extends StatefulWidget {
  final Function(ReportModel)?onConfirm;
  const ReportBottomSheet({super.key,this.onConfirm});

  @override
  State<ReportBottomSheet> createState() => _ReportBottomSheetState();
}

class _ReportBottomSheetState extends State<ReportBottomSheet> {
  final formReportKey = GlobalKey<FormState>();
  final formReportTextKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
       
        padding:const EdgeInsets.all(18),
        child: FormField<String?>(
          key: formReportTextKey,
          builder: (state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: colorsDS.bordersMedium,
                  radius: 20,
                  child: Icon(Icons.report_outlined,size :20,color:colorsDS.iconsDanger ,),
                ),
                const SizedBox(height: 10,),
                const UolletiText.labelXLarge('Reportar um problema',bold: true,),
                const SizedBox(height: 10,),
                if(state.value == null) _ReportDropDown(reportItems: const ['Fui roubado','Não foi eu que fiz essa compra','Outro'],formKey: formReportKey,
                onChanged: (value) => state.didChange(value),
                 ),

                if(state.value != null) _ReportDescribe(onChanged: (value) {
                  CoreNavigator.pop();
                  widget.onConfirm?.call(ReportModel(type: state.value!,description: value!));
                },),


              ],
            );
          }
        ),
      ),
    );
  }
}


class _ReportDropDown extends StatelessWidget {

  final List<String> reportItems;
  final GlobalKey<FormState> formKey;
  final Function(String?)? onChanged;
  const _ReportDropDown({ required this.reportItems,required this.formKey,this.onChanged});

  @override
  Widget build(BuildContext context) {
    return FormField<String?>(

      key: formKey,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const UolletiText.labelMedium('Qual problema você deseja reportar?'),
                const SizedBox(height: 5,),
            Container(

              decoration: BoxDecoration(
                border: Border.all(color: colorsDS.bordersDark ),
                borderRadius: BorderRadius.circular(5)
              ),
              child: DropdownButton<String>(
                value: state.value,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                isExpanded: true,
                selectedItemBuilder: (context) => reportItems.map<Widget>((String item) {
                  return Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UolletiText.contentLarge(item,bold: true,),
                      ],
                    ),
                  );
                }).toList(),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 0,
                  color: Colors.transparent,
                ),
                onChanged: (String? newValue) {
                 state.didChange(newValue);
                },
                items: reportItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: UolletiText.contentLarge(value,bold:true),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10,),
            UolletiButtonIcon(icon: const Icon(Icons.arrow_forward,color: Colors.white,), preFixIcon: false, label: 'Continuar', 
            onPressed: state.value != null ? () => onChanged?.call(state.value) : null,
            )

          ],
        );
      }
    );
  }
}


class _ReportDescribe extends StatelessWidget {
  final Function(String?)? onChanged;

  const _ReportDescribe({ this.onChanged });

  @override
  Widget build(BuildContext context) {
    return FormField<String?>(
      builder: (state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UolletiText.contentMedium('Em poucas palavras, tente nos explicar o que\naconteceu'),
            const SizedBox(height: 10,),
            UolletiTextInput(
              maxLines: 4,
              maxLength: 200,
              onChanged: (value){
                state.didChange(value);
              },
              hintText: 'Escreva aqui...',
            ),
            UolletiButtonIcon(icon: Icon(Icons.arrow_forward,color: colorsDS.textPure,), label: 'Continuar', onPressed:state.value?.isEmpty ==true || state.value == null ?  null : () => onChanged?.call(state.value) )
          ],
        );
      }
    );
  }
}