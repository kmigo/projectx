import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';


class FingerprintPage extends StatefulWidget {
  const FingerprintPage({super.key});

  @override
  State<FingerprintPage> createState() => _FingerprintPageState();
}

class _FingerprintPageState extends State<FingerprintPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(
        backgroundColor: colorsDS.backgroundPure,
        title: const UolletiText.labelXLarge(
          'Biometria',
          bold: true,
        ),
        centerTitle: true,
      ),
      body: FormField<bool>(
          initialValue: false,
          builder: (state) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: colorsDS.backgroundMedium,
                    child: Icon(
                      Icons.fingerprint_outlined,
                      size: 30,
                      color: colorsDS.backgroundPure,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const UolletiText.labelXLarge(
                    'Biometria digital',
                    bold: true,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  UolletiRichText.contentMedium(
                    'Seu aparelho celular dispõe de um leitor de\ndigitais. Para acessar o app <color value="textBlack">mais rapidamente e </color>\n<color value="textBlack">com segurança</color>, habilite a biometria digital.',
                    color: colorsDS.textLight,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: colorsDS.backgroundPure,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: colorsDS.bordersMedium, width: .5),
                        boxShadow: [
                          BoxShadow(
                              color: colorsDS.bordersMedium,
                              blurRadius: 1,
                              offset: const Offset(0, 1))
                        ]),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                            child: UolletiText.contentMedium(
                          'Habilitar leitor de digitais',
                          bold: true,
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        //adicionar um switch fill
                        UolletiSwitch(
                            isSwitched: state.value!,
                            onChanged: () {
                              _showSnack(!state.value!);
                              state.didChange(!state.value!);
                            }),
                      ],
                    ),
                  ),
                  const Spacer(),
                  UolletiButton.primary(
                    label: 'Voltar',
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            );
          }),
    );
  }

  _showSnack(bool value) {
    if (value) {
      showUolletiSnackbar(
          context,
          UolletiSnackbar(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              bottom: 100,
              backgroundColor: colorsDS.iconsPositive,
              title: UolletiText.labelSmall(
                'Biometria digital habilitada',
                color: colorsDS.textPure,
              ),
              trailling: Icon(
                Icons.task_alt_outlined,
                color: colorsDS.iconsPure,
              ),
              leading: Icon(
                Icons.fingerprint_outlined,
                color: colorsDS.iconsPure,
              )),
          const Duration(seconds: 3));
    } else {
      showUolletiSnackbar(
          context,
          UolletiSnackbar(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              bottom: 100,
              backgroundColor: colorsDS.iconsDanger,
              title: UolletiText.labelSmall(
                'Biometria digital desabilitada',
                color: colorsDS.textPure,
              ),
              trailling: Icon(
                Icons.block_outlined,
                color: colorsDS.iconsPure,
              ),
              leading: Icon(
                Icons.fingerprint_outlined,
                color: colorsDS.iconsPure,
              )),
          const Duration(seconds: 3));
    }
  }
}
