import 'package:flutter/material.dart';
import 'package:flutter_first/features/feature1/data/album.dart';
import 'package:flutter_first/features/feature1/data/feature_one_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.red, foregroundColor: Colors.white)),
      home: MyHomePage(title: 'Title',repository: FeatureOneRepository()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title,required this.repository}) : super(key: key);

  final String title;
  final FeatureOneRepository repository;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _saved = <Album>{};
  final _biggerFont = const TextStyle(fontSize: 18);
  late Future<List<Album>> list;
  @override
  void initState() {
    super.initState();
    list = widget.repository.fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Flutter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Saved Suggestions',
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 16),
        child: FutureBuilder(builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, i) {
                if (i.isOdd) return const Divider();

                final alreadySaved = _saved.contains(snapshot.data[i]);
                return ListTile(
                    title: Text(
                      snapshot.data[i].title,
                      style: _biggerFont,
                    ),
                    trailing: Icon(
                      alreadySaved ? Icons.favorite : Icons.favorite_border,
                      color: alreadySaved ? Colors.red : null,
                      semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
                    ),
                    onTap: () {
                      setState(() {
                        if (alreadySaved) {
                          _saved.remove(snapshot.data[i]);
                        } else {
                          _saved.add(snapshot.data[i]);
                        }
                      });
                    });
              },
              itemCount: snapshot.data.length,);
        },
          future: list,

        ),
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.title,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}
////////////////// Album //////////

/* manual*/
class Album {
  int userId;
  int id;
  String title;

  Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(dynamic json) {
    return Album(userId: json["userId"], id: json["id"], title: json["title"]);
  }
}

//using json serializable
import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable()
class Album {
  @JsonKey(name: 'userId')
  int userId;
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'title')
  String title;

  Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(dynamic json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}

//////// FeatureOneRepository //////

import 'package:flutter_first/features/feature1/data/album.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeatureOneRepository {

  Future<List<Album>> fetchAlbums() async {
    final res = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
    if (res.statusCode == 200) {
      var arr = jsonDecode(res.body) as List;
      return arr.map((e) => Album.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}
