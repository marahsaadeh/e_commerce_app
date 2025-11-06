import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/pages/sign_in.dart';
import 'package:e_commerce_app/shared/colors.dart';
import 'package:e_commerce_app/shared/contants.dart';
import 'package:e_commerce_app/shared/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isVisable = true;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final titleController = TextEditingController();

  bool isPassword8Char = false;
  bool isPasswordHas1Number = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;

  onPasswordChanged(String password) {
    isPassword8Char = false;
    isPasswordHas1Number = false;
    hasUppercase = false;
    hasLowercase = false;
    hasSpecialCharacters = false;
    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        isPassword8Char = true;
      }

      if (password.contains(RegExp(r'[0-9]'))) {
        isPasswordHas1Number = true;
      }

      if (password.contains(RegExp(r'[A-Z]'))) {
        hasUppercase = true;
      }

      if (password.contains(RegExp(r'[a-z]'))) {
        hasLowercase = true;
      }

      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        hasSpecialCharacters = true;
      }
    });
  }

  register() async {
    setState(() {
      isLoading = true;
    });

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

      print(credential.user!.uid);

      CollectionReference users = FirebaseFirestore.instance.collection(
        'userSSS',
      );

      users.doc(credential.user!.uid).set({
        'username': usernameController.text,
        'age': ageController.text,
        "title": titleController.text,
        "email": emailController.text,
        "pass": passwordController.text,
      });

      print("User Added");

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', emailController.text);
      await prefs.setString('username', usernameController.text);
      await prefs.setBool('remember_me', true);

      print(" SharedPreferences saved:");
      print("email: ${prefs.getString('email')}");
      print("username: ${prefs.getString('username')}");
      print("remember_me: ${prefs.getBool('remember_me')}");

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home(rememberMe: true)),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "The account already exists for that email.");
      } else {
        showSnackBar(context, "ERROR - Please try again late");
      }
    } catch (err) {
      showSnackBar(context, err.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    usernameController.dispose();
    ageController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        elevation: 0,
        backgroundColor: appbarGreen,
      ),
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(33.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextField(
                    controller: usernameController,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    decoration: decorationTextfield.copyWith(
                      hintText: "Enter Your username : ",
                      suffixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 22),
                  TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    decoration: decorationTextfield.copyWith(
                      hintText: "Enter Your age : ",
                      suffixIcon: Icon(Icons.pest_control_rodent),
                    ),
                  ),
                  const SizedBox(height: 22),
                  TextFormField(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    decoration: decorationTextfield.copyWith(
                      hintText: "Enter Your title : ",
                      suffixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: 22),
                  TextFormField(
                    validator: (email) {
                      return email!.contains(
                            RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ),
                          )
                          ? null
                          : "Enter a valid email";
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    decoration: decorationTextfield.copyWith(
                      hintText: "Enter Your Email : ",
                      suffixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 22),
                  TextFormField(
                    onChanged: (password) {
                      onPasswordChanged(password);
                    },
                    validator: (value) {
                      return value!.length < 8
                          ? "Enter at least 8 characters"
                          : null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: isVisable ? true : false,
                    decoration: decorationTextfield.copyWith(
                      hintText: "Enter Your Password : ",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisable = !isVisable;
                          });
                        },
                        icon: isVisable
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Container(
                        child: Icon(Icons.check, color: Colors.white, size: 15),
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isPassword8Char ? Colors.green : Colors.white,
                          border: Border.all(
                            color: Color.fromARGB(255, 189, 189, 189),
                          ),
                        ),
                      ),
                      SizedBox(width: 11),
                      Text("At least 8 characters"),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Container(
                        child: Icon(Icons.check, color: Colors.white, size: 15),
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isPasswordHas1Number
                              ? Colors.green
                              : Colors.white,
                          border: Border.all(
                            color: Color.fromARGB(255, 189, 189, 189),
                          ),
                        ),
                      ),
                      SizedBox(width: 11),
                      Text("At least 1 number"),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Container(
                        child: Icon(Icons.check, color: Colors.white, size: 15),
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: hasUppercase ? Colors.green : Colors.white,
                          border: Border.all(
                            color: Color.fromARGB(255, 189, 189, 189),
                          ),
                        ),
                      ),
                      SizedBox(width: 11),
                      Text("Has Uppercase"),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Container(
                        child: Icon(Icons.check, color: Colors.white, size: 15),
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: hasLowercase ? Colors.green : Colors.white,
                          border: Border.all(
                            color: Color.fromARGB(255, 189, 189, 189),
                          ),
                        ),
                      ),
                      SizedBox(width: 11),
                      Text("Has  Lowercase "),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Container(
                        child: Icon(Icons.check, color: Colors.white, size: 15),
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: hasSpecialCharacters
                              ? Colors.green
                              : Colors.white,
                          border: Border.all(
                            color: Color.fromARGB(255, 189, 189, 189),
                          ),
                        ),
                      ),
                      SizedBox(width: 11),
                      Text("Has  Special Characters "),
                    ],
                  ),
                  const SizedBox(height: 33),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await register();
                        if (!mounted) return;
                      } else {
                        showSnackBar(context, "ERROR");
                      }
                    },
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text("Register", style: TextStyle(fontSize: 19)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(bTNpink),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 33),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do not have an account?",
                        style: TextStyle(fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text(
                          'sign in',
                          style: TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
