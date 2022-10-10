import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatelessWidget(),
      ),
    );
  }
}


//returns widgets that sizes itself upto a fraction of available space
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       width: MediaQuery.of(context).size.width,
      color: Colors.blueAccent,
      child:Row(
        children: [
          Expanded(
            child: FractionallySizedBox(
         widthFactor: 20,
       //  heightFactor: 40,
              child: Image.network("https://miro.medium.com/max/4800/0*6SorIHZUM47CE9BU")),
          ),
         Expanded(child: Image.network("https://miro.medium.com/max/4800/0*6SorIHZUM47CE9BU"))

        ],
      )
    );
  }
}
