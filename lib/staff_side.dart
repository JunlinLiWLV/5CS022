import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StaffScreen extends StatefulWidget{
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen>{

  late final WebViewController _controller;

  @override
  void initState(){
    //create a web controller, with javascript, then load the staff landing page
    _controller = WebViewController();
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.loadFlutterAsset('lib/assets/html/staff.html');
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () async {
            //if the webview controller has any history go back to previous page. if not, go back to the home screen.
            if (await _controller.canGoBack()) {
              await _controller.goBack();
            } else {
              Navigator.pop(context);
            }
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: Text("Open Day Management", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, fontFamily: 'RobotoSlab'),),
      ),
      //display web controller under the app bar
      body: WebViewWidget(controller: _controller,)
    );
  }

}