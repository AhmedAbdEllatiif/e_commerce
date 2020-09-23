import 'package:e_commerce/tabs/home_tab.dart';
import 'package:e_commerce/tabs/saved_tab.dart';
import 'package:e_commerce/tabs/search_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/bottom_taps.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;

  PageController _tabsPageController;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Expanded(
                child: PageView(
                  controller: _tabsPageController,
                  onPageChanged: (value){
                    setState(() {
                      selectedPage = value;
                    });
                  },
                  children: [

                   ///HomeTab
                    HomeTab(),

                   ///SearchTab
                    SearchTab(),

                   ///SavedTab
                    SavedTab(),

                  ],
                ),
              ),
            ),
           BottomTabs(
             selectedTab: selectedPage,
             tabPressed:(value){
                  setState(() {
                    _tabsPageController.animateToPage(
                        value,
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeOutCubic
                    );
                  });
             },
           )
          ],
        ),
      ),
    );
  }
}
