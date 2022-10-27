import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matchyourpet_mobile_app/components/forms/login_form.dart';

class LoginPage extends StatefulWidget {

  final Function() notifyParent;

  const LoginPage({Key? key, required this.notifyParent}) : super(key: key);

  @override
  LoginState createState() => LoginState();

}

class LoginState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return LoginForm(notifyParent: () { widget.notifyParent(); });
  }

}