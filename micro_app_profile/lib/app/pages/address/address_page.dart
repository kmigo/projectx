// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_commons_user/micro_commons_user.dart';

import 'package:micro_core/micro_core.dart';

import '../../blocs/address_page/bloc.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final AuthenticationBloc bloc = CoreBinding.get<AuthenticationBloc>();
  final AddressBloc addressBloc = CoreBinding.get<AddressBloc>();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController complementController = TextEditingController();
  final TextEditingController districtController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: UolletiAppBar(
          backgroundColor: colorsDS.backgroundPure,
          title: const UolletiText.labelXLarge(
            'Endereço',
            bold: true,
          ),
        ),
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          bloc: bloc,
          listener: (context, authenticationState) {},
          builder: (context, authenticationState) {
            if (authenticationState.status.user == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final address = AddressModel.fromMap(
                authenticationState.status.user?.address?.toMap() ??
                    const AddressModel().toMap());
            addressBloc.updateAddress(address);
            if(authenticationState.status.user?.address != null){
              cepController.text = address.cep ?? '';
              streetController.text = address.street ?? '';
              numberController.text = address.number ?? '';
              complementController.text = address.complement ?? '';
              districtController.text = address.district ?? '';
            }

            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: BlocConsumer<AddressBloc, AddressState>(
                  bloc: addressBloc,
                  listener: (context, state) {
                    if (state.status == AddressStatus.success) {
                      CoreNavigator.pop(true);
                    }
                  },
                  builder: (context, state) {
                   final items = inputs(state);

                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Spacements.smallSpacement(context)),
                      child: ListView.separated(
                          itemBuilder: (context, index) => items[index],
                          separatorBuilder: (ctx, i) => SizedBox(
                                height: Spacements.smallSpacement(context),
                              ),
                          itemCount: items.length),
                    );
                  },
                )),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Spacements.smallSpacement(context),
                      vertical: 10),
                  child: UolletiButtonIcon(
                    icon: const Icon(Icons.arrow_forward),
                    label: 'Salvar',
                    preFixIcon: false,
                    onPressed: () {
                      addressBloc.save(authenticationState.status.user!.id);
                    },
                  ),
                ),
                SizedBox(
                  height: Spacements.smallSpacement(context),
                )
              ],
            );
          },
        ));
  }

  List<Widget> inputs(AddressState state) => [
        _PersonalTileDetail.cep(
          //initialValue: state.address.cep,
          controller: cepController,
          onChanged: (value) {
            addressBloc.updateAddress(state.address.copyWith(cep: value));
          },
          validator: HelperInputValidator.cep,
        ),
        _PersonalTileDetail(
          title: 'Logradouro(Rua, avenida...)',
          onChanged: (value) {
            addressBloc.updateAddress(state.address.copyWith(street: value));
          },
          hintText: 'Rua lauro maia',
          controller: streetController,
          initialValue: state.address.street,
          validator: HelperInputValidator.required,
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                  child: _PersonalTileDetail(
                title: 'Número',
                onChanged: (value) {
                  addressBloc
                      .updateAddress(state.address.copyWith(number: value));
                },
                initialValue: state.address.number,
                controller: numberController,
                validator: HelperInputValidator.required,
              )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: _PersonalTileDetail(
                title: 'Complemento',
                controller: complementController,
                initialValue: state.address.complement,
                onChanged: (value) {
                  addressBloc
                      .updateAddress(state.address.copyWith(complement: value));
                },
                validator: HelperInputValidator.required,
              )),
            ],
          ),
        ),
        _PersonalTileDetail(
          title: 'Bairro',
          controller: districtController,
          initialValue: state.address.district,
          onChanged: (value) {
            addressBloc.updateAddress(state.address.copyWith(district: value));
          },
          validator: HelperInputValidator.required,
          hintText: 'Centro',
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                  child: _PersonalTileDetail.dropdown(['São paulo'],
                      onChanged: (value) {
                addressBloc.updateAddress(
                    state.address.copyWith(state: value, city: null));
              },
                      value: state.address.state,
                      validator: HelperInputValidator.required,
                      title: 'Estado')),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: _PersonalTileDetail.dropdown(['São paulo'],
                      onChanged: (value) {
                addressBloc.updateAddress(state.address.copyWith(city: value));
              },
                      value: state.address.city,
                      validator: HelperInputValidator.required,
                      title: 'Cidade')),
            ],
          ),
        )
      ];
}

class _PersonalTileDetail extends StatelessWidget {
  final String title;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool? enabled;
  const _PersonalTileDetail(
      {required this.title,
      this.inputFormatters,
      this.initialValue,
      required this.onChanged,
      this.controller,
      this.hintText,
      this.enabled,
      this.validator});
  _PersonalTileDetail.cep(
      {required this.onChanged,
      this.validator,
      this.controller,
      this.initialValue,
      this.enabled})
      : title = 'CEP',
        inputFormatters = [CepInputFormatter()],
        hintText = 'Digite seu cep';

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
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
          Flexible(
            child: UolletiTextInput(
              initialValue: initialValue,
              hintText: hintText,
              controller: controller,
              onChanged: onChanged,
              validator: validator,
              inputFormatters: inputFormatters,
            ),
          )
        ],
      ),
    );
  }

  static Widget dropdown(List<String> items,
      {required Function(String?) onChanged,
      required String title,
      required String? Function(String?)? validator,
      String? value}) {
    return IntrinsicHeight(
      child: Column(
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
          Flexible(
            child: DropdownButtonFormField<String?>(
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
          ),
        ],
      ),
    );
  }
}
