part of '../verify_phone_page.dart';

class ConfirmPhoneSmsCodeComponent extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onContinue;
  final String? smsCode;
  final bool isLoading;
  final bool error;
  final String? errorText;
  const ConfirmPhoneSmsCodeComponent({super.key,required this.error , this.errorText,required this.onChanged,required  this.isLoading,required this.smsCode,required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: ScreenSize.getHeight(context) * 0.05,
          top: ScreenSize.getHeight(context) * 0.05,
          left: ScreenSize.getWidth(context) * 0.05,
          right: ScreenSize.getWidth(context) * 0.05),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    CircleAvatar(
                      backgroundColor: colorsDS.backgroundMedium,
                      radius: 35,
                      child: Icon(
                        Icons.forum_outlined,
                        color: colorsDS.iconsPure,
                        size: 35,
                      ),
                    ),
                    SizedBox(
                      height: ScreenSize.getHeight(context) * 0.02,
                    ),
                    const UolletiText.labelXLarge('Validar dispositivo',bold: true,),
                    SizedBox(
                      height: ScreenSize.getHeight(context) * 0.02,
                    ),
                    UolletiRichText.contentMedium('Enviamos uma mensagem de texto (SMS)\npara seu celular. Por favor, digite o código\nde <b>6 dígitos</b> abaixo:',
                    color: colorsDS.textLight,
                    ),
                    SizedBox(
                      height: ScreenSize.getHeight(context) * 0.02,
                    ),
                    if(errorText != null)...[
                      Center(child: UolletiRichText.contentMedium(errorText!,color: colorsDS.textDanger,)),
                      SizedBox(
                        height: ScreenSize.getHeight(context) * 0.01,
                      ),
                    ],
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: ScreenSize.getHeight(context) * 0.03),
                      child: UolletiCodeInput(onChanged: onChanged,totalCodeInput: 6,
                      backgroundColor:  error ? colorsDS.backgroundPositive : colorsDS.bordersMedium,
                      onDone: onContinue,
                      height: ScreenSize.getHeight(context) * 0.05,
                      width: ScreenSize.getHeight(context) * 0.05,
                      validateDone: (codes) => codes?.length == 6,
                      ),
                    )
                      
                ],
              ),
            ),
          ),

          UolletiButton.primary(
                  disabled: (smsCode?.length ?? 0) <  6,
                  isLoading: isLoading,
                  label: 'Continuar',
                  onPressed: ()=>onContinue.call())
        ],
      ),
    );
  }
}