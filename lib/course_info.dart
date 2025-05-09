import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

String bulletPoint = '\u2022 \t'; //add bullet point to simplify formatting

class CourseInfo extends StatefulWidget {
  // create a state that allows the page to be rebuilt foreach time it is loaded.
  var course;

  CourseInfo({super.key, required this.course});

  @override
  State<CourseInfo> createState() => _CourseInfoState();
}

class _CourseInfoState extends State<CourseInfo> {
  var courseData;
  var videoID;

  YoutubePlayerController? _controller;

  late String courseSelection = widget.course;

  Future<void> loadCourseAsset() async {
    //parse the json file for the selected course and store data into a local variable
    final String jsonString =
        await rootBundle.loadString('course_data/$courseSelection.json');
    var data = jsonDecode(jsonString);
    setState(() {
      courseData = data;
      //get video id from the course data
      videoID = courseData['courseVideo'];
      if (videoID != null) {
        //set video controller to play the video specified by the id
        _controller = YoutubePlayerController(
            initialVideoId: videoID,
            flags: const YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
            ));
      } else {
        _controller = null;
      }
    });
    print(videoID);
  }

  @override
  void initState() {
    // before page is loaded, load correct course data
    super.initState();
    loadCourseAsset();
  }

  @override
  void deactivate() {
    _controller?.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    //when the page is exited, destroy the controller to prevent unnecessary usage of resources
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          fontFamily: 'Roboto'),
      title: 'Course Data',
      home: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              }, // ensure the page can be exited
              child: Icon(Icons.arrow_back),
            ),
            title: Text('Course Information: '),
          ),
          body: // If the course data exists, display all of it on the page in the order defined below.
              courseData != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          courseData['courseName'],
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'RobotoSlab'),
                        ),
                        Text(
                          "UCAS code: " + courseData['courseCode'],
                          style: TextStyle(color: Colors.black87),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Flexible(
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 50),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      if (_controller != null)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 10,
                                          ),
                                          child: YoutubePlayer(
                                            controller: _controller!,
                                            showVideoProgressIndicator: true,
                                            progressIndicatorColor: Colors.cyan,
                                          ),
                                        ),
                                      Text(courseData['courseAbout']),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("At a glance:\n $bulletPoint" +
                                          courseData['courseUSP'][0]
                                              ['bullet1'] +
                                          '\n ' +
                                          bulletPoint +
                                          courseData['courseUSP'][0]
                                              ['bullet2'] +
                                          '\n ' +
                                          bulletPoint +
                                          courseData['courseUSP'][0]
                                              ['bullet3'] +
                                          '\n ' +
                                          bulletPoint +
                                          courseData['courseUSP'][0]
                                              ['bullet4']),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      IntrinsicWidth(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            ElevatedButton.icon(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext context) {
                                                        return ModulePopUp(
                                                            courseData: courseData);
                                                      });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5)
                                                    ),
                                                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                                    backgroundColor: Colors.blueGrey[600],
                                                    foregroundColor: Colors.white
                                                ),
                                                icon: Icon(Icons.menu_book_outlined, color: Colors.white,),
                                                label: Text(
                                                  "Our Modules",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'RobotoSlab',
                                                      fontWeight: FontWeight.w400),
                                                )
                                            ),
                                            SizedBox(height: 10,),
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return WhyPopUp(
                                                          courseData: courseData);
                                                    });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                                  backgroundColor: Colors.blueGrey[600],
                                                  foregroundColor: Colors.white
                                              ),
                                              icon: Icon(Icons.question_mark, color: Colors.white,),
                                              label: Text(
                                                "Why Wolverhampton?",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'RobotoSlab',
                                                    fontWeight: FontWeight.w400),
                                              )
                                            ),
                                            SizedBox(height: 10,),
                                            ElevatedButton.icon(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext context) {
                                                        return RequirementsPopUp(
                                                            courseData: courseData);
                                                      });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5)
                                                    ),
                                                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                                    backgroundColor: Colors.blueGrey[600],
                                                    foregroundColor: Colors.white
                                                ),
                                                icon: Icon(Icons.fact_check_outlined, color: Colors.white,),
                                                label: Text(
                                                  "Our Entry Requirements",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'RobotoSlab',
                                                      fontWeight: FontWeight.w400),
                                                )
                                            ),
                                            SizedBox(height: 10,),
                                            ElevatedButton.icon(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext context) {
                                                        return SkillsPopUp(
                                                            courseData: courseData);
                                                      });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5)
                                                    ),
                                                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                                    backgroundColor: Colors.blueGrey[600],
                                                    foregroundColor: Colors.white
                                                ),
                                                icon: Icon(Icons.star, color: Colors.white,),
                                                label: Text(
                                                  "Skills Developed",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'RobotoSlab',
                                                      fontWeight: FontWeight.w400),
                                                )
                                            ),
                                            SizedBox( height: 50 ,)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            )
                        ),
                      ],
                    )
                  : CircularProgressIndicator()), //if the course data is incomplete, return a progress indicator.
    );
  }
}

class SkillsPopUp extends StatelessWidget{
  final Map<String, dynamic> courseData;

  const SkillsPopUp({super.key, required this.courseData});

  //popup that contains all the skills from the relevant JSON file


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("What skills will you develop here?", style: TextStyle(fontFamily: 'RobotoSlab', fontWeight: FontWeight.w600, fontSize: 24)),
      content: SingleChildScrollView(
        child: Text(bulletPoint +
            courseData['courseSkills'][0]
                ['skill1'] +
            '\n' +
            bulletPoint +
            courseData['courseSkills'][0]
                ['skill2'] +
            '\n' +
            bulletPoint +
            courseData['courseSkills'][0]
                ['skill3']),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class RequirementsPopUp extends StatelessWidget{
  final Map<String, dynamic> courseData;

  const RequirementsPopUp({super.key, required this.courseData});

  //contains all requirements for the popup from JSON

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("What are our Entry Requirements?", style: TextStyle(fontFamily: 'RobotoSlab', fontWeight: FontWeight.w600, fontSize: 24)),
      content: SingleChildScrollView(
        child: Text(bulletPoint +
            "UCAS Tariff Points: " +
            courseData['courseRequirements'][0]
                    ['ucas']
                .toString() +
            '\n' +
            bulletPoint +
            "A-Level grades: " +
            courseData['courseRequirements'][0]
                ['aLevel'] +
            '\n' +
            bulletPoint +
            "BTEC grades: " +
            courseData['courseRequirements'][0]
                ['btec'] +
            '\n' +
            bulletPoint +
            "Access to Higher Education Diploma: " +
            courseData['courseRequirements'][0]
                    ['accessToHE']
                .toString() +
            " credits, with a minimum of " +
            courseData['courseRequirements'][0]
                    ['accessToHElv3']
                .toString() +
            " at level 3"),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class WhyPopUp extends StatelessWidget {
  final Map<String, dynamic> courseData;

  const WhyPopUp({super.key, required this.courseData});

  //contains information from JSON about why you should pick wolverhampton

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Why choose Wolverhampton?", style: TextStyle(fontFamily: 'RobotoSlab', fontWeight: FontWeight.w600, fontSize: 24)),
      content: SingleChildScrollView(
        child: Text(courseData['whatHappens'] +
            "\n $bulletPoint" +
            courseData['courseVarious'][0]
                ['interests'] +
            '\n ' +
            bulletPoint +
            courseData['courseVarious'][0]
                ['employability'] +
            '\n ' +
            bulletPoint +
            courseData['courseVarious'][0]
                ['placement'] +
            '\n ' +
            bulletPoint +
            courseData['courseVarious'][0]
                ['ourLecturers']),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

}

class ModulePopUp extends StatelessWidget {
  final Map<String, dynamic> courseData;

  const ModulePopUp({super.key, required this.courseData});

  //popup containing the names of the modules in the course


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Our Modules", style: TextStyle(fontFamily: 'RobotoSlab', fontWeight: FontWeight.w600, fontSize: 24)),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text("In Year 1 (Level 4), you will study: "),
            Text(courseData['modules'][0]['module1']),
            Text(courseData['modules'][0]['module2']),
            Text(courseData['modules'][0]['module3']),
            Text(courseData['modules'][0]['module4']),
            Text(courseData['modules'][0]['module5']),
            Text(courseData['modules'][0]['module6']),]
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}