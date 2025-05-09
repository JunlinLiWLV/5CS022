import 'dart:convert';
import 'package:http/http.dart' as http;

//Call server PHP to add a user to the DB
Future<void> addUser(User user) async {

  //encode any + symbols into a URL readable format
  final String encodedPhone = user.phone.replaceFirst("+", "%2B");

  //PHP URL
  final String addUserURL = 'https://mi-linux.wlv.ac.uk/~2336879/5CS024/add_user.php?name=${user.name}&email=${user.email}&phone=${encodedPhone}&contact=${user.contact}';

  try{
    final response = await http.get(Uri.parse(addUserURL));

    if(response.statusCode == 200){
      print("PHP response: ${response.body}");
    }

  } catch (e) {
    print("An error occurred when trying to add a new user: $e");
  }
}


class User { //create a user class

  final int? id;
  final String name;
  final String email;
  final String phone;
  final int contact;

  User({this.id, required this.name, required this.email, required this.phone, required this.contact});

}