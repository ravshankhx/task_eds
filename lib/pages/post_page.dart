import 'package:flutter/material.dart';
import 'package:task_eds/model/post_model.dart';
import 'package:task_eds/services/database_sevice.dart';
import 'package:task_eds/services/http_service.dart';
import 'comment_page.dart';

class PostPage extends StatefulWidget {
  static final String id = "post_page";

  final int? input;

  const PostPage({required this.input});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<Post> posts = [];

  void _dopostdb(Post item) async {
    int? id = item.id;
    int? userId = item.userId;
    String? title = item.title.toString().trim();
    String? body = item.body.toString().trim();
    var post = new Post(id: id, userId: userId, title: title, body: body);
    HiveDB().storePost(post);
    //var user2 = HiveDB().loadPost();
    // print(user2.id);
    // print(user2.body);
  }

  Future _openComment(Post item) async {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new CommentPage(
        input: item.id,
      );
    }));
  }

  Future apiPostlist() async {
    var response = await Network.GETT(Network.API_LIST_DETAILS, widget.input,
        Network.API_POST, Network.paramsEmpty());
    if (response != null) {
      posts = Network.parsePost(response);
    } else {
      print("try again");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 100));
    apiPostlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        title: const Text('Posts of User'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (ctx, i) {
          return itemOfList(posts[i]);
        },
      ),
    );
  }

  Widget itemOfList(Post item) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FlatButton(
              onPressed: () {
                _openComment(item);
                _dopostdb(item);
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
                      item.title.toString(),
                      style: const TextStyle(fontSize: 22),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      item.body.toString(),
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    SizedBox(
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
