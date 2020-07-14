import 'package:flutter/material.dart';
import 'package:newsapp/shared_ui/NavigationDrawer.dart';
import 'package:newsapp/screens/home_tabs/WhatsNew.dart';
import 'package:newsapp/screens/home_tabs/Popular.dart';
import 'package:newsapp/screens/home_tabs/Favourites.dart';
import 'package:newsapp/screens/pages/About.dart';
import 'package:newsapp/screens/pages/Contact.dart';
import 'package:newsapp/screens/pages/Help.dart';
import 'package:newsapp/screens/pages/Settings.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum PopOutMenu { 
  HELP,
  ABOUT,
  CONTACT,
  SETTINGS,
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
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
        title: Text('Explore'),
        centerTitle: false,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          _popOutMenu(context),
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

  Widget _popOutMenu(BuildContext context){
    return PopupMenuButton<PopOutMenu>(
      itemBuilder: (context){
        return [
          PopupMenuItem<PopOutMenu>(
            value: PopOutMenu.ABOUT,
            child: Text('ABOUT'),
          ),
          PopupMenuItem<PopOutMenu>(
            value: PopOutMenu.CONTACT,
            child: Text('CONTACT'),
          ),
          PopupMenuItem<PopOutMenu>(
            value: PopOutMenu.HELP,
            child: Text('HELP'),
          ),
          PopupMenuItem<PopOutMenu>(
            value: PopOutMenu.SETTINGS,
            child: Text('SETTINGS'),
          ),
        ];
      },
      onSelected: (PopOutMenu menu){
        switch(menu){
          case PopOutMenu.ABOUT:
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return AboutUs();
            }));
            break;
          case PopOutMenu.CONTACT:
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return ContactUs();
            }));
            break;
          case PopOutMenu.HELP:
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return Help();
            }));
            break;
          case PopOutMenu.SETTINGS:
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return Settings();
            }));
            break;
        }
      },
      icon: Icon(Icons.more_vert),
    );
  }

}
