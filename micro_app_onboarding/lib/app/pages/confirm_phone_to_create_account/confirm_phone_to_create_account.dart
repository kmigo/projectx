

import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

class ConfirmPhoneToCreatedAccount extends StatefulWidget {
  const ConfirmPhoneToCreatedAccount({super.key});

  @override
  State<ConfirmPhoneToCreatedAccount> createState() => _ConfirmPhoneToCreatedAccount();
}

class _ConfirmPhoneToCreatedAccount extends State<ConfirmPhoneToCreatedAccount> {

  final List<PhoneItemConfigModel> phones =[];
  final phoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    phones.addAll(PhoneItemsConfigModel.fromMap(EnvironmentVariables.getRemoteConfigMap(RemoteConfigVars.phones)).phones);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(),
      body: Column(
        children: [

          SizedBox(
            height: ScreenSize.getHeight(context) * 0.05,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ScreenSize.getWidth(context) * 0.05,
                right: ScreenSize.getWidth(context) * 0.05),
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
                  children:  [
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
                  children:  [
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
                  height: ScreenSize.getHeight(context) * 0.08,
                  child:  FormField<PhoneItemConfigModel>(
                    builder: (state) {
                      return Row(
                        children: [
                            UolletiDropDownSimple<PhoneItemConfigModel>(
                              value: state.value,
                              items: phones, onChanged: (value){
                                
                                state.didChange(value);
                                phoneController.clear();
                              }, onChild: (value) => Center(child: UolletiText("${value.code} ${value.abbreviation}")),
                isExpanded: false,
                ),
                          const SizedBox(width: 8,),
                          Flexible(
                            child: UolletiTextInput(
                              controller: phoneController,
                              hintText: state.value?.hint,
                              inputFormatters: [MaskedInputFormatter(mask: state.value?.mask ?? '(##) #####-####')],
                              customKeyboardType: UolletiKeyboardType.numericWithoutObserver,
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                )
              ],
            ),
          ),
          Expanded(child: Container()),

        ],
      ),
    );
  }
}
