
import 'package:flutter/material.dart';
import 'widgets.dart'; //store all reusable widgets away from main application code.
import 'map_pages.dart'; //store map away from main application, due to possible complexity.

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'WLV Open Day App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState(); //set the entry point of the application, the home page
}

class _MyHomePageState extends State<MyHomePage> {

  var selectedPage = 0;


  @override
  Widget build(BuildContext context) {

    Widget page;
    switch(selectedPage){ //page navigation. When each one of the navigation buttons of pressed, direct to the relevant page.
      case 0:
        page = basePage();
        break;
      case 1:
        page = timeTablePage();
        break;
      case 2:
        page = qrScanPage();
        break;
      case 3:
        page = registerPage();
        break;
      case 4:
        page = mapBasePage();
        break;
      default:
        throw UnimplementedError("Page $selectedPage is not currently available");
      }

    return LayoutBuilder(
      builder: (context, constraints){
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail( //build the navigation rail
                  extended: constraints.maxWidth >= 600, //only allow the navigation rail to be 600 pixels wide
                  destinations: [
                    NavigationRailDestination(icon: Icon(Icons.home), label: Text('home')),
                    NavigationRailDestination(icon: Icon(Icons.view_agenda_outlined), label: Text("Timetable")),
                    NavigationRailDestination(icon: Icon(Icons.qr_code_scanner), label: Text("QR Scanner")),
                    NavigationRailDestination(icon: Icon(Icons.app_registration_outlined), label: Text("Register")),
                    NavigationRailDestination(icon: Icon(Icons.map), label: Text("Map"))
                  ], //define each one of the destinations

                  selectedIndex: selectedPage, //change the current page to the selected page
                  onDestinationSelected: (value){
                    setState(() {
                      selectedPage = value;
                    });
                  },

                )
              ),
              Expanded( //define the area for each page
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              )
            ],
          ),
        );
      }
    );


  }

}




class basePage extends StatelessWidget{

  /// This is currently the default page, it only has a text label as a placeholder

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, //align content to the centre
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.min, //make the row as small as possible
            children: [
              Text("Under Construction",
              style: TextStyle(
                fontSize: 32,
              ),)
            ],
          ),
        ],
      )
    );
  }
  
}

class timeTablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
        builder: (context, constraints){
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20), //keep a 20 pixel border around the outside of all the time cards
            child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight), //make the box take up all the available space
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, //space all the following objects to fill out the entire screen space
                  children: [
                    TimeCards(time: '9:00am', eventData: 'Welcome to Wolverhampton! -- MC001',),
                    TimeCards(time: '10:00am', eventData: "What's on today? -- MC001",),
                    TimeCards(time: '11:00am', eventData: 'Q&A with Course Reps. -- MC001',),
                    TimeCards(time: '12:30pm', eventData: 'Another event',),
                    TimeCards(time: '1:00pm', eventData: 'Another event',),
                    TimeCards(time: '3:00pm', eventData: 'Another event',),
                    TimeCards(time: '5:00pm', eventData: 'Another event',),
                  ],
                ),
                //child: Placeholder(),
            ),
          );
        }
    );
  }

}




class qrScanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError("QR Functionality has not yet been added");
  }
  
}

class registerPage extends StatelessWidget {

  ///requires additional work and the DB connector to add proper functionality.

  final textController = TextEditingController();

  bool isChecked = true;
  late String name;

  @override
  Widget build(BuildContext context){
    return Center(
        child: Card(
          margin: EdgeInsets.all(15.0),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: "Your Name"),
                  controller: textController, //add a controller to the box, allows for text to be read
                ),
                SizedBox( height: 10 ), //add space between each one of the text fields
                TextField(
                  decoration: InputDecoration(labelText: "Email Address"),
                ),
                SizedBox( height: 10 ),
                TextField(
                  decoration: InputDecoration(labelText: "Telephone Number"),
                ),
                SizedBox( height: 10 ),
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    // setState(() {
                    //   isChecked = value!;
                    // });
                  }
                  ),
                ElevatedButton(
                    onPressed: (){
                      print("Registration Pressed");
                      print(textController.text); //print whatever has been entered as a name to the terminal, currently in place to test functionality
                    },
                    child: Text("Register!!")
                )
              ],
            )
          ),
        ),
    );

    // throw UnimplementedError("This page is not yet available");
  }
}


