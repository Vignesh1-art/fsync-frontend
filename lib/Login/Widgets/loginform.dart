import 'package:flutter/material.dart';
import 'package:fsync/colors.dart';

class LoginFormContainer extends StatelessWidget {
  final Function(String, String) onSignClick;

  LoginFormContainer({required this.onSignClick});

  @override
  Widget build(BuildContext context) {
    return InheritedContainer(onSignClick, child: const LoginForm());
  }
}

class InheritedContainer extends InheritedWidget {
  final Function(String, String) onSignClick;
  const InheritedContainer(this.onSignClick, {super.key, required super.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static Function(String, String)? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedContainer>()
        ?.onSignClick;
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Material(
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(60))),
        elevation: 10,
        child: FormContainer(),
      ),
    );
  }
}

class FormContainer extends StatelessWidget {
  const FormContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: 400,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      alignment: Alignment.center,
      child: Form(),
    );
  }
}

class Form extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  Form({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Text(
            "Welcome to FSync!",
            style: TextStyle(color: FSyncColors.themeColor, fontSize: 25),
          ),
        ),
        const Image(
          image: AssetImage("assets/fsync_icon.png"),
          width: 70,
          height: 70,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: usernameController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: "Username"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: passwordController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: "Password"),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
          ),
        ),
        LoginButton(onPressed: () {
          final onSignInClick = InheritedContainer.of(context);
          if(onSignInClick != null) {
            onSignInClick(usernameController.text, passwordController.text);
          }
        })
      ],
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.onPressed});
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.white;
          }
          return FSyncColors.themeColor;
        }), foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed)) {
            return FSyncColors.themeColor;
          }
          return Colors.white;
        })),
        onPressed: onPressed,
        child: const Text("Login"));
  }
}
