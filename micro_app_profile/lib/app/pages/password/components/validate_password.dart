part of '../password_page.dart';

class ValidatePassword extends StatelessWidget {
  final bool Function(String?)? validateDone;
  final Function(String) onChangedPassword;
  final VoidCallback? onDone;
  final bool Function()? validatePassword;
  const ValidatePassword(
      {super.key,
      this.validateDone,
      required this.onChangedPassword,
      this.onDone,
      this.validatePassword});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    backgroundColor: colorsDS.backgroundMedium,
                    radius: 30,
                    child: Icon(
                      Icons.pin_outlined,
                      size: 25,
                      color: colorsDS.iconsPure,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const UolletiText.labelXLarge(
                    'Alterar senha',
                    bold: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  UolletiRichText.contentMedium(
                    'Para criar uma nova, por favor digite a\nsua senha atual de <b>6 dígitos</b>',
                    color: colorsDS.textLight,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const UolletiText.labelMedium(
                    'Senha atual',
                    bold: true,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  UolletiCodeInput(
                    totalCodeInput: 6,
                    obscureText: true,
                    onChanged: onChangedPassword,
                    validateDone: validateDone,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: UolletiText.contentSmall('Esqueci a senha'),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: UolletiButtonIcon(
            icon: const Icon(Icons.arrow_forward),
            onPressed: validatePassword?.call() == true ? onDone : null,
            label: 'Continuar',
            preFixIcon: false,
          ),
        ),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }
}
