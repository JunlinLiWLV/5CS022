import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'course_info.dart';

class aboutUni extends StatelessWidget{

  late final WebViewController _controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(Uri.parse('https://www.wlv.ac.uk/about-us/'));

  // @override
  // void initState(){
  //   _controller = WebViewController();
  //   _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
  //   _controller.loadRequest(Uri.parse('https://www.wlv.ac.uk/about-us/'));
  // }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () async {
              if (await _controller.canGoBack()) {
                await _controller.goBack();
              } else {
                Navigator.pop(context);
              }
            },
            child: const Icon(Icons.arrow_back),
          ),
          title: Text("About Us", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, fontFamily: 'RobotoSlab'),),
        ),
        body: WebViewWidget(controller: _controller,)
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