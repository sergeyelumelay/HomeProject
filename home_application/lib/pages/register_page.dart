import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_application/components/login_button.dart';
import 'package:home_application/components/login_create_account.dart';
import 'package:home_application/components/login_textfield.dart';

class RegisterPage  extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage ({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordCotroller = TextEditingController();

  // sign up user controller
  void signUpUser() async {
  // loading circle
  showDialog(
    context: context, 
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
        );
      },
    );

    // firebase creating new account
    try {
      // check if the password is the same
      if (passwordController.text == confirmPasswordCotroller.text){
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
        );
      } else {
        // show error message if the password don't match
        showErrorMessage("Password don't match");
      }
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
                  hintText: 'Email',
                  obscureText: false,
                ),
          
                const SizedBox(height: 10),
          
                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // repeat password textfield
                MyTextField(
                  controller: confirmPasswordCotroller,
                  hintText: 'Repeat Password',
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
          
                // sign up button
                LoginButton(
                  text: "Sign Up",
                  onTap: signUpUser,
                ),
          
                const SizedBox(height: 150),
                // registered account
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

          // already a member?

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?',
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: widget.onTap,
                child: const Text(
                  'Login Now',
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