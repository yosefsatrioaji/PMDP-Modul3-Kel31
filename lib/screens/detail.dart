import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPage extends StatefulWidget {
  final int item;
  final String title;
  const DetailPage({Key? key, required this.item, required this.title})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<animeDetails> animeDetail;

  @override
  void initState() {
    super.initState();
    animeDetail = aniDetail(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
          child: FutureBuilder(
        builder: (context, AsyncSnapshot<animeDetails> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
                child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network(snapshot.data!.imageUrl, height: 400),
                  Text(
                    snapshot.data!.titleAnime,
                    textScaleFactor: 2,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Score : ${snapshot.data!.score}",
                  ),
                  Text(
                    "Episodes : ${snapshot.data!.howepisodes}",
                  ),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        snapshot.data!.synopsis,
                        textAlign: TextAlign.justify,
                      ))
                ],
              ),
            ));
          } else if (snapshot.hasError) {
            //print(snapshot);
            return Center(child: Text('failed'));
          }
          return const CircularProgressIndicator();
        },
        future: animeDetail,
      )),
    );
  }
}

class animeDetails {
  final String imageUrl;
  final String titleAnime;
  final String synopsis;
  final num score;
  final num howepisodes;
  animeDetails(
      {required this.imageUrl,
      required this.titleAnime,
      required this.synopsis,
      required this.score,
      required this.howepisodes});
  factory animeDetails.fromJson(Map<String, dynamic> json) {
    print(json["image_url"]);
    return animeDetails(
      imageUrl: json["image_url"],
      titleAnime: json["title"],
      synopsis: json["synopsis"],
      score: json["score"],
      howepisodes: json["episodes"],
    );
  }
}

Future<animeDetails> aniDetail(id) async {
  final response =
      await http.get(Uri.parse('https://api.jikan.moe/v3/anime/$id'));

  if (response.statusCode == 200) {
    //var animeDetailsJson = jsonDecode(response.body)[0];
    //return animeDetailsJson.map((anime) => animeDetails.fromJson(anime));
    return animeDetails.fromJson(jsonDecode(response.body));
    //return MedicalRecordsModel.fromJson(jsonDecode(response.body)[0]);
  } else {
    throw Exception('Failed to load');
  }
}
