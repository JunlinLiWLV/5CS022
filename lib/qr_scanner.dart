import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:open_companion/course_info.dart';
import 'package:open_companion/main.dart';
import 'package:open_companion/qr_db.dart';


class QRScanner extends StatefulWidget{
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();

}


class _QRScannerState extends State<QRScanner> {

  bool _valid = false;

  Future<List<String>?> checkValidity(String course) async{

    Future<List<String>?> _futureCodes = searchQR();
    List<String>? validCodes = await _futureCodes;
    print(validCodes);

    if(validCodes!.contains(course)){
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


  Widget _buildBarcode(Barcode? value){


    if (value == null){
      return const Text(
        "Please scan a QR",
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white),
      );
    }

    String? course;

    course = value.displayValue;


    return Scaffold(
      body: Column(
        children: [
          if(_valid)
            AlertDialog(
              semanticLabel: course = value.displayValue,
                title: Text("QR code scanned!"),
                content: Text("It looks like you're in $course. Let us know if you're interested here!"),
                actions: [
                  TextButton(
                    onPressed: () {
                      scanIncrement(course!);
                      Navigator.pop(context);
                    },
                    child: const Text("Not interested"),
                  ),
                  TextButton(
                      onPressed: () {
                        interestedIncrement(course!);
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  CourseInfo(course: course)));
                      },
                    child: const Text("Tell me more!")
                  )
                ],
            )
          else
            AlertDialog(
              title: Text("QR Code Scanned!"),
              content: Text("Unfortunately, this QR is invalid, please try again or tell a member of staff"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Back to home screen")
                )
              ],
            ),
        ],
      )
    );



    // return AlertDialog(
    //   semanticLabel: course = value.displayValue,
    //   title: Text("QR code scanned!"),
    //   content: Text("It looks like you're in $course. Let us know if you're interested here!"),
    //   actions: [
    //     TextButton(
    //       onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  OpenDayCompanionApp(title: "WLV Open Day"))),
    //       child: const Text("Not interested"),
    //     ),
    //     TextButton(
    //       onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  CourseInfo(course: course))),
    //       child: const Text("Tell me more!")
    //     )
    //   ],
    // );



  }

  void _handleBarcode(BarcodeCapture barcodes) async{



    if (mounted){
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
      });
      if (_barcode != null) {
        await checkValidity(_barcode!.displayValue!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    double currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text("QR Scanner")),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints.expand(height: currentHeight - 56),
            child: Stack(
              children: [
                MobileScanner(
                  onDetect: _handleBarcode,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: 300,
                    color: const Color.fromRGBO(0, 0, 0, 0.4),
                    child: Row(
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