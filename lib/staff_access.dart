import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class staffAccessScreen extends StatefulWidget {
  final Widget staffPage;

  const staffAccessScreen({super.key, required this.staffPage});

  @override
  State<staffAccessScreen> createState() => _staffAccessScreen();
}

class _staffAccessScreen extends State<staffAccessScreen> {
  TextEditingController pinController = new TextEditingController();
  //hard coded pin.
  static const correctPin = '985641';
  String errorMessage = "";
  int attempts = 0;
  bool _isPINActive = true;

  void _verifyPIN() {
    if (pinController.text == correctPin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => widget.staffPage));
    } else {
      //if the pin received is incorrect, reset text field and display error
      setState(() {
        errorMessage = 'Incorrect PIN. Please try again.';
        pinController.clear();
        attempts++;
        //if too many attempts are made, disable the text field.
        if (attempts >= 3){
          _isPINActive = false;
          errorMessage = 'Too many incorrect attempts. Please try again later';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Access Staff Functions")),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: TextField(
                  controller: pinController,
                  keyboardType: TextInputType.number,
                  obscureText: true, //Makes sure pin is not visible on screen
                  maxLength: correctPin.length,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'RobotoSlab',
                      fontWeight: FontWeight.w600,
                      fontSize: 24),
                  decoration: InputDecoration(
                    labelText: "Staff PIN",
                    border: const OutlineInputBorder(),
                    // errorText: errorMessage.isNotEmpty ? errorMessage : null,
                  ),
                  onChanged: (value) {
                    if (value.length == correctPin.length) {
                      _verifyPIN();
                    }
                  },
                  enabled: _isPINActive,
                ),
              ),
              const SizedBox(height: 20),
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: TextStyle(
                      fontFamily: 'RobotoSlab',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.red),
                )
            ],
          ),
        ),
      ),
    );
  }
}
