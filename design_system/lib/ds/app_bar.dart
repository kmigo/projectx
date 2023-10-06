part of 'ds.dart';

enum UolletiImageLogo {none,simpleLogo}
enum UolletiImageProfile {idle,profile}
class UolletiAppBar extends StatelessWidget  implements PreferredSizeWidget{
  final AppBar _appBar = AppBar();
  final Color? backgroundColor;
  final bool centerTitle;
  final Widget? leading;
  final Widget title;
  final List<Widget> widgets;
  final IconThemeData? iconTheme;
  final UolletiImageLogo logo;
  final UolletiImageProfile profile;
  final double? elevation;
  UolletiAppBar({super.key,this.backgroundColor,this.profile = UolletiImageProfile.idle, this.logo = UolletiImageLogo.none ,this.elevation,this.centerTitle = true,this.title = const SizedBox(),this.iconTheme,this.leading,this.widgets = const <Widget>[]});
  
  @override
  Widget build(BuildContext context) {
    final arrowBack = Navigator.canPop(context) ? IconButton(
      icon: IconTheme(
        data: iconTheme ?? IconThemeData(color: backgroundColor != null ? colorsDS.primary900: colorsDS.backgroundPure),
        child: const Icon(Icons.arrow_back_ios)),
      onPressed: () => Navigator.pop(context),
    ) : null;

    return Container(
      height: _appBar.preferredSize.height,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: backgroundColor ?? colorsDS.backgroundMedium,
        borderRadius: const BorderRadius.only(
        ),
        // shadow elevation
        boxShadow:  [
          BoxShadow(
            color: Colors.black12,
            blurRadius: elevation ?? 5,
            offset: Offset(0,  elevation == 0 ? 0 : 5),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _logoWidget() ?? leading ?? arrowBack ?? const SizedBox(),
            ),),
          Expanded(
            flex: 2,
            child:centerTitle ? Center(child: title,): title),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:  [
                if(profile != UolletiImageProfile.idle)...[
                  _profileWidget()! 
                ]else...[
                   ...widgets
                ]
                ],
            )),
        ],
      ),
    );
  }

  Widget? _logoWidget(){
    switch (logo) {
      case UolletiImageLogo.simpleLogo:
        return UolletiText.contentMedium("LOGO",color: colorsDS.textPure,);
      default:
        return null;
    }
  }

    Widget? _profileWidget(){
    switch (profile) {
      case UolletiImageProfile.profile:
        return InkWell(
          onTap: (){
            CoreNavigator.pushNamed(AppRoutes.profile.root);
          },
          child: CircleAvatar(
            backgroundColor: colorsDS.bordersMedium,
            child: Icon(Icons.person,color: colorsDS.primary900,),
          ),
        );
      default:
        return null;
    }
  }
  
  @override
  Size get preferredSize => _appBar.preferredSize;
}