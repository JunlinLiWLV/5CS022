import 'package:mysql_client/mysql_client.dart';

Future<List<String>?> searchQR() async{

  List<String> courseCodes = [];

  final conn = await MySQLConnection.createConnection(
    host: "10.0.2.2",
    port: 3306,
    userName: "2336879",
    password: "1234",
    databaseName: "2336879",
    secure: false,
  );
  
  await conn.connect();
  
  var result = await conn.execute("SELECT `CourseCode` FROM `qrcodes`");

  List<String> courses = [];

  for (final row in result.rows){
    Map codes = row.assoc();
    print(codes['CourseCode']);
    courses.add(codes['CourseCode']);
  }

  return courses;


  conn.close();

  return null;
  
}

Future<void> scanIncrement(String course) async{




}

Future<void> interestedIncrement(String course) async{




}
