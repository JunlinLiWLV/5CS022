import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_companion/main.dart';

/// This page details all of the POI information for each campus.
/// This includes:
///   Lifts
///   Cafes
///   Stairs
///   etc.


class cityNav extends StatelessWidget{
  const cityNav({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text("Getting around the campus"),),
      body: Column(

        children: [
          Image.asset("lib/assets/placeholder_map.png")
        ],

      )
    );
  }

}