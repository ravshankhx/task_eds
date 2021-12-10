class Photo{
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  Photo(
      {this.id,
        this.albumId,
        this.title,
        this.url,
        this.thumbnailUrl});

  Photo.fromJson(Map<String, dynamic> json)
      : albumId = json['albumId'],
        title = json['title'],
        id = json['id'],
        url = json['url'],
        thumbnailUrl = json['thumbnailUrl'];

  Map<String, dynamic> toJson() => {
    'albumId': albumId,
    'id': id,
    'title': title,
    'url': url,
    'thumbnailUrl': thumbnailUrl,
  };
}