import 'package:flutter/material.dart';
import 'package:newsapp/pagemodel.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import './Home_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  List<PageModel> pages; 

  ValueNotifier<int> _pageViewNotifier = ValueNotifier(0);

  void _addPages(){
    pages = List<PageModel>();
    pages.add(
      PageModel(
        'Welcome !',
        '1-Making Friends is ease as waving you hand back and forth in easy step', 
        Icons.ac_unit, 
        'assets/images/bg.png'
      )
    );

    pages.add(
      PageModel(
        'Alarms !',
        '2-Making Friends is ease as waving you hand back and forth in easy step', 
        Icons.access_alarms, 
        'assets/images/bg2.png'
      )
    );

    pages.add(
      PageModel(
        'Printing !',
        '3-Making Friends is ease as waving you hand back and forth in easy step', 
        Icons.print, 
        'assets/images/bg3.png'
      )
    );

    pages.add(
      PageModel(
        'New Relaes !',
        '4-Making Friends is ease as waving you hand back and forth in easy step', 
        Icons.new_releases, 
        'assets/images/bg4.png'
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    _addPages();

    return Scaffold(
        body: Stack(
      children: <Widget>[
        PageView.builder(
          itemBuilder: (context, index) {
            return Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage(pages[index].image),
                        fit: BoxFit.cover),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Transform.translate(
                      child: Icon(
                      pages[index].icon,
                      size: 150,
                      color: Colors.white,
                      ),
                      offset: Offset(0, -75),
                    ),
                    Text(
                      pages[index].title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 48, right: 48,top: 16),
                      child: Text(
                        pages[index].description,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
          itemCount: pages.length,
          onPageChanged: (index){
            setState(() {
              _pageViewNotifier.value = index;
            });
          },
        ),
        Transform.translate(
          offset: Offset(0, 140),
          child: Align(
            alignment: Alignment.center,
            child: _displayPagesIndicator(pages.length),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24.0,left: 15,right: 15),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                  color: Colors.red.shade700,
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      letterSpacing: 1
                    ),
                  ),
                  onPressed: () {
                    _updateSeen();
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return HomeScreen();
                    } ));
                  }),
            ),
          ),
        )
      ],
    ));
  }

  Widget _displayPagesIndicator(int length){
    return PageViewIndicator(
    pageIndexNotifier: _pageViewNotifier,
    length: length,
    normalBuilder: (animationController, index) => Circle(
          size: 8.0,
          color: Colors.grey,
        ),
    highlightedBuilder: (animationController, index) => ScaleTransition(
          scale: CurvedAnimation(
            parent: animationController,
            curve: Curves.ease,
          ),
          child: Circle(
            size: 12.0,
            color: Colors.red,
          ),
        ),
    );
  }

  void _updateSeen() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('seen', true);
  }

}