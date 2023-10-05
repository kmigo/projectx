// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



import 'package:micro_core/micro_core.dart';

import '../../blocs/update_kyc/bloc.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  String? document;
   String? birthDay;
   String? email;
   String? username;
  final bloc = CoreBinding.get<BlocUpdateKyc>();

  final formData =const  FormDataModel(data: {}, files: [], level: 1);
  List<Widget> inputs =[];
  @override
  void initState() {
    super.initState();
    bloc.getKyc();
    document = CorePageModal.queryParams[StringUtils.document];
    birthDay = CorePageModal.queryParams[StringUtils.birthDay];
    email = CorePageModal.queryParams[StringUtils.email];
    username = CorePageModal.queryParams[StringUtils.username];
    inputs = inputsList();

  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: UolletiAppBar(
        title: UolletiText.labelXLarge(
          'Dados pessoais',
          color: colorsDS.textDark,
          bold: true,
        ),
        backgroundColor: colorsDS.backgroundPure,
      ),
      body: BlocConsumer<BlocUpdateKyc, UpdateKycState>(
        bloc: bloc,
        listener: (context, state) {
          if(state.status == UpdateKycStatus.failure){
            showUolletiSnackbar(context, UolletiSnackbar.bottom(backgroundColor: colorsDS.buttonsDanger,
             title: UolletiText.contentLarge('${state.message}',color: colorsDS.textPure,), trailling: const SizedBox(), leading: const SizedBox()), const Duration(seconds: 3));
          }
        },
        builder: (context, state) {
          if(state.status == UpdateKycStatus.loading){
            return const Center(child: CircularProgressIndicator(),);
          }
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: Spacements.smallSpacement(context),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(Spacements.smallSpacement(context)),
                  child: ListView.separated(
                    itemBuilder: (ctx, index) {
                      return inputs[index];
                    },
                    separatorBuilder: (ctx, index) => SizedBox(
                      height: Spacements.smallSpacement(context),
                    ),
                    itemCount: inputs.length,
                  ),
                )),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Spacements.smallSpacement(context)),
                  child:  UolletiButtonIcon(
                      icon: const Icon(Icons.arrow_forward),
                      label: 'Salvar',
                      preFixIcon: false,
                      onPressed: email != null && username  != null ? null: (){
                        bloc.update(level: 1,formData: formData);
                      }),
                ),
                SizedBox(
                  height: Spacements.smallSpacement(context),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  inputsList() => [
        _PersonalTileDetail.fullname(
          initialText: username ,
          enabledText:  username == null,
          onChanged: (value) {
             formData.data['username']=value;
          },
          validator: HelperInputValidator.required,
        ),
        _PersonalTileDetail.cpf(
          onChanged: (value) {},
          validator: HelperInputValidator.cpf,
          initialText: document,
          enabledText: document == null,
        ),
        _PersonalTileDetail.birthdate(
          onChanged: (value) {},
          validator: HelperInputValidator.birthdate,
          initialText: birthDay,
          enabledText: birthDay == null,
        ),
        _PersonalTileDetail.country(['Brasil'],
            onChanged: (value) {},
            validator: HelperInputValidator.required,
            value: 'Brasil'),
        _PersonalTileDetail.email(
          initialText: email,
          enabledText: email == null,
          onChanged: (value) {
             formData.data['email']=value;
          },
          validator: HelperInputValidator.email,
        )
      ];
}

class _PersonalTileDetail extends StatelessWidget {
  final String title;
  final List<TextInputFormatter> inputFormatters;
  final ValueChanged<String> onChanged;
  final String? hintText;
  final String? Function(String?)? validator;
  final String? initialValue;
  final TextEditingController? controller;
  final bool? enabled;
  const _PersonalTileDetail(
      {required this.title,
      required this.inputFormatters,
      required this.onChanged,
      this.hintText,
      this.enabled,
      this.initialValue,
       this.controller,
      this.validator});
  _PersonalTileDetail.fullname(
      {required this.onChanged,
      this.validator,
      String? initialText,
      this.controller,
      bool? enabledText})
      : title = 'Nome completo',
        initialValue = initialText,
        enabled = enabledText,
        inputFormatters = [
  
        ],
        hintText = 'Digite seu nome completo';
  _PersonalTileDetail.cpf(
      {required this.onChanged,
      this.validator,
       this.controller,
      String? initialText,
      bool? enabledText})
      : title = 'CPF',
        initialValue = initialText,
        enabled = enabledText,
        inputFormatters = [CpfInputFormatter()],
        hintText = 'Digite seu CPF';
  _PersonalTileDetail.birthdate(
      {required this.onChanged,
      this.validator,
      String? initialText,
       this.controller,
      bool? enabledText})
      : title = 'Data de nascimento',
        initialValue = initialText,
        enabled = enabledText,
        inputFormatters = [DateInputFormatter()],
        hintText = 'Digite sua data de nascimento';
  _PersonalTileDetail.email(
      {required this.onChanged,
      this.validator,
      String? initialText,
       this.controller,
      bool? enabledText})
      : title = 'E-mail',
        initialValue = initialText,
        enabled = enabledText,
        inputFormatters = [],
        hintText = 'Digite seu e-mail';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UolletiText.contentMedium(
          title,
          bold: true,
          color: colorsDS.iconsDisabled,
        ),
        const SizedBox(
          height: 5,
        ),
        UolletiTextInput(
          hintText: hintText,
          controller: controller,
          onChanged: onChanged,
          initialValue: initialValue,
          enabled: enabled,
          validator: validator,
          inputFormatters: inputFormatters,
        )
      ],
    );
  }

  static Widget country(List<String> items,
      {required Function(String?) onChanged,
      required String? Function(String?)? validator,
      String? value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UolletiText.contentMedium(
          'Naciolanidade',
          bold: true,
          color: colorsDS.iconsDisabled,
        ),
        const SizedBox(
          height: 5,
        ),
        DropdownButtonFormField<String?>(
            value: value,
            validator: validator,
            hint: UolletiText.contentMedium('Selecione um país',
                color: colorsDS.textLight, bold: true),
            decoration: const InputDecoration(border: OutlineInputBorder()),
            selectedItemBuilder: (ctx) => items
                .map<Widget>((e) => UolletiText.contentMedium(
                      e,
                      bold: true,
                      color: colorsDS.textLight,
                    ))
                .toList(),
            items: items
                .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                    value: e,
                    child: UolletiText.contentMedium(
                      e,
                      bold: true,
                      color: colorsDS.textLight,
                    )))
                .toList(),
            onChanged: onChanged),
      ],
    );
  }
}
