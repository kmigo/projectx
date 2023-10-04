import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_core/micro_core.dart';

class QueryPixKeyPage extends StatefulWidget {
  const QueryPixKeyPage({super.key});

  @override
  State<QueryPixKeyPage> createState() => _QueryPixKeyPageState();
}

class _QueryPixKeyPageState extends State<QueryPixKeyPage> {
  late String typeKey;
  final _formKey = GlobalKey<FormState>();
  late StringUtilsMethodsEnum typeKeyEnum;
  String keyPayment = '';
  @override
  void initState() {
    super.initState();
    typeKey = CorePageModal.queryParams[StringUtils.method] ?? StringUtilsMethodsEnum.random.name;
    typeKeyEnum = stringToEnumMethod(typeKey);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(
        title:  UolletiText.labelLarge('Consultar chave',color: colorsDS.textPure,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: colorsDS.backgroundMedium,
                        child: Icon(Icons.badge_outlined,color: colorsDS.backgroundPure,size: 32,),
                      ),
                      const SizedBox(height: 20,),
                      UolletiText.labelXLarge('Digite ou cole ${title(typeKeyEnum)} abaixo',bold: true,),
                      const SizedBox(height: 20,),
                      UolletiText.contentMedium(label(typeKeyEnum),color: colorsDS.textLight,),
                      const SizedBox(height: 10,),
                      UolletiTextInput(
                        inputFormatters: mask(typeKeyEnum),
                        validator: validator(typeKeyEnum),
                        onChanged: (value) {
                          keyPayment = value;
                          print(value);  
                        },
                        hintText: hint(typeKeyEnum),
                        keyboardType: keyboardType(typeKeyEnum),
                      )
                    ],
                  ),
                ),
              ),
              UolletiButtonIcon(
                label: 'Continuar',
                icon: Icon(Icons.arrow_forward,color: colorsDS.iconsPure,),
                priority: UolletiButtonPriority.primary,
                preFixIcon: false,
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    CoreNavigator.pushNamed("${AppRoutes.pixTransaction.reviewUserBeforeSendPix}?${StringUtils.method}=${typeKeyEnum.name}&${StringUtils.keyPayment}=$keyPayment");
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }


  String title(StringUtilsMethodsEnum typeKey,){
    switch(typeKey){
      case StringUtilsMethodsEnum.cpf:
        return 'o CPF';
      case StringUtilsMethodsEnum.cnpj:
        return 'o CNPJ';
      case StringUtilsMethodsEnum.email:
        return 'o Email';
      case StringUtilsMethodsEnum.phone:
        return 'o Telefone';
      case StringUtilsMethodsEnum.copyAndPaste:
        return 'a Chave copia e cola';
      case StringUtilsMethodsEnum.random:
      default:
        return 'a Chave aleatória';
    }
  }


  String label(StringUtilsMethodsEnum typeKey,){
    switch(typeKey){
      case StringUtilsMethodsEnum.cpf:
        return 'CPF';
      case StringUtilsMethodsEnum.cnpj:
        return 'CNPJ';
      case StringUtilsMethodsEnum.email:
        return 'Email';
      case StringUtilsMethodsEnum.phone:
        return 'Telefone';
      case StringUtilsMethodsEnum.copyAndPaste:
        return 'Pix Copia e Cola';
      case StringUtilsMethodsEnum.random:
      default:
        return 'Chave aleatória';
    }
  }

  List<TextInputFormatter> mask(StringUtilsMethodsEnum typeKey){
    switch(typeKey){
      case StringUtilsMethodsEnum.cpf:
        return [MaskInputFormatter(mask: "###.###.###-##")];
      case StringUtilsMethodsEnum.cnpj:
        return [const MaskedInputFormatter(mask: "##.###.###/####-##")];
      case StringUtilsMethodsEnum.email:
        return [];
      case StringUtilsMethodsEnum.phone:
        return [MaskInputFormatter(mask: "(##) #####-####")];
      case StringUtilsMethodsEnum.random:
      default:
        return [];
  }
  }


  String hint(StringUtilsMethodsEnum typeKey){
    switch(typeKey){
      case StringUtilsMethodsEnum.cpf:
        return "###.###.###-##";
      case StringUtilsMethodsEnum.cnpj:
        return  "##.###.###/####-##";
      case StringUtilsMethodsEnum.email:
        return "example@example.com";
      case StringUtilsMethodsEnum.phone:
        return "(##) #####-####";
      case StringUtilsMethodsEnum.random:
        return "12sd34sd5sdf67sdf8sd9sfd0";
      default:
        return "12sd34sd5sdf67sdf8sd9sfd0";
  }
  }

  String? Function(String?) validator(StringUtilsMethodsEnum typeKey){
    switch(typeKey){
      case StringUtilsMethodsEnum.cpf:
        return HelperInputValidator.cpf;
      case StringUtilsMethodsEnum.cnpj:
        return HelperInputValidator.cnpj;
      case StringUtilsMethodsEnum.email:
        return HelperInputValidator.email;
      case StringUtilsMethodsEnum.phone:
        return HelperInputValidator.phone;
      case StringUtilsMethodsEnum.random:
      default:
        return HelperInputValidator.required;
    }
  } 

  TextInputType keyboardType(StringUtilsMethodsEnum typeKey){
    switch(typeKey){
      case StringUtilsMethodsEnum.cpf:
        return TextInputType.number;
      case StringUtilsMethodsEnum.cnpj:
        return TextInputType.number;
      case StringUtilsMethodsEnum.email:
        return TextInputType.emailAddress;
      case StringUtilsMethodsEnum.phone:
        return TextInputType.phone;
      case StringUtilsMethodsEnum.random:
      default:
        return TextInputType.text;
    }
  }
}