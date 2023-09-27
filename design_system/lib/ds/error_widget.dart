part of 'ds.dart';

class UolletiErrorPage extends StatelessWidget {
  final VoidCallback onTapRetry;
  final VoidCallback onTapBack;
  final String? message;
  const UolletiErrorPage({super.key, required this.onTapBack, required this.onTapRetry,this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: const Color(0XFFFFC043).withOpacity(.32),
                      ),
                      const SizedBox(height: 15,),
                       UolletiText.labelXLarge( message ?? 'Estamos tendo dificuldades...',bold: true,),
                      const SizedBox(height: 10,),
                      const UolletiText.contentLarge('Verifique se sua conexão está boa e tente\nnovamente.',textAlign: TextAlign.center,)
          
          
                    ],
                  )),

                     SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: UolletiButton.positive(label: 'Voltar', onPressed: onTapBack,)),
                    const SizedBox(height: 10,),


                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: UolletiButton.primary(label: 'Tentar novamente', onPressed: onTapRetry)),
                ],
              ),
            )),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
