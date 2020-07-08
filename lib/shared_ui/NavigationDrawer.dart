import 'package:flutter/material.dart';
import 'package:newsapp/models/nav_menu.dart';
import 'package:newsapp/screens/Home_Screen.dart';
import 'package:newsapp/screens/HeadLine_News.dart';
import 'package:newsapp/screens/Twitter_Feed.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {

  List<NavMenuItem> navigationMenu = [
    NavMenuItem("Explore", () => HomeScreen()),
    NavMenuItem("Headline New", () => HeadLineNews()),
    NavMenuItem("Twitter Feed", () => TwitterFeed())
  ];

  // List<String> navMenu = [
  //   'Explore',
  //   'Headline News',
  //   'Read Later',
  //   'Videos',
  //   'Photos',
  //   'Settings',
  //   'Logout'
  // ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 8),
        child: ListView.builder(
          itemBuilder: (context,position){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  navigationMenu[position].title,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 22
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return navigationMenu[position].destination();
                  }));
                },
              ),
            );
          },
          itemCount: navigationMenu.length,
        ),
      ),
    );
  }
}