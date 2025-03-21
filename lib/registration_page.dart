import 'package:flutter/material.dart';
import 'package:open_companion/user_db.dart';
import 'main.dart';


class registrationForm extends State<theRegistrationPage>{

  final _formKey = GlobalKey<FormState>();

  late String name;
  late String email;
  late String telNumber;
  late bool allowContact = false;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        fontFamily: 'Roboto'
      ),
      title: "Registration",
      home: Scaffold(
        appBar: AppBar(
          leading: InkWell(
          onTap: (){ Navigator.pop(context); },
          child: Icon(Icons.arrow_back),
          ),
          title: Text("Open Day Register"),
        ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(15.0), //keep text fields away from the sides of the screen
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField( // create a text form for users to enter their name into
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: "Please enter your name here.",
                      labelText: 'Name'
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty){
                      return "Please enter your name here";
                    }
                    name = value;
                    // print(value); DEBUG
                    return null;
                  },
                ),
                TextFormField( // create a text form for the users to enter an email address
                  decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: "Please enter your email here",
                      labelText: 'Email'
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty){
                      return "Please enter your email here";
                    } else if (value.contains('@') && value.contains('.')){ //make sure the email has the necessary features of an email before continuing
                      email = value.toLowerCase(); // ensure all emails are lower case
                      // print(value); DEBUG
                      return null;
                    } else {
                      return "This is not a valid email address, please try again";
                    }
  
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      icon: Icon(Icons.phone),
                      hintText: "For international numbers, please include country code",
                      labelText: 'Telephone Number'
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty){
                      return "Please enter your number here";
                    } else if (RegExp(r".*[a-z].*").hasMatch(value) || RegExp(r".*[A-Z].*").hasMatch(value)) { //check phone number for letters and disallow input if it does
                      return "This is not a valid number, please try again";
                    } else if (value.contains(' ') || value.contains('-')){ //ensure user has not put any spaces or dashes into the phone number, return error if they have
                      return "Please remove all spaces or dashes from your number";
                    } else {
                      telNumber = value; //store number in variable
                      // print(value); DEBUG
                      return null;
                    }
                  },
                ),
                SizedBox( height: 10, ),
                CheckboxListTile(
                  title: Text("Please check this box if you're happy for us to contact you"), //add a boolean value for if they are ok being contacted after filling in form
                  value: allowContact,
                  onChanged: (newValue){
                    setState(() {
                      allowContact = newValue!;
                    });
                  },
                ),
                ElevatedButton(onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // print(name + email + telNumber); //DEBUG
                    // print(allowContact); //DEBUG
                    int contact = allowContact ? 1 : 0; // change the allowContact boolean into an int, ready to be stored in the DB
                    try{ //surround in try catch
                      User user = User(id: null, name: name, email: email, phone: telNumber, contact: contact); // create User object with information given
                      addUser(user);
                    } catch (e) {
                      print(e);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Thank you! Welcome to UoW')) //Success, show thank you message as popup at bottom of app
                    );
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OpenDayCompanionApp(title: 'WLV Open Day Companion App'))); //return to home page.
                  }
                },
                    child: const Text('Submit'))
              ],
            ),
          ),
          ),
        ),
      )
    );
  }
}


