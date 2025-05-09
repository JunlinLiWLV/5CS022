import 'package:flutter/material.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

class TimeCards extends StatelessWidget {
  const TimeCards({
    super.key,
    required this.time,
    required this.eventData,
    required this.eventLocation,
  }); // take in values for time and event data

  final DateTime time;
  final String eventData;
  final String eventLocation;
  // final String calendarInfo;

  Event buildEvent({Recurrence? recurrence}) {
    return Event(
      title: eventData,
      description: "Open day at the University of Wolverhampton",
      location:
          "The University of Wolverhampton - Room Number: ${eventLocation}",
      startDate: time,
      endDate: time.add(const Duration(minutes: 60)),
      allDay: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // construct a card
      child: Card(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            //do not use const here, since the variables are declared at runtime.
            leading: Icon(Icons.access_time_rounded),
            title: Text(
                "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}",
                style: TextStyle(
                    fontFamily: 'RobotoSlab',
                    fontWeight: FontWeight.w600,
                    fontSize: 16)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventData,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
                Text("Room Number: ${eventLocation}")
              ],
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            TextButton(
              onPressed: () {
                //send calendar information to the user's default calendar app to be added/
                Add2Calendar.addEvent2Cal(
                  buildEvent(),
                );
              },
              child: Text("Add to calendar"),
            ),
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      //display the map popup
                      return PopUpMap(roomData: eventLocation,);
                    });
              },
              child: Text("Where to go"),
            )
          ]),
        ],
      )),
    );
  }
}

class PopUpMap extends StatelessWidget {
  PopUpMap({super.key, required this.roomData});

  final String roomData;

  //define markers for lift and stairs locations.
  List<Marker> _commonMarkers = [
    Marker(point: LatLng(52.5887000, -2.1271724), child: Icon(Icons.elevator_outlined)),
    Marker(point: LatLng(52.5879180, -2.1269779), child: Icon(Icons.elevator_outlined)),
    Marker(point: LatLng(52.5882351, -2.1265964), child: Icon(Icons.stairs_outlined)),
    Marker(point: LatLng(52.5879180, -2.1269778), child: Icon(Icons.stairs_outlined)),
  ];

  //find room based on data received.
  LatLng findRoom(){
    if(roomData == "MC001"){
      return LatLng(52.5887028, -2.1273885);
    } else if (roomData == "MC401"){
      return LatLng(52.5888454, -2.1276276);
    } else if (roomData == "MI226-7") {
      return LatLng(52.5876953, -2.1264870);
    } else {
      return LatLng(52.589460, -2.127833);
    }
  }

  //backup coordinates if find room isn't called
  LatLng cityCampus = LatLng(52.589460, -2.127833);

  //add description based on room data
  String findRoomDesc(){
    if(roomData == "MC001"){
      return ("MC001 is located on the ground floor of the Millennium building, just before the stairs on the right.");
    } else if (roomData == "MC401"){
      return ("MC401 is locate on the fourth floor of the Millennium building, when exiting the lifts on the fourth floor go right");
    } else if (roomData == "MI226-7") {
      return ("MI226-7 is located on the second floor of the Alan Turing Building, take the lift or stairs, then follow signs to find it");
    } else {
      return ("Error getting room location data, please try again.");
    }
  }


  //create an alert dialogue with a map at the top and a description on the bottom.
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: FlutterMap(
                      mapController: MapController(),
                      options: MapOptions(
                        initialCenter: findRoom() ?? cityCampus, //Rough coordinates of the University's city campus.
                        initialZoom: 18,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png', //use OpenStreetMap within application
                          userAgentPackageName: 'com.open_day_companion.app',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                                point: findRoom() ?? cityCampus,
                                child: Icon(Icons.location_on_outlined, size: 50, color: Colors.indigo,)
                            ),
                            ..._commonMarkers,
                          ],
                        ),
                        RichAttributionWidget(attributions: [
                          TextSourceAttribution(
                            "OpenStreetMapContributors",
                            onTap: () => launchUrl(
                                Uri.parse('https://openstreetmap.org/copyright')),
                          ),
                        ]),
                      ],
                    )
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                      findRoomDesc(),
                    style: TextStyle(fontFamily: 'RobotoSlab', fontWeight: FontWeight.w600, fontSize: 16,),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            )
        )
    );
  }
}
