import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_page/main.dart';

class HomeS extends StatefulWidget {
  const HomeS({super.key});

  @override
  State<HomeS> createState() => _HomeSState();
}

class _HomeSState extends State<HomeS> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;
  userlogin() async {
    try {
      var url = Uri.parse('http://adeegmarket.zamindarestate.com/api/v1/login');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        print("User Login Successfully");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: ((context) => const LoginPage())),
            (route) => false);
      }
    } catch (e) {
      print("Catch e: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -200,
            left: -50,
            right: -50,
            child: Container(
              height: 400,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(300),
                color: Colors.red,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 200,
            bottom: 0,
            child: Container(
              height: 600,
              width: MediaQuery.of(context).size.width * 1,
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(.5),
              child: Column(
                children: [
                  const Text(
                    "Welcome!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const Text("Sigin to continue "),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 241, 238, 238),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 248, 31, 31),
                        ),
                      ),
                      hintText: 'Email Address',
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 241, 238, 238),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 248, 31, 31),
                        ),
                      ),
                      hintText: 'Password',
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        userlogin();
                      },
                      child: const Text("login"))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
