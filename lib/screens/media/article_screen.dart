import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:lentera_ilmu/models/media/article.dart';

class ArticleScreen extends StatefulWidget {
  final ArticleModel article;
  const ArticleScreen({Key? key, required this.article}) : super(key: key);

  @override
  _ArticleScreen createState() => _ArticleScreen();
}

class _ArticleScreen extends State<ArticleScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text("Berita & Artikel"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {
              Get.back(),
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        widget.article.image ?? widget.article.thumbnail),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: Text(
                  widget.article.title,
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Html(data: widget.article.content),
              )
            ],
          ),
        ),
      ),
    );
  }
}
