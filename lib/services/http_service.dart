import 'dart:convert';
import 'package:http/http.dart';
import 'package:task_eds/model/album_model.dart';
import 'package:task_eds/model/comment_model.dart';
import 'package:task_eds/model/photo_model.dart';
import 'package:task_eds/model/post_model.dart';
import 'package:task_eds/model/users_model.dart';

class Network {
  static String BASE = "jsonplaceholder.typicode.com";

  /* Http Apis */

  static String API_LIST = "/users";
  static String API_LIST_DETAILS = "/users/";
  static String API_POST = "/posts";
  static String API_POST_DETAILS = "/posts/";
  static String API_COMMENT = "/comments";
  static String API_PHOTO = "/photos";
  static String API_ALBUMS = "/albums";
  static String API_ALBUMS_DETAILS = "/albums/";

  /* Http Requests */

  static Future<String?> GETT(
      String api, int? id, String apii, Map<String, String> params) async {
    var uri =
        Uri.https(BASE, api + id.toString() + apii, params); // http or https
    var response = await get(uri);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params); // http or https
    var response = await get(uri);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  /* Http Params */

  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, String> paramsCreate(Users user) {
    Map<String, String> params = {};
    params.addAll({
      'id': user.id.toString(),
      'username': user.username.toString(),
      'name': user.name.toString(),
    });
    return params;
  }

  static Map<String, String> paramsUpdate(Users user) {
    Map<String, String> params = {};
    params.addAll({
      'id': user.id.toString(),
      'name': user.name.toString(),
    });
    return params;
  }

  static List<Users> parseUserslist(String body) {
    dynamic json = jsonDecode(body);
    var data = List<Users>.from(json.map((x) => Users.fromJson(x)));
    return data;
  }

  static List<Post> parsePost(String body) {
    dynamic json = jsonDecode(body);
    var data = List<Post>.from(json.map((x) => Post.fromJson(x)));
    return data;
  }

  static List<Photo> parsePhoto(String body) {
    dynamic json = jsonDecode(body);
    var data = List<Photo>.from(json.map((x) => Photo.fromJson(x)));
    return data;
  }

  static List<Album> parseAlbum(String body) {
    dynamic json = jsonDecode(body);
    var data = List<Album>.from(json.map((x) => Album.fromJson(x)));
    return data;
  }

  static List<Comment> parseComment(String body) {
    dynamic json = jsonDecode(body);
    var data = List<Comment>.from(json.map((x) => Comment.fromJson(x)));
    return data;
  }
}
