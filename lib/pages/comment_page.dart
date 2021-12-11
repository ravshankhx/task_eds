import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_eds/model/comment_model.dart';
import 'package:task_eds/services/database_sevice.dart';
import 'package:task_eds/services/http_service.dart';

class CommentPage extends StatefulWidget {
  static final String id = "comment_page";

  final int? input;

  const CommentPage({required this.input});

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Comment> comments = [];



  Future apiPostlist() async {
    var response = await Network.GETT(Network.API_POST_DETAILS, widget.input,
        Network.API_COMMENT, Network.paramsEmpty());

    if (response != null) {
     // print(response);

      comments = Network.parseComment(response);
      //print(comments.length);
    } else {
      print("try again");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 100));
    apiPostlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        title: Text('Post Page'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (ctx, i) {
          return itemOfList(comments[i]);
        },
      ),
    );
  }

  Widget itemOfList(Comment item) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  item.name.toString(),
                  style: TextStyle(fontSize: 22),
                ),
                Text(
                  item.email.toString(),
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  item.body.toString(),
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          RaisedButton(
            elevation: 0,
            child: Text("Comment"),
            onPressed: () => _onButtonPressed(item),
          ),
        ],
      ),
    );
  }

  void _onButtonPressed(Comment item) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 270,
            color: Color(0xFF737373),
            child:Container(
              child: _buildBottomNavigationMenu(item),
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(topRight: const Radius.circular(30),topLeft: const Radius.circular(30))
              ),
            ),
          );
        });
  }
}

 Column _buildBottomNavigationMenu(Comment item) {
  return Column(
    children: [
      TextField(
        controller: _doSend().namecontroller,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          labelText: "Name",
        ),
      ),
      TextField(
        controller: _doSend().emailcontroller,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.email),
          labelText: "Email",
        ),
      ),
      TextField(
        controller: _doSend().commentcontroller,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.comment),
          labelText: "Comment",
//"Comment",
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Center(
        child: SizedBox(
          height: 40,
          width: 120,
          child: FlatButton(
            onPressed: () {
              _doSend()._doSend1(item);
            },
            textColor: Colors.white,
            color: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              'Send',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    ],

  );
}

class _doSend {

  final namecontroller = TextEditingController();
  final commentcontroller = TextEditingController();
  final emailcontroller = TextEditingController();

  void _doSend1(Comment item) {
    int? id = item.id;
    int? postId = item.postId;
    String? body = item.body.toString().trim();
    String? email = item.email.toString().trim();
    String? name = item.name.toString().trim();
    var comment = new Comment(
        id: id, postId: postId, name: name, body: body, email: email);
    HiveDB().storeComment(comment);

    String name1 = namecontroller.text.toString().trim();
    String email1 = emailcontroller.text.toString().trim();
    String comment1 = commentcontroller.text.toString().trim();
    var box = Hive.box('task_eds');
    box.put("name1", name1);
    box.put("email1", email1);
    box.put("comment1", comment1);
    String user_cm = box.get('comment1');
    String user_email = box.get('email1');
    String user_name = box.get('name1');
    print(user_name);
    print(user_email);
    print(user_cm);
  }

}


