import 'package:flutter/material.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

// class TimeCards extends StatelessWidget {
//   const TimeCards({
//     super.key,
//     required this.time,
//     required this.eventData,
//   }); // take in values for time and event data
//
//   final String time;
//   final String eventData;
//   // final String calendarInfo;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       // construct a card
//       child: Card(
//           child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           ListTile(
//             //do not use const here, since the variables are declared at runtime.
//             leading: Icon(Icons.access_time_rounded),
//             title: Text(time),
//             subtitle: Text(eventData),
//           ),
//           Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//             TextButton(
//               onPressed: () {},
//               child: Text("Add to calendar"),
//             ),
//             TextButton(
//               onPressed: () {},
//               child: Text("More Information"),
//             )
//           ]),
//         ],
//       )),
//     );
//   }
// }

class TimeCards extends StatelessWidget {
  const TimeCards({
    super.key,
    required this.time,
    required this.eventData,
  }); // take in values for time and event data

  final DateTime time;
  final String eventData;
  // final String calendarInfo;

  Event buildEvent({Recurrence? recurrence}){
    return Event(
      title: eventData,
      description: "Open day at the University of Wolverhampton",
      location: "The University of Wolverhampton - City Campus",
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
                title: Text("${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}"),
                subtitle: Text(eventData),
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
                  onPressed: () {},
                  child: Text("More Information"),
                )
              ]),
            ],
          )),
    );



  }
}

