import 'package:flutter/material.dart';
import 'package:micro_app_pix/src/args/key_pix_type.dart';
import 'package:micro_core/micro_core.dart';

class RegisterPixPage extends StatefulWidget {
  const RegisterPixPage({super.key});

  @override
  State<RegisterPixPage> createState() => _RegisterPixPageState();
}

class _RegisterPixPageState extends State<RegisterPixPage> {
  String? id;
  String? method;
  String? keyPayment;
  late bool update;
  TextEditingController _keyController = TextEditingController();
  @override
  void initState() {
    super.initState();
    id = CorePageModal.queryParams[StringUtils.id];
    method = CorePageModal.queryParams[StringUtils.method];
    keyPayment = CorePageModal.queryParams[StringUtils.keyPayment];
    update = id?.isNotEmpty == true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(
        title: UolletiText.labelLarge(
          update ? 'Atualizar PIX CARD' : 'Novo PIX CARD',
          color: colorsDS.textPure,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pix,size: 30,color: colorsDS.backgroundMedium,),
                  const SizedBox(width: 10,),
                  UolletiText.labelXLarge('Informações de contato',bold: true,color: colorsDS.backgroundMedium,)
                ],
              ),
              const SizedBox(height: 20,),
              const UolletiTextInput(
                label: 'Nome do cartão',
                hintText: 'Aluguel Barra',
              ),
              const SizedBox(height: 20,),
              const UolletiText.labelLarge('Tipo de beneficiario',bold: true,),
              const SizedBox(height: 10,),
              UolletiDropDown(items: const ['Pessoa Júridica','Pessoa Fisica'], onChanged: (choice){}, onChild: (value) => UolletiText.labelMedium(value),),
              const SizedBox(height: 20,),
             const  UolletiTextInput(
                label: 'Nome do beneficiario',
                hintText: 'Thomas Edison',
              ),
              const SizedBox(height: 20,),
               const UolletiText.labelLarge('Tipo de chave PIX',bold: true,),
              const SizedBox(height: 10,),
              InkWell(
                onTap: _setKey,
                child: IgnorePointer(
                  ignoring: true,
                  child: UolletiDropDown(items: const ['CPF','CHAVE ALEATORIA','CNPJ',"TELEFONE","EMAIL"], onChanged: (choice){}, onChild: (value) => UolletiText.labelMedium(value),value: _typeKey(),)),
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: _setKey,
                child:  IgnorePointer(
                  ignoring: true,
                  child: UolletiTextInput(
                    label: 'Chave PIX',
                    hintText: '123.456.789-10',
                    controller: _keyController,
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              UolletiButton.primary(label: 'CRIAR', onPressed: ()async{

              }),


            ],
          ),
        ),
      ),
    );
  }

  void _setKey()async{
    await CoreNavigator.pushNamed(AppRoutes.pixTransaction.selectKeys);
    if(CorePageModal.args is KeyPixType){
      final args =(CorePageModal.args as KeyPixType);
      setState(() {
        keyPayment = args.key;
        method = args.type;
        _keyController.text = keyPayment!;
      });
    }
  }
String? _typeKey(){
  if(method == null) return null;
  final type = stringToEnumMethod(method!);
  switch(type){
    case StringUtilsMethodsEnum.cpf:
      return 'CPF';
    case StringUtilsMethodsEnum.cnpj:
      return 'CNPJ';
    case StringUtilsMethodsEnum.email:
      return 'EMAIL';
    case StringUtilsMethodsEnum.phone:
      return 'TELEFONE';
    case StringUtilsMethodsEnum.random:
      return 'CHAVE ALEATORIA';
    default:
      return null;
  }
}
  
}