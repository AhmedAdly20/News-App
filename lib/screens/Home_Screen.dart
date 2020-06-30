import 'package:flutter/material.dart';
import 'package:newsapp/shared_ui/NavigationDrawer.dart';
import 'package:newsapp/screens/home_tabs/WhatsNew.dart';
import 'package:newsapp/screens/home_tabs/Popular.dart';
import 'package:newsapp/screens/home_tabs/Favourites.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
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
          WhatsNew(),
          Popular(),
          Favourites(),
        ],
        controller: _tabController,
        ),
      ),
    );
  }
}
