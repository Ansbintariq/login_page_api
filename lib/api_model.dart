// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_page/home.dart';

// sign up page not login
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conpasswordController = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController rolecontroller = TextEditingController();

  bool loading = false;

  login({name, email, phone, password, passwordConfirmation, role}) async {
    try {
      setState(() {
        loading = true;
      });
      var url = Uri.parse('http://adeegmarket.zamindarestate.com/api/v1/reg');
      final responce = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'phone': phone,
          'role': role,
        }),
      );

      print(responce.statusCode);
      print(responce.body);
      if (responce.statusCode == 200) {
        print("User registration Successfully");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: ((context) => const HomeS())),
            (route) => false);
      }

      setState(() {
        loading = false;
      });
    } catch (e) {
      print("Catch e: $e");
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Column(
        children: [
          const Text("Name"),
          TextField(
            controller: namecontroller,
          ),
          const Text("Email"),
          TextField(
            controller: emailController,
          ),
          const Text("phone"),
          TextField(
            controller: phonecontroller,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text("Password"),
          TextField(
            controller: passwordController,
          ),
          const Text("confirm password"),
          TextField(
            controller: conpasswordController,
          ),
          const Text("role"),
          TextField(
            controller: rolecontroller,
          ),
          const SizedBox(
            height: 50,
          ),
          loading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    login();
                    // uper isko {} me b lekhe gy
                    // login(
                    //   name: namecontroller.text,
                    //   password: passwordController.text.trim(),
                    //   phone: phonecontroller.text,
                    //   email: emailController.text.trim(),
                    //   passwordConfirmation: conpasswordController.text.trim(),
                    //   role: rolecontroller.text,
                    // );
                  },
                  child: const Text("reg")),
        ],
      ),
    );
  }
}
