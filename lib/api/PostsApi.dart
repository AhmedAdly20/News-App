import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:newsapp/utilities/ApiUtilities.dart';
import 'package:newsapp/models/Post.dart';


class PostsAPI {

  Future<List<Post>> fetchPostsByCategoryID(String id) async {
    String categoryPosts = base_api + categrories_api +id;
    var response = await http.get(categoryPosts);
    List<Post> posts = List<Post>();
    if( response.statusCode == 200 ){
      var jsonData = jsonDecode(  response.body);
      var data = jsonData["data"];

      for( var item in data ){
        Post post = Post(
          id: item["id"].toString(),
          title: item["title"].toString(),
          content: item["content"].toString(),
          dateWritten: item["date_written"].toString(),
          featuredImage: item["featured_image"].toString(),
          votesUp: item["votes_up"],
          votesDown: item["votes_down"],
          votersUp: (item["voters_up"] == null) ? List<int>() : jsonDecode( item["voters_up"] ),
          votersDown: (item["voters_down"] == null) ? List<int>() : jsonDecode( item["voters_down"] ),
          userId: item["user_id"],
          categoryId: item["category_id"]
        );
        posts.add(post);
      }
    }
    return posts;
  }
} 