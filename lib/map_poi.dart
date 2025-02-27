import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_companion/main.dart';

/// This page details all of the POI information for each campus.
/// This includes:
///   Lifts
///   Cafes
///   Stairs
///   etc.


class cityPOI extends StatelessWidget{
  const cityPOI({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("City points of interest called");
    Navigator.pop(context, MaterialPageRoute(builder: (context) => const MyHomePage(title: "WLV Open")));
    throw UnimplementedError("This page is not yet ready");
  }

}