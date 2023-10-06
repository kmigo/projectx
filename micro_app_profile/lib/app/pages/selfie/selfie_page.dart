import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:micro_commons_user/micro_commons_user.dart';


import 'package:micro_core/micro_core.dart';

import '../../blocs/update_kyc/bloc.dart';

class SelfiePage extends StatefulWidget {
  const SelfiePage({super.key});

  @override
  State<SelfiePage> createState() => _SelfiePageState();
}

class _SelfiePageState extends State<SelfiePage> {
  final bloc = CoreBinding.get<BlocUpdateKyc>();
  @override
  void initState() {
    super.initState();
    bloc.getKyc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(
        backgroundColor: colorsDS.backgroundPure,
        title: const UolletiText.labelXLarge(
          'Reconhecimento facil',
          bold: true,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<BlocUpdateKyc, UpdateKycState>(
        bloc: bloc,
        listener: (context, state) {
          if (state.status == UpdateKycStatus.failure) {
            showUolletiSnackbar(
                context,
                UolletiSnackbar.bottomError(
                  message: state.message!,
                ),
                const Duration(seconds: 3));
          }
          if (state.status == UpdateKycStatus.updated) {
            CoreNavigator.pop(true);
            UolletiDialogs.dialogGenericState(true,
                onTap: () => CoreNavigator.pop());
          }
        },
        builder: (context, state) {
          if (state.status == UpdateKycStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (bloc.statusResponse(3) == KYCSTATUSRESPONSE.inReview) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  CircleAvatar(
                    backgroundColor: colorsDS.iconsWarning,
                    child: Icon(
                      Icons.face,
                      size: 28,
                      color: colorsDS.iconsPure,
                    ),
                  ),
                 const  SizedBox(
                    height: 18,
                  ),
                  UolletiText.labelXLarge(
                    'Selfie em análise',
                    color: colorsDS.textBlack,
                    bold: true,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  UolletiText.contentMedium(
                    'A sua foto para reconhecimento facial foi enviada para análise e está sendo verificada.',
                    color: colorsDS.textLight,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  UolletiText.labelSmall(
                    'Você será notificado quando a análise for concluída.',
                    color: colorsDS.textPrimary,
                  ),
                  const Spacer(),
                  UolletiButton.primary(
                    label: 'Voltar',
                    onPressed: () => CoreNavigator.pop(),
                  ),
                 const SizedBox(
                    height: 18,
                  ),
                ],
              ),
            );
          }

          if (bloc.statusResponse(3) == KYCSTATUSRESPONSE.completed) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const  SizedBox(
                    height: 24,
                  ),
                  CircleAvatar(
                    backgroundColor: colorsDS.iconsPositive,
                    child: Icon(
                      Icons.face,
                      size: 28,
                      color: colorsDS.iconsPure,
                    ),
                  ),
                 const  SizedBox(
                    height: 18,
                  ),
                  UolletiText.labelXLarge(
                    'Selfie validada',
                    color: colorsDS.textBlack,
                    bold: true,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  UolletiText.contentMedium(
                    'A foto da sua face para prova de vida foi analisada e foi aprovada.',
                    color: colorsDS.textLight,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  UolletiText.labelSmall(
                    'No momento, não é necessário tomar nenhuma ação.',
                    color: colorsDS.textLight,
                  ),
                 const  Spacer(),
                  UolletiButton.primary(
                    label: 'Voltar',
                    onPressed: () => CoreNavigator.pop(),
                  ),
                 const  SizedBox(
                    height: 18,
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: colorsDS.backgroundMedium,
                  child: Icon(
                    Icons.face,
                    color: colorsDS.iconsPure,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const UolletiText.labelXLarge(
                  'Reconhecimento facial',
                  bold: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                UolletiText.contentMedium(
                  'Tire uma selfie (foto do seu rosto) para\ngarantir a sua segurança.',
                  color: colorsDS.textLight,
                ),
                const SizedBox(
                  height: 35,
                ),
                _info(Icons.remove, 'Remova acessórios como óculos ou bonés'),
                const SizedBox(
                  height: 15,
                ),
                _info(Icons.light_mode_outlined,
                    'Esteja em local bem iluminado e evite\nsombras sobre o rosto'),
                const SizedBox(
                  height: 15,
                ),
                _info(Icons.rectangle_outlined,
                    'Enquadre o seu rosto no círculo indicado.\nAproxime-se ou afaste-se da câmera\nconforme necessário'),
                const Spacer(),
                UolletiButtonIcon(
                  icon: const Icon(Icons.arrow_forward),
                  label: 'Tirar foto',
                  preFixIcon: false,
                  onPressed: () async {
                    final photo =
                        await CoreNavigator.pushNamed(AppRoutes.cameraPage);
                    if (photo != null) {
                      const filename = 'photo.jpg';

                      final decodedBytes =
                          base64Decode((photo as String).split(',').last);

                      bloc.update(
                          level: 3,
                          formData: FormDataModel(level: 3, files: [
                            CustomMultipartFile.generateFile(
                                filename, decodedBytes)
                          ]));
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _info(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: colorsDS.iconsLight,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: UolletiText.contentMedium(
                text,
                textAlign: TextAlign.start,
              )),
        ),
      ],
    );
  }
}
