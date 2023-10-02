

import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

import '../../../../src/domain/entities/transactions.dart';


class StyleTransaction extends StatelessWidget {
  final Widget icon;
  final Widget title;
  final Widget subtitle;
  final Widget amount;
  final Widget date;
  final bool showReceipt;
  final TransactionEntity transaction;
  const StyleTransaction({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.transaction,
    this.showReceipt = false,
  });
  StyleTransaction.send({
    super.key,
    required this.transaction,
  })  : icon =  CircleAvatar(
    radius: 40,
    backgroundColor: colorsDS.bordersMedium,
    child: Icon(Icons.send_outlined,color:colorsDS.iconsOutlined),
  ),
        title = const  UolletiText.labelMedium('Enviado',bold: true,),
        subtitle =  UolletiText.contentSmall(transaction.receiver.name,priority: UolletiTextPriority.textLight,),
        amount =  UolletiText.contentMedium('- R\$ ${transaction.amount.toStringAsFixed(2).replaceAll('.', ',')}',priority: UolletiTextPriority.warning,),
        date =  _DateWidget.fromTransaction(transaction),

        showReceipt = true;


  StyleTransaction.receive({
    super.key,
    required this.transaction,
  })  : icon =  CircleAvatar(
    radius: 40,
    backgroundColor: colorsDS.bordersMedium,
    child: Icon(Icons.savings_outlined,color:colorsDS.iconsOutlined),
  ),
        title = const  UolletiText.labelMedium('Recebido',bold: true,),
        subtitle =  UolletiText.contentSmall(transaction.receiver.name,priority: UolletiTextPriority.textLight,),
        amount =  UolletiText.contentMedium('R\$ ${transaction.amount.toStringAsFixed(2).replaceAll('.', ',')}',color: colorsDS.textPositive,),
        date = _DateWidget.fromTransaction(transaction),
        showReceipt = true;
  
  StyleTransaction.recharge({
    super.key,
    required this.transaction,
  })  : icon =  CircleAvatar(
    radius: 40,
    backgroundColor: colorsDS.bordersMedium,
    child: Icon(Icons.install_mobile,color:colorsDS.iconsOutlined),
  ),
        title = const  UolletiText.labelMedium('Recarga de celular',bold: true,),
        subtitle =  const UolletiText.contentSmall('Operadora',priority: UolletiTextPriority.textLight,),
        amount =  UolletiText.contentMedium('- R\$ ${transaction.amount.toStringAsFixed(2).replaceAll('.', ',')}',color: colorsDS.textPositive,),
        date =  _DateWidget.fromTransaction(transaction),
        showReceipt = true;

  factory StyleTransaction.fromTransaction(
    TransactionEntity transaction,
  ) {
    switch(transaction.action){
      case TransactionAction.cashIn:
        return StyleTransaction.receive(transaction: transaction);
      case TransactionAction.cashOut:
        return StyleTransaction.send(transaction: transaction);
      default:
        return StyleTransaction.send(transaction: transaction);
    }
  }
  @override
  Widget build(BuildContext context) {
    final transactionType = transaction.action == TransactionAction.cashOut ? StringUtils.sendMethod:StringUtils.receiveMethod ;
    return ListTile(
      leading: icon,
      title: title,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,),
          subtitle,
          const SizedBox(
            height: 8,),
          if(showReceipt)...[
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                  decoration: BoxDecoration(
                    color: colorsDS.bordersMedium,
                    border: Border.all(color: colorsDS.bordersDark ),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: InkWell(
                    onTap: ()=> CoreNavigator.pushNamed('${AppRoutes.extract.extractDetail}?${StringUtils.transactionId}=${transaction.id}&${StringUtils.method}=$transactionType'),
                    child: const Row(
                      children:  [
                         Icon(Icons.sticky_note_2_outlined,size: 15,color: Colors.black,),
                         SizedBox(width: 5,),
                         UolletiText.captionMedium('Ver comprovante',bold: true,)
                      ],
                    ),
                  ),
                ),
              ],
            )
          ]
        ],
      ),
      trailing: Column(
        mainAxisAlignment:MainAxisAlignment.center ,
        children: [date,
        const SizedBox(
          height: 8,),
         amount],
      ),
    );
  }
}


class _DateWidget extends StatelessWidget {
  final Widget child;
  const _DateWidget({required this.child});

    _DateWidget.complete({required TransactionEntity transaction})
      : child =   UolletiText.captionLarge(HelperDate.getDayMonthName(DateTime.fromMillisecondsSinceEpoch(transaction.createdAt.toInt())).replaceAll(' ', ' de '),priority: UolletiTextPriority.textLight,);
    _DateWidget.processing({required TransactionEntity transaction})
      : child =   IntrinsicWidth(
        child: Row(
        children:  [
          UolletiText.captionXLarge('Processando',color: colorsDS.textWarning,bold: true,),
          const SizedBox(width: 5,),
          Icon(Icons.help,color: colorsDS.iconsWarning,size: 15,)
        ],
      ),
      );
    _DateWidget.cancel({required TransactionEntity transaction})
      : child =   IntrinsicWidth(
        child: Row(
        children:  [
           UolletiText.captionXLarge('Cancelada',color: colorsDS.textPrimary,bold: true,),
           const SizedBox(width: 5,),
           Icon(Icons.help,color: colorsDS.iconsLight,size: 15,)
        ],
            ),
      );
  factory _DateWidget.fromTransaction(
    TransactionEntity transaction,
  ) {

    switch(transaction.status){
      case TransactionUtilsStatus.completed:
        return _DateWidget.complete(transaction: transaction);
      case TransactionUtilsStatus.processing:
        return _DateWidget.processing(transaction: transaction);
      case TransactionUtilsStatus.canceled:
        return _DateWidget.cancel(transaction: transaction);
      default:
        return _DateWidget.complete(transaction: transaction);
    }
  }
  @override
  Widget build(BuildContext context) {
    return child;
  }
}
