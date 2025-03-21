import 'package:flutter/material.dart';
import 'widgets.dart'; //store all reusable widgets away from main application code.
import 'map_pages.dart'; //store map away from main application, due to possible complexity.
import 'registration_page.dart'; //store the registration page away from main, due to it's large size.
import 'about_uni.dart'; //import the about page
import 'qr_scanner.dart';

void main() {

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WLV Open Day',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const OpenDayCompanionApp(title: 'WLV Open Day App'),
    );
  }
}

class OpenDayCompanionApp extends StatefulWidget {
  const OpenDayCompanionApp({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  final String title;

  @override
  State<OpenDayCompanionApp> createState() =>
      _OpenDayCompanionAppState(); //set the entry point of the application, the home page
}

class _OpenDayCompanionAppState extends State<OpenDayCompanionApp> {
  var selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedPage) {
      //page navigation. When each one of the navigation buttons of pressed, direct to the relevant page.
      case 0:
        page = basePage();
        break;
      case 1:
        page = timeTablePage();
        break;
      case 2:
        // page = qrScanPage();
        page = QRScanner();
        break;
      case 3:
        page = theRegistrationPage();
        break;
      case 4:
        page = mapBasePage();
        break;
      default:
        throw UnimplementedError(
            "Page $selectedPage is not currently available");
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            // SafeArea(
            //     child: NavigationRail(
            //       backgroundColor: Colors.black12,
            //   //build the navigation rail
            //   extended: constraints.maxWidth >=
            //       600, //only allow the navigation rail to be 600 pixels wide
            //   destinations: [
            //     NavigationRailDestination(
            //         icon: Icon(Icons.home), label: Text('home')),
            //     NavigationRailDestination(
            //         icon: Icon(Icons.view_agenda_outlined),
            //         label: Text("Timetable")),
            //     NavigationRailDestination(
            //         icon: Icon(Icons.qr_code_scanner),
            //         label: Text("QR Scanner")),
            //     NavigationRailDestination(
            //         icon: Icon(Icons.app_registration_outlined),
            //         label: Text("Register")),
            //     NavigationRailDestination(
            //         icon: Icon(Icons.map), label: Text("Map"))
            //   ], //define each one of the destinations
            //
            //   selectedIndex:
            //       selectedPage, //change the current page to the selected page
            //   onDestinationSelected: (value) {
            //     setState(() {
            //       selectedPage = value;
            //     });
            //   },
            // )),
            Expanded(
              //define the area for each page
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            )
          ],
        ),
      );
    });
  }
}

class basePage extends StatelessWidget {
  /// This is currently the default page, it only has a text label as a placeholder

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("WLV Open Day"),
      // ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox( height: 15 ),
            Center( //page title
              child: Text(
                "Welcome to Wolverhampton!",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, fontFamily: 'RobotoSlab'),
              ),
            ),
            SizedBox(height: 20),
            Center( //subtitle for the page
              child: Text(
                "Feel free to have a look around here for any information for our upcoming open day.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(height: 50),
            IntrinsicWidth( //container for the buttons, ensures all are the same width
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => theCourses())); //change to page containing courses
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
                        "Our Courses",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox( height: 10 ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => timeTablePage())); //change to page containing time table
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          backgroundColor: Colors.blueGrey[600],
                          foregroundColor: Colors.white
                      ),
                      icon: Icon(Icons.calendar_month, color: Colors.white,),
                      label: Text(
                        "What's On?",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox( height: 10 ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => theRegistrationPage())); // change to registration page
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          backgroundColor: Colors.blueGrey[600],
                          foregroundColor: Colors.white
                      ),
                      icon: Icon(Icons.app_registration_outlined, color: Colors.white,),
                      label: Text(
                        "Register Here",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox( height: 10 ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => cityMapPage())); // change to show the city campus
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          backgroundColor: Colors.blueGrey[600],
                          foregroundColor: Colors.white
                      ),
                      icon: Icon(Icons.pin_drop, color: Colors.white,),
                      label: Text(
                        "Our Campus",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox( height: 10 ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => QRScanner())); // change page to QR code scanner
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          backgroundColor: Colors.blueGrey[600],
                          foregroundColor: Colors.white
                      ),
                      icon: Icon(Icons.qr_code_scanner, color: Colors.white,),
                      label: Text(
                        "Scan a QR Code",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox( height: 10 ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => aboutUni()));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          backgroundColor: Colors.blueGrey[600],
                          foregroundColor: Colors.white
                      ),
                      icon: Icon(Icons.help_outline, color: Colors.white,),
                      label: Text(
                        "About Wolverhampton",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                )
            ),
          ],
        ),
      )

    );
  }
}

class unavailablePage extends StatelessWidget { //use as a placeholder until pages are finished
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError(
        "This page is not yet implemented, please check back later.");
  }
}

class timeTablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.height; //gets the current height of the device being used.

    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          fontFamily: 'Roboto'
      ),
      title: "The Timetable",
      home: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: (){ Navigator.pop(context); },
              child: Icon(Icons.arrow_back),
            ),
            title: Text("Timetable"),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20), //keep a 20 pixel border around the outside of all the time cards
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: currentHeight), //make the box take up all the available space
              child: Column(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly, //space all the following objects to fill out the entire screen space
                children: [
                  TimeCards(
                    time: '9:00am',
                    eventData: 'Welcome to Wolverhampton! -- MC001',
                  ),
                  TimeCards(
                    time: '10:00am',
                    eventData: "What's on today? -- MC001",
                  ),
                  TimeCards(
                    time: '11:00am',
                    eventData: 'Q&A with Course Reps. -- MC001',
                  ),
                  TimeCards(
                    time: '12:30pm',
                    eventData: 'About Computer Science',
                  ),
                  TimeCards(
                    time: '1:00pm',
                    eventData: 'Common questions about University',
                  ),
                  TimeCards(
                    time: '3:00pm',
                    eventData: 'About Cybersecurity',
                  ),
                  TimeCards(
                    time: '5:00pm',
                    eventData: 'About Chemical Engineering',
                  ),
                  TimeCards(
                    time: '6:00pm',
                    eventData: 'End of the Day',
                  ),
                ],
              ),

            ),
          )
      )
    );
  }
}

// class qrScanPage extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     throw UnimplementedError("QR Functionality has not yet been added");
//   }
// }

class theRegistrationPage extends StatefulWidget {
  const theRegistrationPage({super.key});

  @override
  registrationForm createState() {
    return registrationForm(); // return registration page from another file, registration_page.dart
  }
}
