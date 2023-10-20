import 'package:flutter/material.dart';
import 'package:micro_app_account_bank/app/blocs/new_card/bloc.dart';
import 'package:micro_app_account_bank/src/models/card.dart';
import 'package:micro_core/micro_core.dart';

class NameCardDialog extends StatefulWidget {
  final String userId;
  final String originAcountId;
  final String receiverAcountId;
  final bool updated;
  final String? nameCard;
  final Function(String) onUpdated;
  const NameCardDialog(
      {super.key,
      required this.originAcountId,
      required this.receiverAcountId,
       this.nameCard,
      required this.updated,
      required this.onUpdated,
      required this.userId});

  @override
  State<NameCardDialog> createState() => _NameCardDialogState();
}

class _NameCardDialogState extends State<NameCardDialog> {
  final TextEditingController _controller = TextEditingController();
  final NewCardBloc bloc = CoreBinding.get();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _controller.text = widget.nameCard ?? "";
  }

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
              initialValue: widget.nameCard,
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
                    if(state.status == NewCardStatus.error)...[
                      Text(
                        state.message ?? "",
                        style: const TextStyle(color: Colors.red))],
                    UolletiButton.primary(
                      label: widget.updated? "Atualizar" : 'Criar',
                      isLoading: state.status == NewCardStatus.loading,
                      onPressed: () {
                        if(_formKey.currentState?.validate() == false){
                          return;
                        }
                        if(widget.updated){
                          widget.onUpdated(_controller.text);
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
