import 'package:hive/hive.dart';
import 'package:task_eds/model/album_model.dart';
import 'package:task_eds/model/comment_model.dart';
import 'package:task_eds/model/photo_model.dart';
import 'package:task_eds/model/post_model.dart';
import 'package:task_eds/model/user_model.dart';
import 'package:task_eds/model/users_model.dart';

class HiveDB {
  var box = Hive.box("task_eds");

  void storeUser(User user) async {
    box.put("user", user.toJson());
  }

  User loadUser() {
    var user = new User.fromJson(box.get("user"));
    return user;
  }

  void removeUser() {
    box.delete("user");
  }

  void storeUsers(Users users) async {
    box.put("users", users.toJson());
  }

  Users loadUsers() {
    var users = new Users.fromJson(box.get("users"));
    return users;
  }

  void removeUsers() {
    box.delete("users");
  }

  void storePost(Post post) async {
    box.put("post", post.toJson());
  }

  Post loadPost() {
    var post = Post.fromJson(box.get("post"));
    return post;
  }

  void removePost() {
    box.delete("post");
  }

  void storeComment(Comment comment) async {
    box.put("comment", comment.toJson());
  }

  Comment loadComment() {
    var comment = new Comment.fromJson(box.get("comment"));
    return comment;
  }

  void removeComment() {
    box.delete("comment");
  }

  void storePhoto(Photo photo) async {
    box.put("photo", photo.toJson());
  }

  Photo loadPhoto() {
    var photo = new Photo.fromJson(box.get("photo"));
    return photo;
  }

  void removePhoto() {
    box.delete("photo");
  }

  void storeAlbum(Album album) async {
    box.put("album", album.toJson());
  }

  Album loadAlbum() {
    var album = new Album.fromJson(box.get("album"));
    return album;
  }

  void removeAlbum() {
    box.delete("album");
  }
}
