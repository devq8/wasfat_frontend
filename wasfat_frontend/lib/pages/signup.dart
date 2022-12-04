import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wasfat_frontend/providers/auth_provider.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(
                  flex: 5,
                ),
                Text(
                  'Sing Up',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Please fill your information below to register',
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
                  obscureText: true,
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
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text('Confirm Password'),
                    hintText: 'Enter your password again',
                  ),
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required field!';
                    }
                    if (value != passwordController.text) {
                      return 'Password is not matching!';
                    }
                    return null;
                  },
                ),
                Spacer(
                  flex: 3,
                ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFf14b24),
                      minimumSize: Size.fromHeight(45),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        var didSignup =
                            await context.read<AuthProvider>().signup(
                                  username: usernameController.text,
                                  password: passwordController.text,
                                );
                        if (didSignup) {
                          context.go('/recipes');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Sign up is not successful!')));
                        }
                      } else {
                        print('The form is not valid');
                      }
                    },
                    child: Text('Sign Up'),
                  ),
                ),
                // Button(buttonText: 'Sign Up', outlinedButton: false),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? '),
                    InkWell(
                      onTap: () {
                        context.replace('/signin');
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          color: Color(0xFFf14b24),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(
                  flex: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
