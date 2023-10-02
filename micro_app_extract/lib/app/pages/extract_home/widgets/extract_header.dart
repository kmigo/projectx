import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

import '../../../delegate/search_transaction_delegate.dart';

class ExtractHeaderWidget extends StatelessWidget {
  const ExtractHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const UolletiText.labelLarge('Extrato', bold: true),
          Row(
            children: [
              InkWell(child: const Icon(Icons.filter_list),
              onTap: (){
                CoreNavigator.pushNamed(AppRoutes.extract.filter);
              },
              ),
              const SizedBox(width: 15,),
              InkWell(
                onTap: () {
                  showSearch(context: context, delegate: SearchTransactionDelegate());
                },
                child: IgnorePointer(
                  ignoring: true,
                  child: SizedBox(
                    width: width * .35,
                    child:const Row(
                      children: [
                         Flexible(
                          child: UolletiTextInput(
                            hintText: 'Buscar',
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
