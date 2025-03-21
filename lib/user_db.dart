import 'package:mysql_client/mysql_client.dart';

Future<void> addUser(User user) async {

  final conn = await MySQLConnection.createConnection( // create connection
      host: "10.0.2.2",
      port: 3306,
      userName: "2336879",
      password: "1234",
      databaseName: "2336879",
      secure: false,
  );

  await conn.connect(); // attempt connection

  var result = await conn.execute("INSERT INTO `users`(`Name`, `Email`, `Phone`, `Contact`) VALUES (:name, :email, :phone, :contact)", // execute query w/ below variables
      {
        "name" : user.name,
        "email" : user.email,
        "phone" : user.phone,
        "contact" : user.contact
      }
  );

  print(result.affectedRows); // print number of rows affected to console for debug

  conn.close(); // close connection
}

class User { //create a user class

  final int? id;
  final String name;
  final String email;
  final String phone;
  final int contact;

  User({this.id, required this.name, required this.email, required this.phone, required this.contact});

}