class Comment {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  Comment(
      {this.id,
        this.name,
        this.postId,
        this.email,
        this.body});

  Comment.fromJson(Map<String, dynamic> json)
      : postId = json['postId'],
        body = json['body'],
        id = json['id'],
        email = json['email'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
    'postId': postId,
    'id': id,
    'name': name,
    'body': body,
    'email': email,
  };
}
