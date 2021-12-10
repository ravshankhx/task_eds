import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_eds/pages/album_detail_page.dart';
import 'package:task_eds/pages/album_page.dart';
import 'package:task_eds/pages/comment_page.dart';
import 'package:task_eds/pages/detail_page.dart';
import 'package:task_eds/pages/home_page.dart';
import 'package:task_eds/pages/post_page.dart';


void main()async {
  await Hive.initFlutter();
  await Hive.openBox('task_eds');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  get item => item;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        HomePage.id: (context) => HomePage(),
        PostPage.id: (context) => PostPage(
              input: item,
            ),
        DetailPage.id: (context) => DetailPage(
              input: item,
            ),
       AlbumPage.id: (context) => AlbumPage(
          input: item,
        ),
        AlbumDetailPage.id: (context) => AlbumDetailPage(
          input: item,
        ),
        CommentPage.id: (context)=> CommentPage(input: item,),
      },
    );
  }
}
