import 'package:flutter/material.dart';
import 'package:task_eds/model/album_model.dart';
import 'package:task_eds/pages/album_detail_page.dart';
import 'package:task_eds/services/database_sevice.dart';
import 'package:task_eds/services/http_service.dart';

class AlbumPage extends StatefulWidget {
  static final String id = "album_page";

  final int? input;

  const AlbumPage({required this.input});

  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  List<Album> albums = [];

  Future _openPhoto(Album item) async {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new AlbumDetailPage(
        input: item.id,
      );
    }));
  }

  Future apiAlbumlist() async {
    var response = await Network.GETT(Network.API_LIST_DETAILS, widget.input,
        Network.API_ALBUMS, Network.paramsEmpty());

    if (response != null) {
      albums = Network.parseAlbum(response);
    } else {
      print("try again");
    }
  }

  void _doalbumdb(Album item) async {
    int? id = item.id;
    int? userId = item.userId;
    String? title = item.title.toString().trim();
    var album = new Album(id: id, userId: userId, title: title);
    HiveDB().storeAlbum(album);
    //  var album2 = HiveDB().loadAlbum();
    // print(album2.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 100));

    apiAlbumlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        title: Text('Albums'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GridView.builder(
        itemCount: albums.length,
        itemBuilder: (ctx, i) {
          return itemOfList(albums[i]);
        },
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),
    );
  }

  Widget itemOfList(Album item) {
    return Container(
      padding: EdgeInsets.all(5),
      color: Colors.white,
      margin: EdgeInsets.all(6),
      child: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: FlatButton(
            onPressed: () {
              _doalbumdb(item);
              _openPhoto(item);
            },
            textColor: Colors.blue,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Row(
                  children: [
                Text(
                item.id.toString(),
            style: TextStyle(fontSize: 18,color: Colors.grey[400]),)
                  ],
                )),
                Expanded(
                  flex: 9,
                  child: Center(child: Text(
                    item.title.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),),
                )


              ],

            ),
          ),
        ),
      ),
    );
  }
}
