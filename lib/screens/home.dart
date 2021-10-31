import 'package:flutter/material.dart';
import 'package:tugasmodul3kel31/screens/detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Show>> shows;
  late Future<List<Show>> topShow;

  @override
  void initState() {
    super.initState();
    shows = fetchShows();
    topShow = topShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
                child: FutureBuilder(
                    builder: (context, AsyncSnapshot<List<Show>> snapshot) {
                      if (snapshot.hasData) {
                        return Center(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              fit: FlexFit.tight,
                              flex: 1,
                              child: new Text(
                                'Top Airing',
                                textScaleFactor: 2,
                              ),
                            ),
                            Flexible(
                                fit: FlexFit.tight,
                                flex: 4,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                        width: 180,
                                        height: 190,
                                        child: Card(
                                          color: Colors.white,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailPage(
                                                          item: snapshot
                                                              .data![index]
                                                              .malId,
                                                          title: snapshot
                                                              .data![index]
                                                              .title),
                                                ),
                                              );
                                            },
                                            child: Wrap(children: <Widget>[
                                              Image.network(
                                                  snapshot
                                                      .data![index].imageUrl,
                                                  width: 180,
                                                  height: 190,
                                                  fit: BoxFit.cover),
                                              ListTile(
                                                title: Flexible(
                                                  child: Text(
                                                    snapshot.data![index].title,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textScaleFactor: 1,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ),
                                        ));
                                  },
                                )),
                          ],
                        ));
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text('Something went wrong :('));
                      }
                      return const CircularProgressIndicator();
                    },
                    future: topShow)),
            Flexible(
                child: FutureBuilder(
              builder: (context, AsyncSnapshot<List<Show>> snapshot) {
                if (snapshot.hasData) {
                  return Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: new Text(
                          'Top Anime of All Time',
                          textScaleFactor: 2,
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 4,
                        child: new ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: Colors.white,
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      snapshot.data![index].imageUrl),
                                ),
                                title: Text(snapshot.data![index].title),
                                subtitle: Text(
                                    'Score: ${snapshot.data![index].score}'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                          item: snapshot.data![index].malId,
                                          title: snapshot.data![index].title),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ));
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong :('));
                }
                return const CircularProgressIndicator();
              },
              future: shows,
            )),
          ]),
    ));
  }
}

class Show {
  final int malId;
  final String title;
  final String imageUrl;
  final num score;

  Show({
    required this.malId,
    required this.title,
    required this.imageUrl,
    required this.score,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      malId: json['mal_id'],
      title: json['title'],
      imageUrl: json['image_url'],
      score: json['score'],
    );
  }
}

Future<List<Show>> fetchShows() async {
  final response =
      await http.get(Uri.parse('https://api.jikan.moe/v3/top/anime/1'));

  if (response.statusCode == 200) {
    var topShowsJson = jsonDecode(response.body)['top'] as List;
    return topShowsJson.map((show) => Show.fromJson(show)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}

Future<List<Show>> topShows() async {
  final response =
      await http.get(Uri.parse('https://api.jikan.moe/v3/top/anime/1/airing'));

  if (response.statusCode == 200) {
    var topShowsJson = jsonDecode(response.body)['top'] as List;
    return topShowsJson.map((show) => Show.fromJson(show)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}
