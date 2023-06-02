import 'package:flutter/material.dart';
import 'package:soham_academy/screens/display_schools.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  var _formKey = GlobalKey<FormState>();
  var _minPadding = 5.0;
  var text = '';
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(_minPadding * 2),
        child: Container(
          alignment: AlignmentDirectional.center,
          child: Form(
            key: _formKey,
            child: SafeArea(
              child: ListView(children: [
                SizedBox(
                  height: 250,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(_minPadding),
                  child: TextFormField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      labelText: "Username",
                      hintText: "Enter user name",
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (userName) {
                      if (userName!.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(_minPadding),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      labelText: "password",
                      hintText: "Enter password",
                      prefixIcon: Icon(Icons.password),
                    ),
                    validator: (userName) {
                      if (userName!.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(_minPadding * 25, _minPadding,
                      _minPadding * 25, _minPadding),
                  child: ElevatedButton(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      _formKey.currentState!.validate();
                      if (_userNameController.text == "Admin" &&
                          _passwordController.text == "Admin") {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return SchoolParticipantsPage();
                        }));
                      } else {
                        _userNameController.clear();
                        _passwordController.clear();
                        setState(() {
                          text = "Invalid Credentials";
                        });
                      }
                    }, //color: Color(0xff00c853),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
