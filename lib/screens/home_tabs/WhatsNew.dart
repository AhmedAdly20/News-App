import 'package:flutter/material.dart';
import 'package:newsapp/api/PostsApi.dart';
import 'package:newsapp/models/Post.dart';
import 'dart:async';
import 'package:timeago/timeago.dart' as timeago;

class WhatsNew extends StatefulWidget {
  @override
  _WhatsNewState createState() => _WhatsNewState();
}

class _WhatsNewState extends State<WhatsNew> {
  PostsAPI postsAPI = PostsAPI();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _drawHeader(),
          _drawTopStories(),
          _drawRecentUpdates(),
        ],
      ),
    );
  }

  Widget _drawHeader() {
    TextStyle _headerTitle = TextStyle(
        color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600);
    TextStyle _headerDescription = TextStyle(
      color: Colors.white,
      fontSize: 18,
    );
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: ExactAssetImage('assets/images/placeholder_bg.png'),
        fit: BoxFit.cover,
      )),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 48, right: 48),
              child: Text(
                'How Terrieres & Royals Gatecrashed Final',
                style: _headerTitle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod',
                style: _headerDescription,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawTopStories() {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 18.0),
            child: _drawSectionTitle("Top Stories"),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: FutureBuilder(
                future: postsAPI.fetchWhatsNew(),
                builder: (context, AsyncSnapshot snapshot){
                  Post post1 = snapshot.data[0];
                  Post post2 = snapshot.data[1];
                  Post post3 = snapshot.data[2];
                  return Column(
                    children: <Widget>[
                      _drawSingleRow(post1),
                      _drawDivider(),
                      _drawSingleRow(post2),
                      _drawDivider(),
                      _drawSingleRow(post3),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawRecentUpdates(){
    return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                  child: _drawSectionTitle('Recent Updates'),
                ),
                _drawRecentUpdatCard(Colors.deepOrange),
                _drawRecentUpdatCard(Colors.teal),
                SizedBox(height: 48,)
              ],
            ),
          );
  }

  Widget _drawDivider() {
    return Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey.shade200,
    );
  }

  Widget _drawSingleRow(Post post) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            child: Image.network(
              post.featuredImage,
              fit: BoxFit.cover,
            ),
            width: 125.0,
            height: 125.0,
          ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  post.title,
                  maxLines: 2,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Michael Adams'),
                    Row(
                      children: <Widget>[
                        Icon(Icons.timer),
                        Text(_parseHumanDateTime(post.dateWritten)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String _parseHumanDateTime(String dateTime){
    Duration timeAgo = DateTime.now().difference(DateTime.parse(dateTime));
    DateTime theDifference = DateTime.now().subtract(timeAgo);
    return timeago.format(theDifference);
  }

  Widget _drawSectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade700,
          fontSize: 16),
    );
  }

  Widget _drawRecentUpdatCard(Color color) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage('assets/images/placeholder_bg.png'),
                  fit: BoxFit.cover),
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0),
            child: Container(
              padding: EdgeInsets.only(left: 24, right: 24, top: 2, bottom: 2),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'SPORT',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0 ,left: 16.0, bottom: 8.0, top: 16.0),
            child: Text(
              'Vettel is Ferrari Number One - Hamilton',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.timer,
                  color: Colors.grey,
                  size: 18,
                ),
                SizedBox( width: 4, ),
                Text(
                  '15 Min',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
