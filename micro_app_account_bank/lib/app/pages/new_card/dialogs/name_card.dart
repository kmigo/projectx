import 'package:flutter/material.dart';
import 'package:micro_app_account_bank/app/blocs/new_card/bloc.dart';
import 'package:micro_app_account_bank/src/models/card.dart';
import 'package:micro_core/micro_core.dart';

class NameCardDialog extends StatefulWidget {
  final String userId;
  final String originAcountId;
  final String receiverAcountId;
  const NameCardDialog(
      {super.key,
      required this.originAcountId,
      required this.receiverAcountId,
      required this.userId});

  @override
  State<NameCardDialog> createState() => _NameCardDialogState();
}

class _NameCardDialogState extends State<NameCardDialog> {
  final TextEditingController _controller = TextEditingController();
  final NewCardBloc bloc = CoreBinding.get();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Spacer(),
                IconButton(
                    onPressed: () {
                      CoreNavigator.pop(false);
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            UolletiTextInput(
              label: 'Nome do cartão',
              controller: _controller,
              validator: HelperInputValidator.required,
              hintText: 'Aluguel da barra',
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<NewCardBloc, NewCardState>(
              bloc: bloc,
              listener: (context, state) {
                if(state.status == NewCardStatus.success){
                  CoreNavigator.pop(true);
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    UolletiButton.primary(
                      label: 'Criar',
                      isLoading: state.status == NewCardStatus.loading,
                      onPressed: () {
                        if(_formKey.currentState?.validate() == false){
                          return;
                        }
                        bloc.createCard(CardModel(originAccountId: widget.originAcountId, receiverAccountId: widget.receiverAcountId, name: _controller.text, userId: widget.userId));
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
