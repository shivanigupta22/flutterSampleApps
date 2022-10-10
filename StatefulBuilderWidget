import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: StatefulBuilderInternalWidget(),
    );
  }
}

//StatefulBuilder Widget extends stateful widget and 
//returns a widget that can handle it's state
//rebuilds widget when state is changed
//can cover only impacted widget and hence will not impact other outside widgets
class StatefulBuilderWidget extends StatelessWidget {
    bool isRed = false;

  StatefulBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LayoutBuilder Example')),
      body: Column(
        children: [
//           StatefulBuilder(
//           builder: (context,setState) {
//             return Column(
//             children: [
//               isRed ? const Text("Red") : const Text("Green"),
//              TextButton(onPressed: () {
//                setState(() => isRed = !isRed);
//              },child:Text("click me"))
             
//             ]
//             );
//           }
//         ),
          StatefulBuilderInternalStatefulWidget(),
          const Text("hi state less") // won't be rebuild as it is outside
      ]
    ));
  }
}


//similar to StatefulBuilderWidget
class StatefulBuilderInternalWidget extends StatelessWidget {
    bool isRed = false;

  StatefulBuilderInternalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LayoutBuilder Example')),
      body: Column(
        children: [
          StatefulBuilder(
          builder: (context,setState) {
            return Column(
            children: [
              isRed ? const Text("Red") : const Text("Green"),
             TextButton(onPressed: () {
               setState(() => isRed = !isRed);
             },child:Text("click me"))
             
            ]
            );
          }
        ),
          const Text("hi state less") // won't be rebuild as it is outside
      ]
    ));
  }
}

class StatefulBuilderInternalStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatefulBuilderInternalState();
  
}

class _StatefulBuilderInternalState extends State {
      bool isRed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
            children: [
              isRed ? const Text("Red") : const Text("Green"),
             TextButton(onPressed: () {
               setState(() => isRed = !isRed);
             },child:Text("click me"))
             
            ]
            );
  }
  
}
