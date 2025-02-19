import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

/// THIS CURRENT ITERATION OF THE MAP SCREEN IS SUBJECT TO CHANGE AND SHOULD ONLY BE VIEWED AS A PROOF OF CONCEPT.
/// CURRENT USAGE:
///        Shows a north-up map of the university city campus
///        A description below.

class mapPage extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    double currentHeight = MediaQuery.of(context).size.height; //gets the current height of the device being used.


    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints.expand(height: currentHeight * 0.7), //ensures the map will only ever use 70% (height) of a users screen
          child: FlutterMap(
            mapController: MapController(),
            options: MapOptions(
              initialCenter: LatLng(52.589460, -2.127833), //Rough coordinates of the University's city campus.
              initialZoom: 17,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', //use OpenStreetMap within application
                userAgentPackageName: 'com.open_day_companion.app',
              ),
              RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      "OpenStreetMapContributors",
                      onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                    ),
                  ]
              ),
            ],
          )
        ),
        ConstrainedBox(
          constraints: BoxConstraints.expand(height: currentHeight * 0.3), //Uses remaining space on screen
          child:  const Card( //temporary description of what is on the map.
            color: Colors.white,
              child: Text(
                "Above is a map of the WULFRUNA (South) and MOLINEUX (North) Campus. All of the buildings within these two areas are designated with an 'M' prefix, "
                    "followed by another letter designating the building, and finally a three digit room code, the first digit indicating which floor the room is on.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 12,
                  color: Colors.black
                ),
              ),
            )
        )
      ],
    );
  }


}