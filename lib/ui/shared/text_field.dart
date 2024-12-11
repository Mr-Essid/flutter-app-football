import 'package:flutter/material.dart';
import 'package:project_flutter_football/utils/helperFunctions.dart';

Widget passwordTextField(
  TextEditingController textController,
) {
  bool isPasswordShown = false;

  return TextFormField(
    controller: textController,
    decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: const Text("password"),
        prefixIcon: const Icon(Icons.lock),
        suffix: IconButton(
            onPressed: () {
              isPasswordShown = !isPasswordShown;
            },
            icon: Icon(
                (isPasswordShown) ? Icons.visibility_off : Icons.visibility))),
  );
}

class AppTextFieldPassword extends StatefulWidget {
  TextEditingController textEditingController;
  bool isPasswordShown = false;
  AppTextFieldPassword({Key? key, required this.textEditingController})
      : super(key: key);

  @override
  _TextFieldState createState() => _TextFieldState();
}

class _TextFieldState extends State<AppTextFieldPassword> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: passwordValidator,
      obscureText: !widget.isPasswordShown,
      controller: widget.textEditingController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(28),
          border: const OutlineInputBorder(),
          label: const Text("password"),
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  widget.isPasswordShown = !widget.isPasswordShown;
                });
              },
              icon: Icon((widget.isPasswordShown)
                  ? Icons.visibility_off
                  : Icons.visibility))),
    );
  }
}

class AppTextField extends StatefulWidget {
  TextEditingController controller;
  String? label;
  String? hint;
  Icon? icon;
  String? Function(String?)? validator;

  AppTextField(
      {super.key, required this.controller, this.label, this.hint, this.icon, this.validator});

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          contentPadding: const EdgeInsets.all(28),
          border: const OutlineInputBorder(),
          prefixIcon: widget.icon,
        ));
  }
}
