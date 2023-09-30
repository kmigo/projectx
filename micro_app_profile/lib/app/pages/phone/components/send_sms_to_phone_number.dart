part of '../phone_page.dart';

class SendSmsToPhoneNumber extends StatelessWidget {
  final Function(String) onChanged;
  final VoidCallback? onTap;
  final bool Function() validatePhone;
  final bool isLoading;
  const SendSmsToPhoneNumber({super.key,required this.onChanged,this.onTap,required this.isLoading,required this.validatePhone});

  @override
  Widget build(BuildContext context) {
    return  Padding(
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
                    'Atualize seu número de celular',
                    bold: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  UolletiText.contentMedium(
                    'Mantenha seu número de celular atualizado para\nsua segurança. Para alterar o número, você\nreceberá um token para validação.',
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
                   UolletiTextInput(
                    hintText: '(85) 99131-2622',
                    customKeyboardType: UolletiKeyboardType.numeric,
                    onChanged: onChanged,
                    onDone: (){},
                    onClear: (){},
                    validateDone: (value){
                      
                     
                      return HelperValidator.phone(value);
                    },
                    inputFormatters: [PhoneInputFormatter()],
                  ),
                
                  const SizedBox(
                    height: 18,
                  ),
                ],
              ),
            )),
             UolletiButtonIcon(
              isLoading: isLoading,
              icon: const Icon(Icons.arrow_forward),
              onPressed: validatePhone.call() == true ? onTap : null,
              label: 'Salvar',
              preFixIcon: false,
            ),
            const SizedBox(
              height: 18,
            )
          ],
        ),
      );
  }
}