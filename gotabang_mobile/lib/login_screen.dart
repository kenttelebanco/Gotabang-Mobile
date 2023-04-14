// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gotabang_mobile/main.dart';
import 'package:gotabang_mobile/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isRememberMe = false;
  bool isLoginActive = false;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();

    emailController.addListener(() {
      final isLoginActive =
          emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
      setState(() => this.isLoginActive = isLoginActive);
    });

    passwordController.addListener(() {
      final isLoginActive =
          passwordController.text.isNotEmpty && emailController.text.isNotEmpty;
      setState(() => this.isLoginActive = isLoginActive);
    });
  }

  Widget buildForgotPassBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => print("Forgot Password pressed"),
        child: const Text(
          'Forgot Password?',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildRememberCb() {
    return SizedBox(
      height: 20,
      child: Row(children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Checkbox(
            value: isRememberMe,
            checkColor: Colors.green,
            activeColor: Colors.white,
            onChanged: (bool? value) {
              setState(() {
                isRememberMe = value!;
              });
            },
          ),
        ),
        const Text('Remember',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        Container(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => print("Forgot Password pressed"),
            child: const Text(
              'Forgot Password?',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ]),
    );
  }

  Widget buildLoginBtn(bool activeLogin) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: activeLogin
            ? () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                );
                try {
                  setState(() => activeLogin = false);
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                } on FirebaseAuthException {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      actionsAlignment: MainAxisAlignment.center,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          Text(
                            "Invalid Credential! Email or Password Not Authenticated.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                navigatorKey.currentState!.popUntil((route) => route.isFirst);
              }
            : null,
        child: const Text(
          'LOGIN',
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildSignUpBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignUpScreen()));
      },
      child: RichText(
        text: const TextSpan(children: [
          TextSpan(
            text: 'Don\'t have a Account? Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(children: <Widget>[
            Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color.fromARGB(255, 69, 85, 100),
                      Color.fromARGB(255, 45, 56, 66),
                      Color.fromARGB(255, 22, 22, 22),
                      Color.fromARGB(255, 29, 30, 30),
                    ])),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 120,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Image(
                        image: AssetImage('assets/gotabang_logo.png'),
                        height: 250.0,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 8),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 60,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.cyan),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.cyan),
                                  ),
                                  contentPadding: EdgeInsets.only(top: 16),
                                  prefixIcon: Icon(Icons.email,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(color: Colors.white)),
                              controller: emailController,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 8),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 60,
                            child: TextFormField(
                              obscureText: true,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.cyan),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.cyan),
                                  ),
                                  contentPadding: EdgeInsets.only(top: 16),
                                  prefixIcon: Icon(Icons.lock,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.white)),
                              controller: passwordController,
                            ),
                          )
                        ],
                      ),
                      buildLoginBtn(isLoginActive),
                      buildSignUpBtn(),
                    ],
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}
