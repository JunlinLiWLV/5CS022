import 'package:flutter/material.dart';
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
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          fontFamily: 'Roboto'
      ),
      title: 'Course Data',
      home: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: (){ Navigator.pop(context); },
            child: Icon(Icons.arrow_back),
          ),
          title: Text('Course Information: '),

        ),
        body:
            courseData != null
                ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(courseData['courseName'], style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, fontFamily: 'RobotoSlab'),),
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
                            Text("Why Wolverhampton?", style: TextStyle(fontSize: 24, fontFamily: 'RobotoSlab', fontWeight: FontWeight.w400),),
                            Text(courseData['whatHappens'] + "\n $bulletPoint" + courseData['courseVarious'][0]['interests'] + '\n ' + bulletPoint + courseData['courseVarious'][0]['employability']
                                + '\n ' + bulletPoint + courseData['courseVarious'][0]['placement'] + '\n ' + bulletPoint + courseData['courseVarious'][0]['ourLecturers']),
                            SizedBox( height: 10 ),
                            Text("Our Modules", style: TextStyle(fontSize: 24, fontFamily: 'RobotoSlab', fontWeight: FontWeight.w400),),
                            SizedBox( height: 5, ),
                            Text(bulletPoint + courseData['modules'][0]['module1'] + '\n' + bulletPoint + courseData['modules'][0]['module2'] + '\n' + bulletPoint + courseData['modules'][0]['module3'] + '\n' + bulletPoint + courseData['modules'][0]['module4'] + '\n' + bulletPoint + courseData['modules'][0]['module5'] + '\n' + bulletPoint + courseData['modules'][0]['module6']),
                            SizedBox( height: 10,),
                            Text("Entry Requirements", style: TextStyle(fontSize: 24, fontFamily: 'RobotoSlab', fontWeight: FontWeight.w400),),
                            SizedBox( height: 5, ),
                            Text(bulletPoint + "UCAS Tariff Points: " + courseData['courseRequirements'][0]['ucas'].toString() + '\n' + bulletPoint + "A-Level grades: " + courseData['courseRequirements'][0]['aLevel'] + '\n' + bulletPoint + "BTEC grades: " + courseData['courseRequirements'][0]['btec'] + '\n' + bulletPoint + "Access to Higher Education Diploma: " + courseData['courseRequirements'][0]['accessToHE'].toString() + " credits, with a minimum of " + courseData['courseRequirements'][0]['accessToHElv3'].toString() + " at level 3"),
                            SizedBox( height: 10 ),
                            Text("Skills Developed", style: TextStyle(fontSize: 24, fontFamily: 'RobotoSlab', fontWeight: FontWeight.w400),),
                            SizedBox( height: 5, ),
                            Text(bulletPoint + courseData['courseSkills'][0]['skill1'] + '\n' + bulletPoint + courseData['courseSkills'][0]['skill2'] + '\n' + bulletPoint + courseData['courseSkills'][0]['skill3']),
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
