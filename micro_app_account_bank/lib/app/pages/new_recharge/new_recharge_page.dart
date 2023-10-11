import 'package:flutter/material.dart';
import 'package:micro_app_account_bank/src/domain/entities/account_bank_origin.dart';
import 'package:micro_core/micro_core.dart';

import '../../../src/domain/entities/account_bank_receiver.dart';
import '../../blocs/list_accounts_bank/bloc.dart';

class NewRechargePage extends StatefulWidget {
  const NewRechargePage({super.key});

  @override
  State<NewRechargePage> createState() => _NewRechargePageState();
}

class _NewRechargePageState extends State<NewRechargePage> {
  final bloc = CoreBinding.get<ListAccountsBankBloc>();

  @override
  void initState() {
    super.initState();
    bloc.getAllAccountsBank();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UolletiAppBar(
        title:  UolletiText.labelXLarge('Revisar recarga',color: colorsDS.textPure,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: BlocConsumer<ListAccountsBankBloc, ListAccountBankState>(
            bloc: bloc,
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if(state.status == ListAccountsBankStatus.loading){
                return const Center(child: CircularProgressIndicator(),);
              }
              final receivers = state.receivers;
              final origins = state.origins;
              return Column(
                children: [
                  const UolletiText.labelXLarge('Nova Recarga'),
                  const SizedBox(
                    height: 20,
                  ),
                   const UolletiText.labelLarge('Conta de origem'),
                  UolletiDropDown<AccountBankOriginEntity>(items: origins, 
                  onChanged: (value){

                  }, onChild: (value) => UolletiText.labelLarge(value.bankName)),
                  const SizedBox(
                    height: 20,
                  ),
                  const UolletiText.labelLarge('Conta de destino'),
                  UolletiDropDown<AccountBankReceiverEntity>(items: receivers, 
                  onChanged: (value){
                    
                  }, onChild: (value) => UolletiText.labelLarge(value.tagName)),
                  const SizedBox(
                    height: 20,
                  ),
                  UolletiSliderButton(
                    onTap: (){},
                    text: "Arraste para confirmar",
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
