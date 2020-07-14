import 'package:flutter/material.dart';
import 'package:newsapp/models/Post.dart';

class SinglePost extends StatefulWidget {
  final Post post;
  SinglePost(this.post);
  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.tealAccent,
      ),
    );
  }
}