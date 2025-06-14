import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key, required this.toggleView});

  final Function toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
          backgroundColor: Colors.brown[100],
          appBar: AppBar(
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            title: Text(
              'Sign up to Brew Crew',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton.icon(
                icon: Icon(Icons.person),
                onPressed: () {
                  widget.toggleView();
                },
                label: Text('Sign in'),
              ),
            ],
          ),
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator:
                        (val) =>
                            (val == null || val.isEmpty)
                                ? 'Please enter an email'
                                : null,
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Password',
                    ),
                    validator:
                        (val) =>
                            (val == null || val.length < 6)
                                ? 'Please enter a password 6+ longer'
                                : null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() == true) {
                        setState(() => loading = true);
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error = 'Please supply a valid email';
                            loading = false;
                          });
                        }
                      }
                    },

                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.pink),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
