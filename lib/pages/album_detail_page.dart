import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:task_eds/model/photo_model.dart';
import 'package:task_eds/services/database_sevice.dart';
import 'package:task_eds/services/http_service.dart';

class AlbumDetailPage extends StatefulWidget {
  static final String id = "album__detail_page";

  final int? input;
  List<String> imageList = [];

  AlbumDetailPage({required this.input});

  @override
  _AlbumDetailPageState createState() => _AlbumDetailPageState();
}

class _AlbumDetailPageState extends State<AlbumDetailPage> {
  List<Photo> photos = [];

  void _dophotodb(Photo item) async {
    int? id = item.id;
    int? albumId = item.albumId;
    String? title = item.title.toString().trim();
    String? url = item.url.toString().trim();
    String? thumbnailUrl = item.thumbnailUrl.toString().trim();
    var photo = new Photo(
        id: id,
        albumId: albumId,
        title: title,
        url: url,
        thumbnailUrl: thumbnailUrl);
    HiveDB().storePhoto(photo);
    // var photo2 = HiveDB().loadPhoto();
    // print(photo2.id);
  }

  Future apiPostlist() async {
    var response = await Network.GETT(Network.API_ALBUMS_DETAILS, widget.input,
        Network.API_PHOTO, Network.paramsEmpty());

    if (response != null) {
      // print(response);

      photos = Network.parsePhoto(response);
      // print(photos.length);
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
      appBar: AppBar(
        elevation: 0,
        title: const Text('Photo Album'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: CarouselSlider.builder(
          options: CarouselOptions(
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            autoPlay: true,
          ),
          itemBuilder: (ctx, i, ri) => Container(
            child: Center(
              child: itemOfList(photos[i]),
            ),
          ),
          itemCount: photos.length,
        ),
      ),
    );
  }

  Widget itemOfList(Photo item) {
    return SizedBox(
      height: 1500,
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            item.url.toString(),
            fit: BoxFit.cover,
            width: 120,
            height: 120,
            semanticLabel: item.title.toString(),
          ),
          TextButton(
              onPressed: () {
                _dophotodb(item);
              },
              child: Text(
                item.title.toString(),
                style: TextStyle(fontSize: 16, color: Colors.grey[900]),
              )),
        ],
      ),
    );
  }
}
