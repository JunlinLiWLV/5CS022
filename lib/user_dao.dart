import 'dart:convert';

import 'package:mysql1/mysql1.dart';
import 'package:http/http.dart' as http;

class User {
  final int? id;
  final String name;
  final String email;
  final String phone;
  final bool contact;

  User({this.id, required this.name, required this.email, required this.phone, required this.contact});

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'contact': contact ? 1 : 0, // Convert bool to int for PHP
    };
}
  
  // @override
  // String toString() {
  //   return 'User{id: $id, name: $name, email: $email, phone: $phone, contact: $contact}';
  // }
}

class UserDao {
  // final ConnectionSettings settings;
  //
  // UserDao(this.settings);

  // Add a user to the database
  Future<void> addUser(User user) async {

    final response = await http.post(
      Uri.parse("https://mi-linux.wlv.ac.uk/~2336879/5CS024/usermanagement.php"),
      headers: { 'Content-type': 'application/json' },
      body: json.encode(user.toJson())
    );

    if (response.statusCode == 200){
      final data = json.decode(response.body);
      if (data['error'] != null){
        print("There has been an error adding the user to database");
      }
    } else {
      print("There has been an error connecting to the server.");
    }

  }

}

//   // Get all users from the database
//   Future<List<User>> getAllUsers() async {
//     final conn = await MySqlConnection.connect(settings);
//     final results = await conn.query('SELECT id, name, email, phone, contact FROM Guests');
//     await conn.close();
//
//     return results.map((row) => User(
//       id: row['id'],
//       name: row['name'],
//       email: row['email'],
//       phone: row['phone'],
//       contact: row['contact']
//     )).toList();
//   }
//
//   // Get a user by ID
//   Future<User?> getUserById(int id) async {
//     final conn = await MySqlConnection.connect(settings);
//     final results = await conn.query('SELECT id, name, email, phone, contact FROM Guests WHERE id = ?', [id]);
//     await conn.close();
//
//     if (results.isNotEmpty) {
//       final row = results.first;
//       return User(
//         id: row['id'],
//         name: row['name'],
//         email: row['email'],
//         phone: row['phone'],
//         contact: row['contact']
//       );
//     }
//     return null;
//   }
//
//   // Remove a user by ID
//   Future<void> removeUserById(int id) async {
//     final conn = await MySqlConnection.connect(settings);
//     await conn.query('DELETE FROM Guests WHERE id = ?', [id]);
//     await conn.close();
//   }
// }
//
// // void main() async {
// //   // Connection settings for MySQL
// //   final settings = ConnectionSettings(
// //     host: 'localhost',
// //     port: 3306,
// //     user: '2350900',
// //     password: 'Lavinder2010',
// //     db: 'Guests',
// //   );
// //
// //   final userDao = UserDao(settings);
// //
// //   // Example usage
// //   //await userDao.addUser(User(id: 1, name: 'Alice', email: 'alice@gmail.com', phone: '07531658808', contact: false));
// //   //await userDao.addUser(User(id: 2, name: 'Bob', email: 'bob@gmail.com', phone: '07624228914', contact: true));
// //
// //   //final users = await userDao.getAllUsers();
// //   //print('All Users: $users');
// //
// //   //final user = await userDao.getUserById(1);
// //   //print('User with ID 1: $user');
// //
// //   //await userDao.removeUserById(1);
// //   //final updatedUsers = await userDao.getAllUsers();
// //   //print('All Users after removal: $updatedUsers');
// // }
