import 'package:flutter/material.dart';


class TimeCards extends StatelessWidget {
  const TimeCards({super.key, required this.time, required this.eventData});

  final String time;
  final String eventData;



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile( //do not use const here, since the variables are declared at runtime.
              leading: Icon(Icons.access_time_rounded),
              title: Text(time,),
              subtitle: Text(eventData),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('Remind Me'),
                  onPressed: () {
                    /* ... */
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}