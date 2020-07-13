import 'package:flutter/material.dart';
import 'package:newsapp/api/PostsApi.dart';
import 'package:newsapp/models/Post.dart';
import 'package:newsapp/utilities/DataUtilities.dart';

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  PostsAPI postsAPI = PostsAPI();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postsAPI.fetchPopularPosts(),
      builder:(context, AsyncSnapshot snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.none:
            return connectionError();
            break;
          case ConnectionState.waiting:
            return loading();
            break;
          case ConnectionState.active:
            return loading();
            break;
          case ConnectionState.done:
            if (snapshot.hasError) {
              return error(snapshot.error);
            } else {
              List<Post> posts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context,position){
                  return Card(
                    child: _drawSingleRow(posts[position]),
                  );
                },
                itemCount: posts.length,
              );
            }
            break;
        }
      } 
    );
  }

  Widget _drawSingleRow(Post post) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            child: Image(
              image: NetworkImage(post.featuredImage),
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
                        Text(parseHumanDateTime(post.dateWritten)),
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

}