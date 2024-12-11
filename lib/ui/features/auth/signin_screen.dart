import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_flutter_football/ui/shared/app_buttons.dart';
import 'package:project_flutter_football/ui/shared/text_field.dart';
import 'package:project_flutter_football/ui/view_model/shared_view_model/auth_view_model/signin_vm.dart';
import 'package:project_flutter_football/utils/ui_state.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>(); // To validate the form

  @override
  Widget build(BuildContext context) {
    var isLoadingState = context.watch<SignInVM>().isLoading;
    var padding = MediaQuery.of(context).padding.top;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(top: padding),
      child: Stack(
        children: [
          if (isLoadingState) const LinearProgressIndicator(),
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    opacity: 0.1,
                    image: AssetImage("assets/images/trophy.png"))),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/images/takwira.png",
                          width: 140,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "Sign In",
                          style: TextStyle(
                            fontFamily: "Arial",
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 48),
                        AppTextField(
                          controller:
                              Provider.of<SignInVM>(context, listen: false)
                                  .userNameController,
                          label: "username",
                          icon: const Icon(Icons.person),
                        ),
                        const SizedBox(height: 16),
                        // password field
                        AppTextFieldPassword(
                            textEditingController:
                                Provider.of<SignInVM>(context, listen: false)
                                    .passwordController),
                        const SizedBox(height: 20),
                        appPrimaryButton(
                          context,
                          "Sign in",
                          () async {
                            final result = await Provider.of<SignInVM>(context,
                                    listen: false)
                                .signInController();
                            if (result is NavigationState) {
                              if (mounted) {
                                context.go(result.route);
                              }
                            } else if (result is ErrorState) {
                              if (mounted) {
                                await showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => Center(
                                            child: AlertDialog(
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  result.onDismis();
                                                  context.pop();
                                                },
                                                child: const Text("OK"))
                                          ],
                                          title: const Text("Error"),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [Text(result.error)],
                                          ),
                                        )));
                              }
                            }
                          },
                        ),
                        const SizedBox(height: 8),
                        appSecondaryButton(context, "Get Started", () {}),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            context.go("/signup",);
                          },
                          child: const Text('Don\'t have an account? Sign up'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          TextButton(onPressed: () {
            context.goNamed("example");
          }, child: const Text("show example")),
        ],
      ),
    ));
  }
}
