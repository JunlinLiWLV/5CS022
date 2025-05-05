import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mysql_client/mysql_client.dart';

// Future<List<String>?> searchQR() async{
//
//   List<String> courseCodes = [];
//
//   final conn = await MySQLConnection.createConnection( //define connection settings
//     host: "10.0.2.2",
//     port: 3306,
//     userName: "2336879",
//     password: "1234",
//     databaseName: "2336879",
//     secure: false,
//   );
//
//   await conn.connect(); //attempt server connection
//
//   var result = await conn.execute("SELECT `CourseCode` FROM `qrcodes`"); //execute this statement
//
//   List<String> courses = []; //define a list, ready for return
//
//   for (final row in result.rows){ //get all the course codes in the DB and add each to courses array
//     Map codes = row.assoc();
//     print(codes['CourseCode']);
//     courses.add(codes['CourseCode']);
//   }
//
//   conn.close(); //close DB connection
//
//   return courses; //return list of valid course codes.
//
//
//
//
//   //return null;
//
// }

Future<List<String>?> searchQR() async{
  final String getCourseCodes = 'https://mi-linux.wlv.ac.uk/~2336879/5CS024/qr_getcodes.php';

  List<dynamic> decodedList;

  List<String> courseCodes = [];

  try{
    final response = await http.get(Uri.parse(getCourseCodes));

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

Future<void> incrementScan(courseCode) async{
  final String scanIncrementUrl = 'https://mi-linux.wlv.ac.uk/~2336879/5CS024/qr_newscan.php?course_code="$courseCode"';

  try{
    final response = await http.get(Uri.parse(scanIncrementUrl));

    if(response.statusCode == 200){
      print("PHP response: $response.body");
    }

  } catch (e) {
    print("An error occurred when trying to increment the NumScan counter: $e");
  }
}

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