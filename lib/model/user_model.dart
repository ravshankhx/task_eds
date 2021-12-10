class User {

  String? name;
  String? email;
  String? comment;


  User.fromJson(Map<String, dynamic> json)
      :
        name = json['name'],
        email = json['email'],
        comment = json['comment'];


  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'comment': comment,

  };
}
