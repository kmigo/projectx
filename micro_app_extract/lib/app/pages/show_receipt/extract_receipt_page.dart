// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_core/micro_core.dart';

import '../../../src/domain/entities/transactions.dart';
import '../../blocs/transaction_bloc/bloc.dart';
import 'widgets/alert_report.dart';
import 'widgets/bottom_sheet_report.dart';

class ExtractReceiptPage extends StatefulWidget {
  const ExtractReceiptPage({super.key});

  @override
  State<ExtractReceiptPage> createState() => _ExtractReceiptPageState();
}

class _ExtractReceiptPageState extends State<ExtractReceiptPage> {
  String? idTransaction;
  bool sendTransaction = false;
  final bloc = CoreBinding.get<TransactionBloc>();

  @override
  void initState() {
    super.initState();
    idTransaction = CorePageModal.queryParams[StringUtils.transactionId];
    if (idTransaction == null) {
      CoreNavigator.popUntil(AppRoutes.home.root);
    } else {
      bloc.getTransactionId(idTransaction!);
    }
    sendTransaction =
        CorePageModal.queryParams[StringUtils.method] == StringUtils.sendMethod;
  }

  @override
  Widget build(BuildContext context) {
    const spacing = 8.0;
    return BlocBuilder<TransactionBloc, TransactionState>(
      bloc: bloc,
      builder: (context, state) {
        if (state.status == TransactionStatus.loading ||
            state.status == TransactionStatus.idle) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == TransactionStatus.error) { 
          return UolletiErrorPage(
            onTapRetry: () => bloc.getTransactionId(idTransaction!),
            message: state.error,
            onTapBack: (){
              CoreNavigator.pop();

            },
          );
        }
        return Scaffold(
          appBar: UolletiAppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _StatusWidget.fromTransaction(state.entity!),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const UolletiText.labelMedium(
                        'Detalhes',
                        bold: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _TileInfoColum.onlyTitleAndSubtitle(
                        title: 'Valor enviado',
                        subtitle:
                            "R\$ ${state.entity!.amount.toStringAsFixed(2).replaceAll('.', ',').padLeft(2, '0')}",
                      ),
                      const SizedBox(
                        height: spacing,
                      ),
                      _TileInfoColum.onlyTitleAndSubtitle(
                        title: 'Data e hora',
                        subtitle: HelperDate.getFormattedDate(
                            DateTime.fromMillisecondsSinceEpoch(
                                state.entity!.createdAt.toInt()),
                            pattern: 'dd/MM/yyyy HH:mm').replaceAll(' ', ' às  '),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      _TileInfoColum.onlyTitleAndSubtitle(
                        title: 'Realizado por',
                        subtitle: state.entity!.payer.name,
                      ),
                      const SizedBox(
                        height: spacing,
                      ),
                      if (sendTransaction) ...[
                        _TileInfoColum.tileAndSubtitleCopyInfo(
                          title: 'Numero do comprovante',
                          subtitle: state.entity!.id,
                          infoToCopy: state.entity!.id.toString(),
                        ),
                        const SizedBox(
                          height: spacing,
                        ),
                        Divider(
                          color: colorsDS.bordersDark,
                        ),
                        const UolletiText.labelMedium(
                          'Recebido por',
                          bold: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _TileInfoColum.onlyTitleAndSubtitle(
                          title: 'Nome',
                          subtitle: state.entity!.receiver.name,
                        ),
                        const SizedBox(
                          height: spacing,
                        ),
                        _TileInfoColum.onlyTitleAndSubtitle(
                          title: 'CPF/CNPJ',
                          subtitle: state.entity!.receiver.document,
                        ),
                        const SizedBox(
                          height: spacing,
                        ),
                      ] else ...[
                        _TileInfoColum.onlyTitleAndSubtitle(
                          title: 'CPF/CNPJ',
                          subtitle: state.entity!.receiver.document,
                        ),
                        const SizedBox(
                          height: spacing,
                        ),
                        _TileInfoColum.tileAndSubtitleCopyInfo(
                          title: 'Numero do comprovante',
                          subtitle: state.entity!.id,
                          infoToCopy: state.entity!.id.toString(),
                        ),
                        const SizedBox(
                          height: spacing,
                        ),
                      ],
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.report_outlined,
                            color: colorsDS.iconsDanger,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: (){
                              showModalBottomSheet(
                                backgroundColor: Colors.white,
                                shape:const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                                context: context, builder: (ctx) =>  ReportBottomSheet(onConfirm: (report){
                                  showDialog(context: context, builder: (ctx) => const AlertDialog(
                                    content: AlertDoneReport(),
                                  ));
                                },));
                            },
                            child: UolletiText.labelSmall(
                              'Reportar um problema',
                              bold: true,
                              color: colorsDS.iconsDanger,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  UolletiExtraLargeIconButton.outlined(
                    onPressed: (){
                      CoreNavigator.pop();
                    },
                      icon: Icon(
                        Icons.undo,
                        size: 32,
                        color: colorsDS.bordersDark,
                      ),
                      label: 'Voltar'),
                  UolletiExtraLargeIconButton.fill(
                    icon: SvgPicture.asset(
                      'files/share.svg',
                    ),
                    label: 'Compartilhar',
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TileInfoColum extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  const _TileInfoColum(
      {required this.title, required this.subtitle, this.trailing});

  _TileInfoColum.onlyTitleAndSubtitle(
      {required String title, required String subtitle})
      : title = UolletiText.contentSmall(
          title,
          color: colorsDS.textLight,
        ),
        subtitle = UolletiText.captionXLarge(
          subtitle,
          bold: true,
        ),
        trailing = null;

  _TileInfoColum.tileAndSubtitleCopyInfo(
      {required String title,
      required String subtitle,
      required String infoToCopy})
      : title = UolletiText.contentSmall(
          title,
          color: colorsDS.textLight,
        ),
        subtitle = subtitle.isNotEmpty
            ? UolletiText.captionXLarge(
                subtitle,
                bold: true,
              )
            : null,
        trailing = Padding(
          padding: const EdgeInsets.only(left: 60),
          child: InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: infoToCopy));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colorsDS.bordersDark),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.copy,
                    color: colorsDS.bordersDark,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  UolletiText.captionMedium(
                    'Copiar',
                    color: colorsDS.textLight,
                  ),
                ],
              ),
            ),
          ),
        );

  @override
  Widget build(BuildContext context) {
    if (subtitle == null) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            if (subtitle != null) subtitle!,
            if (trailing != null) trailing!,
          ],
        )
      ],
    );
  }
}

class _StatusWidget extends StatelessWidget {  
  final Widget icon;
  final Widget title;
  final Widget subtitle;
  const _StatusWidget({super.key,required this.icon,required this.subtitle, required this.title});

  _StatusWidget.processing(): icon=CircleAvatar(
    radius: 32,
    backgroundColor: colorsDS.bordersMedium, 
    child: Icon(Icons.hourglass_empty_outlined,color: colorsDS.iconsWarning,size: 32,),
  ),title=const UolletiText.labelMedium('Transação em processando',bold: true,),subtitle=  RichText(
    textAlign: TextAlign.center,
    text:TextSpan(
    children: [
      TextSpan(text: 'Aguarde a confirmação dos bancos envolvidos para\nliberação do valor. O prazo é de',style: TextStyle(color: colorsDS.textOutlined,fontSize: 12,)),
      TextSpan(text: ' até 3 dias úteis.',style: TextStyle(color: colorsDS.textOutlined,fontSize: 12,fontWeight: FontWeight.bold)),
    ]
  ) );
_StatusWidget.canceled(): icon=CircleAvatar(
    radius: 32,
    backgroundColor: colorsDS.bordersMedium, 
    child: Icon(Icons.block,color: colorsDS.iconsDanger,size: 32,),
  ),title=const UolletiText.labelMedium('Transação cancelada',bold: true,),subtitle=  RichText(
    textAlign: TextAlign.center,
    text:TextSpan(
    children: [
      TextSpan(text: 'Houve algum erro no processamento desta\ntransação. O saldo da sua conta ',style: TextStyle(color: colorsDS.textOutlined,fontSize: 12,)),
      TextSpan(text: ' não ',style: TextStyle(color: colorsDS.textOutlined,fontSize: 12,fontWeight: FontWeight.bold)),
       TextSpan(text: 'será afetado\npor este cancelamento.',style: TextStyle(color: colorsDS.textOutlined,fontSize: 12,)),
    ]
  ) );

  static fromTransaction(TransactionEntity transactionEntity){
    switch(transactionEntity.status){
      case TransactionUtilsStatus.canceled:
      return _StatusWidget.canceled();
      case TransactionUtilsStatus.processing:
      return _StatusWidget.processing();
      default:
      return const SizedBox();
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10,),
          icon,
          const SizedBox(height: 10,),
          title,
          const SizedBox(height: 15,),
          subtitle
        ],
      ),
    );
  }
}