

import 'package:micro_core/micro_core.dart';

enum PagesRoot { home, statement }

class RootController extends GetxController {
  var currentPageRoot = PagesRoot.home.obs;
  changePage(PagesRoot newPage) {
    currentPageRoot.value = newPage;
  }
}
