import 'package:flutter/material.dart';
import 'package:fsync/colors.dart';
import 'Login/Widgets/loginform.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: LoginFormContainer(onSignClick: (username, password) {
        print("$username $password");
      }),
      backgroundColor: FSyncColors.themeColor,
    ),
  ));
}
