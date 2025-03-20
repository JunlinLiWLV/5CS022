import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class wulfrunaNav extends StatelessWidget{
  const wulfrunaNav({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text("Getting around the campus"),),
      body: Column(

        children: [
          InteractiveViewer(
            boundaryMargin: EdgeInsets.all(100),
              child: Image.asset("lib/assets/wulfruna_placeholder_map.png"),
          )
        ],
      )
    );
  }
}

class molineuxNav extends StatelessWidget{
  const molineuxNav({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(title: Text("Getting around the campus"),),
        body: Column(

          children: [
            InteractiveViewer(
              boundaryMargin: EdgeInsets.all(100),
              child: Image.asset("lib/assets/placeholder_map.png"),
            )
          ],
        )
    );
  }
}