import 'package:flutter/material.dart';
import 'course_info.dart';

class aboutUni extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About our University"),),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(child: Text("From its origins in the 1820s, the University of Wolverhampton has evolved to offer a wide range of courses, from Art "
                    "to Pharmaceutical Science, with study options ranging from foundation to postgraduate degrees."),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox( height: 10, ),
                Flexible(child: Text("At the University of Wolverhampton, we are proud to describe ourselves as the University of Opportunity, demonstrating our commitment to "
                    "making higher education more accessible and welcoming for prospective students, no matter their socioeconomic backgrounds. With over 29,000 students worldwide, and 2,100 staff, we strive to"
                    " deliver the best experiences possible, helping our students to thrive and fulfil their potential as they move into the next exciting chapter of their lives"))
              ],
            )
          ],
        ),
      )
    );
  }
}

class theCourses extends StatelessWidget{
  theCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Our Courses"), titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Center(
         child: Column(
            children: [
              Flexible(
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CourseInfo(course: 'G400'))) //changes page to the course selected
                    },
                    child: Container(
                        height: 150, width: 250,
                        child: Card(
                            child: Center(
                                child: Text(
                                  "Computer Science",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                                )
                            )
                        )
                    ),
                  )
              ),
              Flexible(
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CourseInfo(course: 'I161'))) //changes page to the course selected
                    },
                    child: Container(
                        height: 150, width: 250,
                        child: Card(
                            child: Center(
                                child: Text(
                                  "Cybersecurity",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                )
                            )
                        )
                    ),
                  )
              ),
              Flexible(
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CourseInfo(course: 'H846'))) //changes page to the course selected
                    },
                    child: Container(
                        height: 150, width: 250,
                        child: Card(
                            child: Center(
                                child: Text(
                                  "Chemical Engineering",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                )
                            )
                        )
                    ),
                  )
              )
            ],
          ),
        )
      )
    );
  }

}