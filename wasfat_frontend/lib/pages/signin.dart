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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sing In',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Please sign in to continue.',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 30,
                ),
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
                Spacer(),
                ElevatedButton(onPressed: (() {}), child: Text('Sing In'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
