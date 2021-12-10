import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_eds/model/adress_model.dart';
import 'package:task_eds/model/company_model.dart';
import 'package:task_eds/model/users_model.dart';
import 'package:task_eds/services/database_sevice.dart';
import 'package:task_eds/services/http_service.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  static final String id = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Users> items = [];

  void _doUsersdatabase(Users item) async {
    int? id = item.id;
    String? name = item.name.toString().trim();
    String? username = item.username.toString().trim();

    String? email = item.email.toString().trim();
    String? phone = item.phone.toString().trim();
    String? website = item.website.toString().trim();

    Adress? address = item.address;
    Company? company = item.company;

    var users = new Users(
        id: id,
        name: name,
        username: username,
        email: email,
        website: website,
        address: address,
        company: company,
        phone: phone);
    HiveDB().storeUsers(users);

    // var user2 = HiveDB().loadUsers();
    // print(user2.address!.geo!.lng);
  }

  Future _openDetails(Users item) async {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new DetailPage(
        input: item,
      );
    }));
  }

  Future apiUserlist() async {
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      items = Network.parseUserslist(response);
    } else {
      print("try ageain");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 100));
    apiUserlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Users list"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, i) {
          return itemOfList(items[i]);
        },
      ),
    );
  }

  Widget itemOfList(Users user) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FlatButton(
              onPressed: () {
                _openDetails(user);
                _doUsersdatabase(user);
              },
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      user.name.toString(),
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      user.username.toString(),
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
