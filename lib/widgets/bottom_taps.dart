import 'package:flutter/material.dart';
import '../appUtils.dart';

class BottomTabs extends StatefulWidget {

  final selectedTab;
  final Function(int) tabPressed;

  BottomTabs({this.selectedTab,this.tabPressed});

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab?? 0;
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.09),
                  spreadRadius: 1.0,
                  blurRadius: 20.0),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomTabBtn(
              logo: 'tab_home.png',
              isSelected: _selectedTab == 0,
              onPressed: () {
                widget.tabPressed(0);
              },
            ),
            BottomTabBtn(
                logo: 'tab_search.png',
                isSelected: _selectedTab == 1,
                onPressed: () {
                  widget.tabPressed(1);
                }),
            BottomTabBtn(
                logo: 'tab_saved.png',
                isSelected: _selectedTab == 2,
                onPressed: () {
                  widget.tabPressed(2);
                }),
            BottomTabBtn(
                logo: 'tab_logout.png',
                isSelected: _selectedTab == 3,
                onPressed: () {
                  widget.tabPressed(3);
                }),
          ],
        ));
  }
}

class BottomTabBtn extends StatelessWidget {
  final String logo;
  final bool isSelected;
  final Function onPressed;

  BottomTabBtn({this.logo, this.isSelected, this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool _isSelected = isSelected ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: _isSelected
                          ? Theme.of(context).accentColor
                          : Colors.transparent,
                      width: 2.0))),
          child: Image(
            image: AssetImage('${AppUtils.images_dir}$logo'),
            color: _isSelected ? Theme.of(context).accentColor : Colors.black,
            width: 22.0,
            height: 22.0,
          )),
    );
  }
}
