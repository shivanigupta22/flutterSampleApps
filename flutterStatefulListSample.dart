import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

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
      home: const MyHomePage(title: 'Title'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);

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
        child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, i) {
              if (i.isOdd) return const Divider();
              final index = i ~/ 2;
              if (index >= _suggestions.length) {
                _suggestions.addAll(generateWordPairs().take(10));
              }
              final alreadySaved = _saved.contains(_suggestions[index]);
              return ListTile(
                  title: Text(
                    _suggestions[index].asPascalCase,
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
                        _saved.remove(_suggestions[index]);
                      } else {
                        _saved.add(_suggestions[index]);
                      }
                    });
                  });
            }),
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
                  pair.asPascalCase,
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
