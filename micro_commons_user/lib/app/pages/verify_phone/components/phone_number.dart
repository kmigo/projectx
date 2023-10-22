part of '../verify_phone_page.dart';

class SendPhoneNumberComponent extends StatelessWidget {
  final List<PhoneItemConfigModel> phoneCountryAvaibles;
  final TextEditingController phoneController;
  final PhoneItemConfigModel? phoneChoice;
  final String? errorText;
  final bool isLoading;
  final ValueChanged<PhoneItemConfigModel> onChanged;
  final VoidCallback onContinue;
  const SendPhoneNumberComponent(
      {super.key,
      this.phoneChoice,
      required this.phoneController,
      this.errorText,
      required this.isLoading,
      required this.onContinue,
      required this.onChanged,
      required this.phoneCountryAvaibles});
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
            child: LayoutBuilder(builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset('files/calendar-icon.png'),
                        ],
                      ),
                      SizedBox(
                        height: ScreenSize.getHeight(context) * 0.03,
                      ),
                      const Row(
                        children: [
                          Text(
                            "Qual é o seu número de celular?",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenSize.getHeight(context) * 0.03,
                      ),
                      const Row(
                        children: [
                          Text(
                            'DDD + Celular',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      SizedBox(
                        height: ScreenSize.getHeight(context) * 0.01,
                      ),
                      SizedBox(
                        width: ScreenSize.getWidth(context) * 0.88,
                        child: Row(
                          children: [
                            UolletiDropDownSimple<PhoneItemConfigModel>(
                              value: phoneChoice,
                              items: phoneCountryAvaibles,
                              onChanged: (e) => onChanged.call(e!),
                              onChild: (value) => Center(
                                  child: UolletiText(
                                      "${value.code} ${value.abbreviation}")),
                              isExpanded: false,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Flexible(
                              child: UolletiTextInput(
                                errorText: errorText,
                                enabled: phoneChoice != null,
                                validateDone: (value) {
                                  if (phoneChoice == null) return false;
                                  return HelperValidatorMask
                                      .validateMaskToNumbers(
                                          phoneController.text,
                                          phoneChoice!.mask!);
                                },
                                controller: phoneController,
                                hintText: phoneChoice?.hint,
                                onDone: () => onContinue.call(),
                                inputFormatters: [
                                  MaskedInputFormatter(
                                      mask: phoneChoice?.mask ??
                                          '(##) #####-####')
                                ],
                                customKeyboardType:
                                    UolletiKeyboardType.numericWithoutObserver,
                              ),
                            ),

                          ],
                        ),
                        
                      ),
                      const SizedBox(height: 18,)
                    ],
                  ),
                ),
              );
            }),
          ),
         
        ],
      ),
    );
  }
}
