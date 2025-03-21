import 'package:mysql_client/mysql_client.dart';

Future<List<String>?> searchQR() async{

  List<String> courseCodes = [];

  final conn = await MySQLConnection.createConnection( //define connection settings
    host: "10.0.2.2",
    port: 3306,
    userName: "2336879",
    password: "1234",
    databaseName: "2336879",
    secure: false,
  );
  
  await conn.connect(); //attempt server connection
  
  var result = await conn.execute("SELECT `CourseCode` FROM `qrcodes`"); //execute this statement

  List<String> courses = []; //define a list, ready for return

  for (final row in result.rows){ //get all the course codes in the DB and add each to courses array
    Map codes = row.assoc();
    print(codes['CourseCode']);
    courses.add(codes['CourseCode']);
  }

  conn.close(); //close DB connection

  return courses; //return list of valid course codes.




  //return null;
  
}

Future<void> scanIncrement(String course) async{

  final conn = await MySQLConnection.createConnection( //define connection settings
    host: "10.0.2.2",
    port: 3306,
    userName: "2336879",
    password: "1234",
    databaseName: "2336879",
    secure: false,
  );

  await conn.connect(); //attempt connection to server
  
  var result = await conn.execute("UPDATE qrcodes SET NumScan = NumScan + 1 WHERE CourseCode = \"$course\""); //execute SQL statement on server

  print(result.affectedRows); //print number of affected rows into console

  conn.close(); //close connection to free up bandwidth

}

Future<void> interestedIncrement(String course) async{

  final conn = await MySQLConnection.createConnection( //define connection settings
    host: "10.0.2.2",
    port: 3306,
    userName: "2336879",
    password: "1234",
    databaseName: "2336879",
    secure: false,
  );

  await conn.connect(); //attempt connection to server

  var result = await conn.execute("UPDATE qrcodes SET NumScan = NumScan + 1 WHERE CourseCode = \"$course\"");
  var result2 = await conn.execute("UPDATE qrcodes SET Interested = Interested + 1 WHERE CourseCode = \"$course\""); //execute SQL statements on server

  print(result.affectedRows + result2.affectedRows); //print number of affected rows into console

  conn.close(); //close connection to free up bandwidth


}
