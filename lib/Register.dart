import 'package:flutter/material.dart';
import 'Login.dart';
import 'authentication.dart';



class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Create Account"),
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
        body: Form(
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
                      .signUp(email: _emailController.text, password: _passwordController.text)
                      .then((result) {
                    if (result == null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
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
              child: const Text('Create Account'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: const Text("Got an account?"),
            ),
          ],
        )
    )
    );
  }
}
