import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, required this.toggleView});

  final Function toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
              'Sign in to Brew Crew',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton.icon(
                icon: Icon(Icons.person),
                onPressed: () {
                  widget.toggleView();
                },
                label: Text('Register'),
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
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Password',
                    ),
                    validator:
                        (val) =>
                            (val == null || val.length < 6)
                                ? 'Please enter 6+ characters'
                                : null,
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
                        dynamic result = await _auth.signInWithEmailAndPassword(
                          email,
                          password,
                        );

                        if (result == null) {
                          setState(() {
                            error = 'Could not sign in with those credentials';
                            loading = false;
                          });
                        }
                      }
                    },
                    child: Text(
                      'Sign in',
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
