import 'package:flutter/material.dart';
import 'package:newsapp/shared_ui/NavigationDrawer.dart';
import 'package:newsapp/screens/home_tabs/Popular.dart';
import 'package:newsapp/screens/home_tabs/Favourites.dart';

class HeadLineNews extends StatefulWidget {
  @override
  _HeadLineNewsState createState() => _HeadLineNewsState();
}

class _HeadLineNewsState extends State<HeadLineNews> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HeadLine News'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
        bottom: TabBar(
          tabs: [
            Tab(text: "WHAT'S NEW"),
            Tab(text: 'POPULAR'),
            Tab(text: 'FAVOURITES'),
          ],
          controller: _tabController,
          indicatorColor: Colors.white,
        ),
      ),
      drawer: NavigationDrawer(),
      body: Center(
        child: TabBarView(children: [
          Favourites(),
          Popular(),
          Favourites(),
        ],
        controller: _tabController,
        ),
      ),
    );
  }
}