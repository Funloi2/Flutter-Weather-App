import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Home(),
));


class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aquatech Weather'),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(40.0, 60.0, 20.0, 5.0),
        margin: const EdgeInsets.all(30.0),
        color: Colors.grey,
        child: const Text("hello"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue[700],
        child: const Text("Click"),
      ),
    );
  }
}