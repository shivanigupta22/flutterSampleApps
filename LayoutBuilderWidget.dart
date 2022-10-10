import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: LayoutBuilderWidget(),
    );
  }
}


//Layout Builder Widget constraints the child widget according to the parent widget.
// extends ConstraintedLayoutBuilder abstract class
//this will return device constraints and children can be managed accordingly
// can be useful in case of different device sizes for maintaining different layouts
class LayoutBuilderWidget extends StatelessWidget {
  const LayoutBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LayoutBuilder Example')),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          print(constraints);
          if (constraints.maxWidth > 600) {
            return _buildWideContainers(context);
          } else {
            return _buildNormalContainer();
          }
        },
      ),
    );
  }

  Widget _buildNormalContainer() {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.red,
      ),
    );
  }

  Widget _buildWideContainers(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.width/2,
            color: Colors.red,
          ),
          Container(
            height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.width/2,
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }
}
