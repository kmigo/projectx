// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_element


import 'package:flutter/material.dart';
import 'package:micro_commons_user/micro_commons_user.dart';

import 'package:micro_core/micro_core.dart';

import '../blocs/get_kyc/bloc.dart';
import '../widgets/bottom_sheet_photo.dart';
import '../widgets/dialog_exit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final bloc = CoreBinding.get<BlocUserKyc>();
  @override
  void initState() {
    super.initState();
    bloc.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('files/logo.png'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: colorsDS.primary900,
      ),
      body: BlocConsumer<BlocUserKyc, KycState>(
        bloc: bloc,
        listener: (context, state) {

        },
        builder: (context, state) {
          if ([KycStatus.idle, KycStatus.loading].contains(state.status)) {
            return  const Center(
              child: CircularProgressIndicator(),
            );
          }
          final itemsData = items(state.user);
          return Column(
            children: [
              const _HeaderWidget(),
              Expanded(
                  child: Padding(
                padding:
                    const EdgeInsets.only(top: 18.0, right: 15.0, left: 15.0),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: itemsData.length,
                  itemBuilder: (context, index) {
                    final item = itemsData[index];
                    final hasIconRight = item.iconRight != null;
                    return InkWell(
                      onTap: item.onTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 15),
                        decoration: BoxDecoration(
                            color: colorsDS.backgroundPure,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: colorsDS.bordersMedium, width: .5),
                            boxShadow: [
                              BoxShadow(
                                  color: colorsDS.bordersMedium,
                                  blurRadius: 1,
                                  offset: const Offset(0, 1))
                            ]),
                        child: Row(
                          children: [
                            Icon(
                              item.icon,
                              color: !hasIconRight
                                  ? colorsDS.iconsDanger
                                  : colorsDS.iconsLight,
                              size: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: UolletiText.contentLarge(
                              item.title,
                              color: !hasIconRight
                                  ? colorsDS.textDanger
                                  : colorsDS.iconsLight,
                              bold: true,
                            )),
                            if (item.trailling != null) item.trailling!,
                            if (hasIconRight)
                              Icon(
                                item.iconRight,
                                color: colorsDS.iconsDisabled,
                                size: 25,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )),
              const SizedBox(
                height: 5,
              )
            ],
          );
        },
      ),
    );
  }

   _changeRoute(String route, {Map<String, dynamic>? params}) {
    String query = '';
    if (params != null) {
      query = '?';
      params.forEach((key, value) {
        if (value != null) {
          query += '$key=$value&';
        }
      });
      query = query.substring(0, query.length - 1);
    }
   CoreNavigator.pushNamed("$route$query").then((refresh) {
    if(refresh == true){
      bloc.getUser();
    }
   });
  }

  List<_TileProfile> items(UserWithKycEntity? user) => [
        _TileProfile(
            title: 'Dados pessoais',
            icon: Icons.account_circle_outlined,
            onTap: () => _changeRoute(AppRoutes.profile.personal,
                params: user != null
                    ? {
                        StringUtils.document: user.document,
                        StringUtils.phone: user.phone,
                        StringUtils.birthDay: user.birthDay,
                        StringUtils.email: user.email,
                        StringUtils.username: user.username,
                      }
                    : null),
            iconRight: Icons.chevron_right_outlined),
        _TileProfile.alert(
          activate: bloc.statusResponse(5) != KYCSTATUSRESPONSE.completed,
            title: 'Endereço',
            icon: Icons.home_outlined,
            onTap: () => _changeRoute(AppRoutes.profile.address),
            iconRight: Icons.chevron_right_outlined),
        _TileProfile(
            title: 'Telefone',
            icon: Icons.contact_phone_outlined,
            onTap: () => _changeRoute(AppRoutes.profile.phoneNumber),
            iconRight: Icons.chevron_right_outlined),
        _TileProfile(
            title: 'Senha de acesso',
            icon: Icons.password_outlined,
            onTap: () => _changeRoute(AppRoutes.profile.password),
            iconRight: Icons.chevron_right_outlined),
        _TileProfile.alert(
            title: 'Documento',
            activate: bloc.statusResponse(2) != KYCSTATUSRESPONSE.completed,
            icon: Icons.description_outlined,
            onTap: () => _changeRoute(AppRoutes.profile.validatorDocument),
            iconRight: Icons.chevron_right_outlined),
        _TileProfile.alert(
            title: 'Selfie',
            icon: Icons.face_outlined,
            activate: bloc.statusResponse(2) != KYCSTATUSRESPONSE.completed,
            onTap: () => _changeRoute(AppRoutes.profile.selfie),
            iconRight: Icons.chevron_right_outlined),
        _TileProfile(
            title: 'Biometria',
            icon: Icons.fingerprint_outlined,
            onTap: () => _changeRoute(AppRoutes.profile.fingerprint),
            iconRight: Icons.chevron_right_outlined),
        _TileProfile(
            title: 'Limites',
            icon: Icons.tune_outlined,
            onTap: () => _changeRoute(AppRoutes.profile.limit),
            iconRight: Icons.chevron_right_outlined),
        _TileProfile(
            title: 'Sair da conta',
            icon: Icons.logout_outlined,
            onTap: () {
              UolletiDialogs.dialogShowGeneric(const DialogExitProfile());
            }),
      ];
}

class _TileProfile extends Equatable {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final IconData? iconRight;
  final Widget? trailling;
  const _TileProfile({
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconRight,
    this.trailling,
  });
  _TileProfile.alert({
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconRight,
    bool activate = false,
  }) : trailling = activate
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: colorsDS.iconsWarning,
                  child: UolletiText.contentSmall(
                    'i',
                    color: colorsDS.backgroundPure,
                    bold: true,
                  ),
                ),
              )
            : null;
  @override
  List<Object?> get props => [title, icon, onTap, iconRight, trailling];
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorsDS.primary900,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Stack(
            children: [
              InkWell(
                onTap: () {
                  UolletiBottomSheet.show(const BottomSheetPhotoProfile());
                },
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: colorsDS.backgroundLight,
                  child: Icon(
                    Icons.person_outline,
                    color: colorsDS.iconsDisabled,
                    size: 38,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorsDS.primary900,
                      border: Border.all(
                          color: colorsDS.backgroundLight, width: 1)),
                  child: Icon(
                    Icons.add,
                    size: 9,
                    color: colorsDS.backgroundLight,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          UolletiText.labelMedium(
            'Junior pereira',
            color: colorsDS.backgroundLight,
            bold: true,
          ),
          const SizedBox(
            height: 5,
          ),
          UolletiText.contentSmall(
            '@juninho95',
            color: colorsDS.iconsDisabled,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
