import 'adress_model.dart';
import 'company_model.dart';

class Users {
  int? id;
  String? name;
  String? username;
  String? email;
  String? phone;
  String? website;
  Adress? address;
  Company? company;

  Users(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.address,
      this.company,
      this.website,
      this.phone});

  Users.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        phone = json['phone'],
        website = json['website'],
        username = json['username'],
        address = Adress.fromJson(json['address']),
        company = Company.fromJson(json['company']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'phone': phone,
        'email': email,
        'website': website,
        'address': address!.toJson(),
        'company': company!.toJson(),
      };
}
