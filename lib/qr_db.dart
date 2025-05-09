import 'dart:convert';
import 'package:http/http.dart' as http;


//run the PHP from the server for getting the allowed QRs
Future<List<String>?> searchQR() async{
  final String getCourseCodes = 'https://mi-linux.wlv.ac.uk/~2336879/5CS024/qr_getcodes.php';

  List<dynamic> decodedList;

  List<String> courseCodes = [];

  try{
    final response = await http.get(Uri.parse(getCourseCodes));
    //if a valid response has been received, decode the JSON
    if (response.statusCode == 200){
      decodedList = jsonDecode(response.body);
      courseCodes = decodedList.map((item) => item['CourseCode'] as String).toList();
      print(courseCodes);
    }
  } catch (e) {
    print("An error occurred fetching the QR code data: $e");
  }

  return courseCodes;

}

//run the PHP from the server to increment the number of scans in the DB
Future<void> incrementScan(courseCode) async{
  final String scanIncrementUrl = 'https://mi-linux.wlv.ac.uk/~2336879/5CS024/qr_newscan.php?course_code="$courseCode"';

  //error catching
  try{
    final response = await http.get(Uri.parse(scanIncrementUrl));

    if(response.statusCode == 200){
      print("PHP response: $response.body");
    }

  } catch (e) {
    print("An error occurred when trying to increment the NumScan counter: $e");
  }
}

//run the PHP on server to increment the number of interested people in the relevant course
Future<void> incrementInterested(courseCode) async{
  final String interestIncrementUrl = 'https://mi-linux.wlv.ac.uk/~2336879/5CS024/qr_interested.php?course_code="$courseCode"';

  try{
    final response = await http.get(Uri.parse(interestIncrementUrl));

    if(response.statusCode == 200){
      print("PHP response: $response.body");
    }

  } catch (e) {
    print("An error occurred when trying to increment the 'interested' counter: $e");
  }
}