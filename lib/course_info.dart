import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';

String bulletPoint = '\u2022 \t'; //add bullet point to simplify

class CourseInfo extends StatefulWidget {
  var course;

  CourseInfo({super.key, required this.course});

  @override
  State<CourseInfo> createState() => _CourseInfoState();
}

class _CourseInfoState extends State<CourseInfo> {
  var courseData;

  late String courseSelection = widget.course;

  Future<void> loadCourseAsset() async {
    final String jsonString = await rootBundle.loadString('course_data/$courseSelection.json');
    var data = jsonDecode(jsonString);
    setState(() {
      courseData = data;
    });
    //print(jsonData);
  }

  @override
  void initState() {
    super.initState();
    loadCourseAsset();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Data',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Course Information: '),
        ),
        body:
            courseData != null
                ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(courseData['courseName'], style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, fontFamily: 'Roboto_Slab'),),
                Text("UCAS code: " + courseData['courseCode'], style: TextStyle(color: Colors.black87),),
                SizedBox( height: 10, ),
                Flexible(child:
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
                    child: SingleChildScrollView(
                      child: Column(
                          children: [
                            Text(courseData['courseAbout']),
                            SizedBox( height: 10, ),
                            Text("At a glance:\n $bulletPoint" + courseData['courseUSP'][0]['bullet1'] + '\n ' + bulletPoint + courseData['courseUSP'][0]['bullet2']
                            + '\n ' + bulletPoint + courseData['courseUSP'][0]['bullet3'] + '\n ' + bulletPoint + courseData['courseUSP'][0]['bullet4']),
                            SizedBox( height: 10, ),
                            Text("Why Wolverhampton?", style: TextStyle(fontSize: 24, fontFamily: 'Roboto_Slab'),),
                            Text(courseData['whatHappens'] + "\n $bulletPoint" + courseData['courseVarious'][0]['interests'] + '\n ' + bulletPoint + courseData['courseVarious'][0]['employability']
                                + '\n ' + bulletPoint + courseData['courseVarious'][0]['placement'] + '\n ' + bulletPoint + courseData['courseVarious'][0]['ourLecturers']),

                          ],
                      ),
                    )
                  )
                ),
              ],
            )
                : CircularProgressIndicator()),
      );
  }
}
