import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_flutter_football/models/auth/token_model.dart';
import 'package:project_flutter_football/ui/features/support_ui_status.dart';
import 'package:project_flutter_football/ui/shared/alert.dart';
import 'package:project_flutter_football/ui/shared/app_buttons.dart';
import 'package:project_flutter_football/ui/view_model/shared_view_model/auth_view_model/signin_vm.dart';
import 'package:project_flutter_football/utils/ui_state.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
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
                return supportUiState(
                  signInVM.uiState,
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
                                  await for (var event
                                      in signInVM.signInController()) {
                                    if (event is SuccessState) {
                                      showAboutDialog(
                                          context: context,
                                          children: [Text(event.message)]);
                                    }
                                    if (event is NavigationState) {
                                      context.goNamed('dashboard');
                                      event.navigationCallback();
                                    }

                                    if (event is ErrorState) {
                                      showAboutDialog(
                                          context: context,
                                          children: [Text(event.error)]);
                                    }

                                    if (event is LoadingState) {
                                      showAboutDialog(
                                          context: context,
                                          children: [
                                            const SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          ]);
                                    }
                                  }
                                }
                              }),
                              const SizedBox(height: 8),
                              appSecondaryButton(context, "Get Started", () {}),
                              const SizedBox(height: 16),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                    'Don\'t have an account? Sign up'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
