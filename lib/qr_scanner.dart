import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:open_companion/main.dart';


class QRScanner extends StatefulWidget{
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();

}


class _QRScannerState extends State<QRScanner> {

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

    return AlertDialog(
      semanticLabel: course = value.displayValue,
      title: Text("QR code scanned!"),
      content: Text("It looks like you're in $course. Let us know if you're interested here!"),
      actions: [
        TextButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  OpenDayCompanionApp(title: "WLV Open Day"))),
          child: const Text("Not interested"),
        ),
        TextButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  OpenDayCompanionApp(title: "WLV Open Day"))),
          child: const Text("Tell me more!")
        )
      ],
    );


  }

  void _handleBarcode(BarcodeCapture barcodes){

    if (mounted){
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
      });
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