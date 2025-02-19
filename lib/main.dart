
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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
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
        page = mapPage();
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
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(icon: Icon(Icons.home), label: Text('home')),
                    NavigationRailDestination(icon: Icon(Icons.view_agenda_outlined), label: Text("Timetable")),
                    NavigationRailDestination(icon: Icon(Icons.qr_code_scanner), label: Text("QR Scanner")),
                    NavigationRailDestination(icon: Icon(Icons.app_registration_outlined), label: Text("Register")),
                    NavigationRailDestination(icon: Icon(Icons.map), label: Text("Map"))
                  ],

                  selectedIndex: selectedPage,
                  onDestinationSelected: (value){
                    setState(() {
                      selectedPage = value;
                    });
                  },

                )
              ),
              Expanded(
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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Hello!")
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
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  controller: textController,
                ),
                SizedBox( height: 10 ),
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
                      print(textController.text);
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


