part of 'ds.dart';


class UolletiAppBar extends StatelessWidget  implements PreferredSizeWidget{
  final AppBar _appBar = AppBar();
  final Color? backgroundColor;
  final bool centerTitle;
  final Widget? leading;
  final Widget title;
  final List<Widget> widgets;
  final IconThemeData? iconTheme;
  final double? elevation;
  UolletiAppBar({super.key,this.backgroundColor,this.elevation,this.centerTitle = true,this.title = const SizedBox(),this.iconTheme,this.leading,this.widgets = const <Widget>[]});
  
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
        color: backgroundColor ?? colorsDS.primary900,
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
              child: leading ?? arrowBack ?? const SizedBox(),
            ),),
          Expanded(
            flex: 2,
            child:centerTitle ? Center(child: title,): title),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                ...widgets],
            )),
        ],
      ),
    );
  }
  
  @override
  Size get preferredSize => _appBar.preferredSize;
}