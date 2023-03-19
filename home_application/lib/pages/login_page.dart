import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_application/components/login_button.dart';
import 'package:home_application/components/login_create_account.dart';
import 'package:home_application/components/login_textfield.dart';

class LoginPage  extends StatefulWidget {
  final Function()? onTap;
  const LoginPage ({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // sign in user controller
  void signInUser() async {
  // loading circle
  showDialog(
    context: context, 
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
        );
      },
    );

    // firebase sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
      );
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // show error message
      showErrorMessage(e.code);
    }
  }

  // error handlers
  void showErrorMessage (String message) {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              message,
            ),
          )
        );
      },
    );
  }


  void createUser() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 25),
                // home logo
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  margin: const EdgeInsets.symmetric(horizontal: 100),
                  decoration: const BoxDecoration(color:Color.fromARGB(255, 255, 243, 134),
                  ),
                ),
                const SizedBox(height: 40),
          
                // username/email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Username/Email',
                  obscureText: false,
                ),
          
                const SizedBox(height: 10),
          
                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
          
                const SizedBox(height: 15),
          
                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 25),
          
                // sign in button
                LoginButton(
                  text: "Login",
                  onTap: signInUser,
                ),
          
                const SizedBox(height: 200),
                // not a member? register now
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(children: [
                    Expanded(child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  ),
                ),
                
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('Or',
                      style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                
                    Expanded(child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  ),
                ), 
              ],
            ),
          ),

                    const SizedBox(height: 25),
                    // create user account

                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Register now',
                            style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                        )
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}