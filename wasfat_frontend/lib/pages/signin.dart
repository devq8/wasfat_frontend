import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignIn'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Text('Sing In'),
            Text('Please sign in to continue.'),
            TextFormField(
              decoration: InputDecoration(
                label: Text('Username'),
                hintText: 'Enter your username',
              ),
              controller: usernameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required field!';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                label: Text('Password'),
                hintText: 'Enter your password',
              ),
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required field!';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
