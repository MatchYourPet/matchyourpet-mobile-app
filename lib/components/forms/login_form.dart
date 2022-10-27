import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:matchyourpet_mobile_app/api/apiCalls/user_controller.dart';
import 'package:matchyourpet_mobile_app/constants/storage_access_keys.dart';
import 'package:matchyourpet_mobile_app/pages/home.dart';
import 'package:matchyourpet_mobile_app/services/storage_service.dart';

class LoginForm extends StatefulWidget {

  final Function() notifyParent;

  const LoginForm({Key? key, required this.notifyParent}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  StorageService storageService = StorageService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UserController userEndpoints = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/logo_quer.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-Mail',
                    hintText: 'jemand@matchyourpet.at'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Passwort',
                    hintText: 'Passwort eingeben'),
              ),
            ),
            /*TextButton(
              onPressed: (){
                //TODO Passwort vergessen implementieren
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),*/
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () => {loginAction(context)},
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            TextButton(
              onPressed: () { print('asdf'); },
              child: const Text(
                'Kein Konto? Jetzt registrieren!',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loginAction(BuildContext context) {
    userEndpoints.loginUser(emailController.text, passwordController.text).then((value) => {
      storageService.saveToStorage(StorageAccessKeys.jwt, value.token),
      storageService.saveToStorage(StorageAccessKeys.email, value.email),
      storageService.saveToStorage(StorageAccessKeys.adopterId, value.adopterId.toString()),
    });
    widget.notifyParent();
  }

}