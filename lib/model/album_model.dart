class Album{
  int? userId;
  int? id;
  String? title;

  Album(
      {this.id,
        this.userId,
        this.title});

  Album.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        title = json['title'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
       'userId': userId,
        'id': id,
    'title': title,
  };
}