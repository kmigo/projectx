import 'package:flutter/material.dart';
import 'package:micro_commons_user/micro_commons_user.dart';
import 'package:micro_core/micro_core.dart';
class CreatePincodeUserPage extends StatefulWidget {
  const CreatePincodeUserPage({super.key});

  @override
  State<CreatePincodeUserPage> createState() => _CreatePincodeUserPageState();
}

class _CreatePincodeUserPageState extends State<CreatePincodeUserPage> {


  String? phone;

  @override
  void initState() {
    super.initState();
    phone = CorePageModal.queryParams[StringUtils.phone];
  }

  @override
  Widget build(BuildContext context) {
    return CreatePincodePage(
      phone: phone ,
      onContinue: (){
        CoreNavigator.pushNamedAndRemoveUntil(AppRoutes.home.root, ModalRoute.withName(AppRoutes.root));
      },
    );
  }
}