import 'package:flutter/material.dart';

class AndroidPage extends StatefulWidget {
  @override
  AndroidState createState() => AndroidState();
}

class AndroidState extends State<AndroidPage> {
  bool loveFlutter = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notre Design sous Android"),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: () {
            setState(() {
              loveFlutter = !loveFlutter;
            });
          }, child: Text((loveFlutter) ? "I Love Flutter": "php is my Favorite"))
        ],
      ),
    );
  }
}