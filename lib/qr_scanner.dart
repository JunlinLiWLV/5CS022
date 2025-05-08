import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:open_companion/course_info.dart';
import 'package:open_companion/qr_db.dart';
// import 'package:open_companion/server.OLD/qr_db.dart';


class QRScanner extends StatefulWidget{
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();

}


class _QRScannerState extends State<QRScanner> {

  bool _valid = false;

  Future<List<String>?> checkValidity(String course) async{ //function to get the return of the DB search and check if a code is valid

    Future<List<String>?> _futureCodes = searchQR();
    List<String>? validCodes = await _futureCodes; //get codes from a future variable to a standard List
    print(validCodes); //print the codes into console for easier debug

    if(validCodes!.contains(course)){ //if the code scanned is contained in the database, _valid will be set to true, else nothing happens
      print("valid code found!");
      setState(() {
        _valid = true;
      });
    } else {
      print("code not valid");
      setState(() {
        _valid = false;
      });
    }
  }

  var courses;


  // Future<void> getCourses() async{
  //
  //   setState(() {
  //     courses = searchQR();
  //   });
  //
  // }

  Barcode? _barcode;


  Widget _buildBarcode(Barcode? value){ //build the page the user is shown


    if (value == null){ //if a QR has not yet been scanned, return a message asking user to scan a QR code
      return const Text(
        "Please scan a QR",
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white), //white to ensure visibility
      );
    }

    String? course;

    course = value.displayValue; //get the string associated with the QR code


    return Scaffold( //when the QR is scanned, show this
      body: Column(
        children: [
          if(_valid) //when the code is valid, show an alert dialogue that allows the user to say they are either interested or not
            AlertDialog(
              semanticLabel: course = value.displayValue,
                title: Text("QR code scanned!"),
                content: Text("It looks like you're in $course. Let us know if you're interested and would like to know more."),
                actions: [
                  TextButton(
                    onPressed: () {
                      incrementScan(course!); // increase counter in DB
                      Navigator.pop(context); // return to homepage
                    },
                    child: const Text("No, Thank You"),
                  ),
                  TextButton(
                      onPressed: () {
                        incrementInterested(course!); // increase counters in DB
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  CourseInfo(course: course))); //show information about selected course
                      },
                    child: const Text("Tell Me More!")
                  )
                ],
            )
          else
            AlertDialog( // show this if the QR is not found in DB
              title: Text("QR Code Scanned!"),
              content: Text("Unfortunately, this QR is invalid, please try again or tell a member of staff"), // error message
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context), // return to application's home screen
                  child: const Text("Back to home screen")
                )
              ],
            ),
        ],
      )
    );
  }

  void _handleBarcode(BarcodeCapture barcodes) async{



    if (mounted){ // gets information from scanned code
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
      });
      if (_barcode != null) { //does barcode validity check
        await checkValidity(_barcode!.displayValue!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    double currentHeight = MediaQuery.of(context).size.height; //get the current height of the window

    return Scaffold(
      appBar: AppBar(title: const Text("QR Scanner")),
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints.expand(height: currentHeight * 0.85), //ensure page can fit on device
            child: Stack(
              children: [
                MobileScanner(
                  onDetect: _handleBarcode, // when a QR is detected, pass off to handler
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: 300,
                    color: const Color.fromRGBO(0, 0, 0, 0.4),
                    child: Row( // this is where the alert dialogue will pop up.
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(child: Center(child: _buildBarcode(_barcode))),
                      ],
                    ),
                  ),
                )
              ],
            )
          ),
        ],
      )
    );
  }

}