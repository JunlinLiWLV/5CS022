import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_companion/map_poi.dart';
import 'package:url_launcher/url_launcher.dart';

///
/// mapBasePage is currently unused as the demo only needs to focus on the city campus. The city campus page is accessed without need for the mapBasePage class, but it remains
/// as it may be used in future versions of the application.
///

class mapBasePage extends StatelessWidget {
  const mapBasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Select a campus")), //page name displayed at the top
      body: Center(
        child: IntrinsicWidth(
          //make all of the buttons the same width, automatically finds widest child and matches all.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const cityMapPage())); //changes page to the city map
                  },
                  child: Text("City Campus")),
              SizedBox(height: 10), //add space between each one of the buttons
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const walsallMapPage())); //changes page to walsall
                  },
                  child: Text("Walsall Campus")),
              SizedBox(height: 10), //add space between each one of the buttons
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const telfordMapPage())); //changes page to telford
                  },
                  child: Text("Telford Campus")),
              SizedBox(height: 10), //add space between each one of the buttons
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const springfieldMapPage())); //changes page to springfield
                  },
                  child: Text("Springfield Campus"))
            ],
          ),
        ),
      ),
    );
  }
}

class cityMapPage extends StatelessWidget {
  const cityMapPage(
      {super.key}); //allows for the 'Navigate' function to work correctly

  //define markers for cafe, entrances, lift and stairs locations.
  static const List<Marker> _commonMarkers = [
    Marker(
        point: LatLng(52.5887000, -2.1271724),
        child: Icon(Icons.elevator_outlined)),
    Marker(
        point: LatLng(52.5879180, -2.1269779),
        child: Icon(Icons.elevator_outlined)),
    Marker(
        point: LatLng(52.5880729, -2.1278658),
        child: Icon(Icons.elevator_outlined)),
    Marker(
        point: LatLng(52.5882351, -2.1265964),
        child: Icon(Icons.stairs_outlined)),
    Marker(
        point: LatLng(52.5879180, -2.1269778),
        child: Icon(Icons.stairs_outlined)),
    Marker(
        point: LatLng(52.5886524, -2.1276704),
        child: Icon(Icons.local_cafe_outlined)),
    Marker(
        point: LatLng(52.5882166, -2.1280443),
        child: Icon(Icons.local_cafe_outlined)),
    Marker( //new
        point: LatLng(52.5882315, -2.1283840),
        child: Icon(Icons.waving_hand_outlined)),
    Marker(
        point: LatLng(52.5881725, -2.1277206),
        child: Icon(Icons.info_outline_rounded)),
    Marker(
        point: LatLng(52.5886099, -2.1268008),
        child: Icon(Icons.waving_hand_outlined)),

  ];

  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context)
        .size
        .height; //gets the current height of the device being used.

    return Scaffold(
        appBar: AppBar(title: Text('The City Campus')),
        body: Column(
          children: [
            ConstrainedBox(
                constraints: BoxConstraints.expand(
                    height: currentHeight * 0.6 -
                        56), //ensures the map will only ever use ~60% (height) of a users screen
                child: FlutterMap(
                    mapController: MapController(),
                    options: MapOptions(
                      initialCenter: LatLng(52.589460,
                          -2.127833), //Rough coordinates of the University's city campus.
                      initialZoom: 17,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png', //use OpenStreetMap within application
                        userAgentPackageName: 'com.open_day_companion.app',
                      ),
                      RichAttributionWidget(attributions: [
                        TextSourceAttribution(
                          "OpenStreetMapContributors",
                          onTap: () => launchUrl(
                              Uri.parse('https://openstreetmap.org/copyright')),
                        ),
                      ]),
                      MarkerLayer(
                        markers: [
                          ..._commonMarkers,
                        ],
                      ),
                    ])),
            ConstrainedBox(
              constraints: BoxConstraints.expand(
                  height: currentHeight * 0.2), //Uses remaining space on screen
              child: const Card(
                //temporary description of what is on the map.
                color: Colors.white,
                child: Text(
                  "Above is a map of the Wulfruna (South) and Molineux (North) Campus. All of the buildings within these two areas are designated with an 'M' prefix, "
                  "followed by another letter designating the building, and finally a three digit room code, the first digit indicating which floor the room is on.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: Colors.blueGrey),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const wulfrunaNav())); // show detailed map of the Wulfruna Campus
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  backgroundColor: Colors.blueGrey[600],
                  foregroundColor: Colors.white),
              child: Text('About the Wulfruna Campus'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const molineuxNav())); // show a detailed map of the Molineux campus
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  backgroundColor: Colors.blueGrey[600],
                  foregroundColor: Colors.white),
              child: Text('About the Molineux Campus'),
            ),
          ],
        ));
  }
}

class walsallMapPage extends StatelessWidget {
  const walsallMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context)
        .size
        .height; //gets the current height of the device being used.

    return Scaffold(
        appBar: AppBar(title: Text('The Walsall Campus')),
        body: Column(
          children: [
            ConstrainedBox(
                constraints: BoxConstraints.expand(
                    height: currentHeight * 0.7 -
                        56), //ensures the map will only ever use 70% (height) of a users screen
                child: FlutterMap(
                  mapController: MapController(),
                  options: MapOptions(
                    initialCenter: LatLng(52.571336,
                        -1.969109), //Rough coordinates of the University's Walsall campus.
                    initialZoom: 17,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png', //use OpenStreetMap within application
                      userAgentPackageName: 'com.open_day_companion.app',
                    ),
                    RichAttributionWidget(attributions: [
                      TextSourceAttribution(
                        "OpenStreetMapContributors",
                        onTap: () => launchUrl(
                            Uri.parse('https://openstreetmap.org/copyright')),
                      ),
                    ]),
                  ],
                )),
            ConstrainedBox(
                constraints: BoxConstraints.expand(
                    height:
                        currentHeight * 0.3), //Uses remaining space on screen
                child: const Card(
                  //temporary description of what is on the map.
                  color: Colors.white,
                  child: Text(
                    "Above is a map of the Walsall Campus. All of the buildings within this area are designated with a 'W' prefix.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        color: Colors.black),
                  ),
                ))
          ],
        ));
  }
}

class telfordMapPage extends StatelessWidget {
  const telfordMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context)
        .size
        .height; //gets the current height of the device being used.

    return Scaffold(
        appBar: AppBar(title: Text('The Telford (Shropshire) Campus')),
        body: Column(
          children: [
            ConstrainedBox(
                constraints: BoxConstraints.expand(
                    height: currentHeight * 0.7 -
                        56), //ensures the map will only ever use 70% (height) of a users screen
                child: FlutterMap(
                  mapController: MapController(),
                  options: MapOptions(
                    initialCenter: LatLng(52.683676,
                        -2.425365), //Rough coordinates of the University's Telford campus.
                    initialZoom: 17,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png', //use OpenStreetMap within application
                      userAgentPackageName: 'com.open_day_companion.app',
                    ),
                    RichAttributionWidget(attributions: [
                      TextSourceAttribution(
                        "OpenStreetMapContributors",
                        onTap: () => launchUrl(
                            Uri.parse('https://openstreetmap.org/copyright')),
                      ),
                    ]),
                  ],
                )),
            ConstrainedBox(
                constraints: BoxConstraints.expand(
                    height:
                        currentHeight * 0.3), //Uses remaining space on screen
                child: const Card(
                  //temporary description of what is on the map.
                  color: Colors.white,
                  child: Text(
                    "Above is a map of the Telford Campus. All of the buildings within this area are designated with an 'S' prefix",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        color: Colors.black),
                  ),
                ))
          ],
        ));
  }
}

class springfieldMapPage extends StatelessWidget {
  const springfieldMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context)
        .size
        .height; //gets the current height of the device being used.

    return Scaffold(
        appBar: AppBar(title: Text('The Springfield Campus')),
        body: Column(
          children: [
            ConstrainedBox(
                constraints: BoxConstraints.expand(
                    height: currentHeight * 0.7 -
                        56), //ensures the map will only ever use 70% (height) of a users screen
                child: FlutterMap(
                  mapController: MapController(),
                  options: MapOptions(
                    initialCenter: LatLng(52.591510,
                        -2.121153), //Rough coordinates of the University's Springfield campus.
                    initialZoom: 17,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png', //use OpenStreetMap within application
                      userAgentPackageName: 'com.open_day_companion.app',
                    ),
                    RichAttributionWidget(attributions: [
                      TextSourceAttribution(
                        "OpenStreetMapContributors",
                        onTap: () => launchUrl(
                            Uri.parse('https://openstreetmap.org/copyright')),
                      ),
                    ]),
                  ],
                )),
            ConstrainedBox(
                constraints: BoxConstraints.expand(
                    height:
                        currentHeight * 0.3), //Uses remaining space on screen
                child: const Card(
                  //temporary description of what is on the map.
                  color: Colors.white,
                  child: Text(
                    "Above is a map of the Springfield Campus",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12,
                        color: Colors.black),
                  ),
                ))
          ],
        ));
  }
}
