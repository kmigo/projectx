import 'package:flutter/material.dart';
import 'package:micro_app_pix/app/blocs/review_user_before_send_pix/bloc.dart';

import 'package:micro_core/micro_core.dart';



class ReviewUserBeforeSendPixPage extends StatefulWidget {
  const ReviewUserBeforeSendPixPage({super.key});

  @override
  State<ReviewUserBeforeSendPixPage> createState() =>
      _ReviewUserBeforeSendPixPageState();
}

class _ReviewUserBeforeSendPixPageState
    extends State<ReviewUserBeforeSendPixPage> {
  final bloc = CoreBinding.get<ReviewUserBeforeSendPixBloc>();
  String? key;
  String? method;
  String? id;
  @override
  void initState() {
    super.initState();
    final query = Map.from(CorePageModal.queryParams);
    key = query[StringUtils.keyPayment];
    id = query[StringUtils.id];
    method = query[StringUtils.method];

    if (method != null && key != null) {
      
      bloc.fetchKey(
          method?.toLowerCase() == PaymentsType.qrcode.toLowerCase()
              ? method!
              : PaymentsType.pix,
          keyType(stringToEnumMethod(method!), key!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(
        title: UolletiText.labelLarge(
          'Enviar PIX',
          color: colorsDS.textPure,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<ReviewUserBeforeSendPixBloc, ReviewUserBeforeSendPixState>(
          bloc: bloc,
          builder: (context, state) {
            if(state.status == ReviewUserBeforeSendPixStatus.loading){
              return const Center(child: CircularProgressIndicator(),);
            }
            if(state.status == ReviewUserBeforeSendPixStatus.failure){
              return UolletiErrorPage(onTapBack: (){
                CoreNavigator.pop();
              }, onTapRetry: (){
                bloc.fetchKey(
                    method?.toLowerCase() == PaymentsType.qrcode.toLowerCase()
                        ? method!
                        : PaymentsType.pix,
                    keyType(stringToEnumMethod(method!), key!));

              });
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        backgroundColor: colorsDS.backgroundMedium,
                        radius: 30,
                        child: Icon(Icons.send_outlined,
                            size: 30, color: colorsDS.iconsPure)),
                    const SizedBox(
                      height: 20,
                    ),
                    const UolletiText.labelXLarge('Confirme quem receberá'),
                    const SizedBox(
                      height: 20,
                    ),
                    _rowTile('Para', state.validateKeyEntity?.owner.name ?? ''),
                    const SizedBox(
                      height: 20,
                    ),
                    _rowTile(titleCpfOrCnpj(state.validateKeyEntity?.key ?? ''), maskText(state.validateKeyEntity?.key ?? '')),
                    const SizedBox(
                      height: 20,
                    ),
                    _rowTile('Data de envio', 'Hoje'),
                  ],
                ))),
                UolletiButton.outline(
                  label: 'Cancelar',
                  prefixIcon: const Icon(Icons.backspace_outlined),
                  onPressed: () {
                    CoreNavigator.pop();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                UolletiButton.positive(
                  label: 'Continuar',
                  disabled: state.validateKeyEntity == null,
                  suffixIcon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    CoreNavigator.popUntil(AppRoutes.accountBank.registerBankReceiver,KeyPixTypeModel(key: key!, type: method!));
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }

  _rowTile(String title, String subtitle) {
    return Row(
      children: [
        Expanded(
            child: UolletiText.contentMedium(
          title,
          color: colorsDS.textLight,
          textAlign: TextAlign.start,
        )),
        Expanded(
            child: UolletiText.contentMedium(
          subtitle,
          textAlign: TextAlign.start,
        ))
      ],
    );
  }
  String maskText(String text){
    if(text.isEmpty) return text;
    if(HelperValidator.isCPF(text)){
      return HelperMask.cpf(text);
    }
    if(HelperValidator.isCNPJ(text)){
      return HelperMask.cnpj(text);
    }
    return text;
  }

  String titleCpfOrCnpj(String text){

    if(HelperValidator.isCPF(text)){
      return 'CPF';
    }
    if(HelperValidator.isCNPJ(text)){
      return "CNPJ";
    }
    return "Documento";
  }

  String keyType(StringUtilsMethodsEnum typeKey, String key) {
    switch (typeKey) {
      case StringUtilsMethodsEnum.phone:
      case StringUtilsMethodsEnum.cnpj:
      case StringUtilsMethodsEnum.cpf:
        return key.replaceAll(RegExp(r'\D'), "");
      default:
        return key;
    }
  }
}
