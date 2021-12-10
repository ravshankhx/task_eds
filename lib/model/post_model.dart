class Post {
  int? userId;
  int? id;
  String? title;
  String? body;


  Post(
      {this.id,
        this.userId,
        this.title,
        this.body});
  Post.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        title = json['title'],
        id = json['id'],
        body = json['body'];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
      };
}
