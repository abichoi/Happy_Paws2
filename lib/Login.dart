import 'package:flutter/material.dart';
import 'Register.dart';
import 'Navigation.dart';
import 'Homepage.dart';
import 'authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Login"),
            elevation: 0,
            flexibleSpace: Container(
              decoration:  const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF4F60FF), Color(0xFF24DEEA)],
                ),
              ),
            )
        ),
    body:  Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Enter the Email',
                labelText: 'Email',
                labelStyle: TextStyle(fontSize: 18),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the Email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: 'Enter the password',
                labelText: 'Password',
                labelStyle: TextStyle(fontSize: 18),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
              ),
              obscureText: true,

              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the Password';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  AuthenticationHelper()
                      .signIn(email: _emailController.text, password: _passwordController.text)
                      .then((result) {
                    if (result == null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => BottomNavWidget()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          result,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ));
                    }
                  });
                }
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ),
                );
              },
              child: const Text("Don't have an account?"),
            ),
          ],
        )
    )
    );
  }
}