import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gotabang_mobile/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignUpScreen> {
  bool isLoginActive = false;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController emailController;
  late TextEditingController phoneNumController;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneNumController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    phoneNumController = TextEditingController();

    emailController.addListener(() {
      final isLoginActive = emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          nameController.text.isNotEmpty &&
          phoneNumController.text.isNotEmpty;
      setState(() => this.isLoginActive = isLoginActive);
    });

    nameController.addListener(() {
      final isLoginActive = emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          nameController.text.isNotEmpty &&
          phoneNumController.text.isNotEmpty;
      setState(() => this.isLoginActive = isLoginActive);
    });

    passwordController.addListener(() {
      final isLoginActive = emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          nameController.text.isNotEmpty &&
          phoneNumController.text.isNotEmpty;
      setState(() => this.isLoginActive = isLoginActive);
    });

    phoneNumController.addListener(() {
      final isLoginActive = emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          nameController.text.isNotEmpty &&
          phoneNumController.text.isNotEmpty;
      setState(() => this.isLoginActive = isLoginActive);
    });
  }

  Widget registerName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 5),
        Container(
          alignment: Alignment.centerLeft,
          child: TextField(
            keyboardType: TextInputType.name,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                contentPadding: EdgeInsets.only(top: 16),
                hintText: 'Full Name',
                hintStyle: TextStyle(color: Colors.white)),
            controller: nameController,
          ),
        )
      ],
    );
  }

  Widget registerEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 5),
        Container(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                contentPadding: EdgeInsets.only(top: 16),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.white)),
            controller: emailController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (email) =>
                email != null && !EmailValidator.validate(email)
                    ? 'Enter Valid Email'
                    : null,
          ),
        )
      ],
    );
  }

  Widget buildPassword() {
    return Column(
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
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                contentPadding: EdgeInsets.only(top: 16),
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.white)),
            controller: passwordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => value != null && value.length < 6
                ? 'Enter Mininum 6 Characters'
                : null,
          ),
        )
      ],
    );
  }

  Widget buildPhoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 8),
        Container(
          alignment: Alignment.centerLeft,
          height: 60,
          child: TextField(
            keyboardType: TextInputType.phone,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                contentPadding: EdgeInsets.only(top: 16),
                hintText: 'Phone Number',
                hintStyle: TextStyle(color: Colors.white)),
            controller: phoneNumController,
          ),
        )
      ],
    );
  }

  Widget buildRegisterBtn(bool activeLogin) {
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
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                } on FirebaseAuthException catch (e) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      actionsAlignment: MainAxisAlignment.center,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          Text(
                            "Invalid Credential!",
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              }
            : null,
        child: const Text(
          'REGISTER',
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 69, 85, 100),
            Color.fromARGB(255, 45, 56, 66),
            Color.fromARGB(255, 22, 22, 22),
            Color.fromARGB(255, 29, 30, 30),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    registerName(),
                    registerEmail(),
                    buildPhoneNumber(),
                    buildPassword(),
                    buildRegisterBtn(isLoginActive),
                  ],
                )),
          )),
    );
  }
}
