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
                      return PopUpMap();
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
  const PopUpMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
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
              ],
            )));
  }
}
