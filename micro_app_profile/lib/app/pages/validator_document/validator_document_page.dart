import 'package:flutter/material.dart';
import 'package:micro_app_profile/app/pages/validator_document/widgets/choice_type_document_widget.dart';
import 'package:micro_app_profile/app/pages/validator_document/widgets/take_photo_front_document.dart';
import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';

import '../../../src/models/document_input_validator.dart';
import '../../blocs/update_kyc/bloc.dart';
import 'widgets/take_photo_back_document.dart';

class ValidatorDocumentPage extends StatefulWidget {
  const ValidatorDocumentPage({super.key});

  @override
  State<ValidatorDocumentPage> createState() => _ValidatorDocumentPageState();
}

class _ValidatorDocumentPageState extends State<ValidatorDocumentPage> {
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
          'Validar documento',
          bold: true,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<BlocUpdateKyc, UpdateKycState>(
        bloc: bloc,
        listener: (context, state) {
        if(state.status == UpdateKycStatus.failure){
            showUolletiSnackbar(context, UolletiSnackbar.bottomError( message: state.message!), const Duration(seconds: 3));
          }
        if(state.status == UpdateKycStatus.updated){
          CoreNavigator.pop(true);
          UolletiDialogs.dialogGenericState(true,onTap: () => CoreNavigator.pop());
        }
        },
        builder: (context, state) {
          if(state.status == UpdateKycStatus.loading){
            return const  Center(child: CircularProgressIndicator(),);
          }
          if(bloc.statusResponse(2) == KYCSTATUSRESPONSE.inReview){
            return Padding(
              padding:  const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24,),
                  CircleAvatar(
                    backgroundColor: colorsDS.iconsWarning,
                    child: Icon(Icons.description_outlined,size: 28,color: colorsDS.iconsPure,),
                  ),
                  const SizedBox(height: 18,),
                  UolletiText.labelXLarge('Documentos em análise',color: colorsDS.textBlack,bold: true,),
                  const SizedBox(height: 18,),
                  UolletiText.contentMedium('Seus documentos foram submetidos à uma análise e estão sendo verificados.',color: colorsDS.textLight,),
                  const SizedBox(height: 18,),
                  UolletiText.labelSmall('Você receberá um e-mail assim que o processo for concluído.',color: colorsDS.textPrimary,),
                  const Spacer(),
                  UolletiButton.primary(label: 'Voltar', onPressed: () => CoreNavigator.pop(),),
                  const SizedBox(height: 18,),
                ],
              ),
            );
          }
          if(bloc.statusResponse(2) == KYCSTATUSRESPONSE.completed){
            return Padding(
              padding:  const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24,),
                  CircleAvatar(
                    backgroundColor: colorsDS.iconsPositive,
                    child: Icon(Icons.description_outlined,size: 28,color: colorsDS.iconsPure,),
                  ),
                  const SizedBox(height: 18,),
                  UolletiText.labelXLarge('Documentos verificados',color: colorsDS.textBlack,bold: true,),
                  const SizedBox(height: 18,),
                  UolletiText.contentMedium('Seus documentos foram submetidos à uma análise e foram aprovados.',color: colorsDS.textLight,),
                  const SizedBox(height: 18,),
                  UolletiText.labelSmall('No momento, não é necessário tomar nenhuma ação.',color: colorsDS.textLight,),
                  const Spacer(),
                  UolletiButton.primary(label: 'Voltar', onPressed: () => CoreNavigator.pop(),),
                  const SizedBox(height: 18,),
                ],
              ),
            );
          }
         
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: FormField<DocumentInputValidator>(
                initialValue: const DocumentInputValidator(),
                builder: (stateField) {
                  if (isChoiceTypeDocument(stateField.value!)) {
                    return ChoiceTypeDocumentWidget(
                      onPressed: (value) =>
                          stateField.didChange(stateField.value!.copyWith(type: value)),
                      children: const [
                        ChoiceTypeRadioButton(
                          label: 'CNH (Carta de motorista)',
                          type: 'CNH',
                        ),
                        ChoiceTypeRadioButton(
                          label: 'RG (Identidade)',
                          type: 'RG',
                        ),
                        ChoiceTypeRadioButton(
                          label: 'RNE',
                          type: 'RNE',
                        ),
                      ],
                    );
                  } else if (isFrontDocument(stateField.value!)) {
                    return TakePhotoFrontDocument(
                      typeDocument: stateField.value!.type!,
                      onSuccess: (value) => stateField.didChange(
                          stateField.value!.copyWith(frontDocument: value)),
                    );
                  } else {
                    return TakePhotoBackDocument(
                      typeDocument: stateField.value!.type!,
                      onChange: (value) {
                        bloc.update(level: 2, formData: FormDataModel(level: 2,files: [stateField.value!.frontDocument!,value]));
                      },
                    );
                  }
                }),
          );
        },
      ),
    );
  }

  bool isChoiceTypeDocument(DocumentInputValidator documentModel) =>
      documentModel.type == null;
  bool isFrontDocument(DocumentInputValidator documentModel) =>
      documentModel.frontDocument == null;
  bool isBackDocument(DocumentInputValidator documentModel) =>
      documentModel.backDocument == null;
}
