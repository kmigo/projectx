part of '../phone_page.dart';

class ValidateSmsCode extends StatelessWidget {
  final Function(String) onChangedSmsCode;
  final VoidCallback onDone;
  final String? error;
  final bool isLoading;
  const ValidateSmsCode({super.key,required this.onChangedSmsCode,required this.isLoading,required this.onDone,this.error});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading,
      child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: colorsDS.backgroundMedium,
                      child: Icon(
                        Icons.contact_phone_outlined,
                        size: 25,
                        color: colorsDS.textPure,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const UolletiText.labelXLarge(
                      'Validar dispositivo',
                      bold: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    UolletiText.contentMedium(
                      'Enviamos uma mensagem de texto (SMS) para seu celular. Por favor, digite o código de <b>6 dígitos abaixo:</b>',
                      color: colorsDS.textLight,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    UolletiText.contentMedium(
                      'DDD + Celular',
                      bold: true,
                      color: colorsDS.textLight,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                     UolletiCodeInput(
                      totalCodeInput: 6,
                      backgroundColor: error != null ? colorsDS.backgroundPositive: null,
                      validateDone: (input){
                        if(input == null) return false;
                        if(input.length < 6){
                          return false;
                        }
                        return true;
                      },
                      onChanged: onChangedSmsCode,onDone: onDone,),
                      if(error != null)...[
                        const SizedBox(
                          height: 10,
                        ),
                        UolletiText.contentMedium(error!,color: colorsDS.textDanger,)
                      ],
                  
                    const SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              )),
              //  UolletiButtonIcon(
              //   onPressed: validateDone?.call() == true ? onDone : null,
              //   icon: Icon(Icons.arrow_forward),
              //   label: 'Salvar',
              //   preFixIcon: false,
              // ),
              const SizedBox(
                height: 18,
              )
            ],
          ),
        ),
    );
  }
}