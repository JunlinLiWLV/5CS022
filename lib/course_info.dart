import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';

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
        body: Center(
            child: courseData != null
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(courseData['courseName']), Text(courseData['courseUSP'][0]['bullet1'])],
            )
                : CircularProgressIndicator()),
      ),
    );
  }
}
