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
      body: WebViewWidget(controller: _controller,)
    );
  }

}