import 'package:flutter/material.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

class TimeCards extends StatelessWidget {
  const TimeCards({
    super.key,
    required this.time,
    required this.eventData,
  }); // take in values for time and event data

  final String time;
  final String eventData;
  // final String calendarInfo;

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
            title: Text(time),
            subtitle: Text(eventData),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            TextButton(
              onPressed: () {},
              child: Text("Add to calendar"),
            ),
            TextButton(
              onPressed: () {},
              child: Text("More Information"),
            )
          ]),
        ],
      )),
    );
  }
}
