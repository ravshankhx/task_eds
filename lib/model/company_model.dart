class Company {
  String? name;
  String? bs;
  String? catchPhrase;

  Company(
      {this.bs,
        this.name,
        this.catchPhrase});

  Company.fromJson(Map<String, dynamic> json)
      : catchPhrase = json['catchPhrase'],
        bs = json['bs'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'catchPhrase': catchPhrase,
        'name': name,
        'bs': bs,
      };
}
