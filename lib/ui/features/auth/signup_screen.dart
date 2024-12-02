import 'package:flutter/material.dart';
import 'package:project_flutter_football/models/auth/token_model.dart';
import 'package:project_flutter_football/ui/shared/alert.dart';
import 'package:project_flutter_football/ui/shared/app_buttons.dart';
import 'package:project_flutter_football/ui/view_model/shared_view_model/auth_view_model/signin_vm.dart';
import 'package:project_flutter_football/utils/ui_state.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>(); // To validate the form
  @override
  Widget build(BuildContext outercontext) {
    return ChangeNotifierProvider(
      create: (context) => SignInVM(),
      child: Scaffold(
        body: Builder(
          builder: (context) {
            return Consumer<SignInVM>(
              builder: (context, signInVM, child) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontFamily: "Arial",
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 48),
                                TextFormField(
                                  controller: signInVM.userNameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Username',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your username';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: signInVM.passwordController,
                                  decoration: const InputDecoration(
                                    labelText: 'Password',
                                    border: OutlineInputBorder(),
                                  ),
                                  obscureText: true, // Hide password text
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                appPrimaryButton(context, "Sign in", () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    signInVM.signInController();
                                  }
                                }),
                                const SizedBox(height: 8),
                                appSecondaryButton(
                                    context, "Get Started", () {}),
                                const SizedBox(height: 16),
                                TextButton(
                                  onPressed: () {
                                    // Navigate to signup page or do something else
                                  },
                                  child: const Text(
                                      'Don\'t have an account? Sign up'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (signInVM.uiState is LoadingState)
                      const Center(child: CircularProgressIndicator()),
                    if (signInVM.uiState is SuccessState)
                      const SizedBox(child: Text("Succes")),
                    if (signInVM.uiState is ErrorState)
                      AnimatedOpacity(
                        opacity: 1,
                        duration: const Duration(seconds: 1),
                        child: AlertDialog(
                          title: const Text("Error"),
                          content: Text((signInVM.uiState as ErrorState).error),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  (signInVM.uiState as ErrorState).onDismis();
                                },
                                child: const Text("Ok"))
                          ],
                        ),
                      )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
