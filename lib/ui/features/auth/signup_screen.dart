import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_flutter_football/models/auth/token_model.dart';
import 'package:project_flutter_football/ui/features/auth/signup_components/SignUpFirstPage.dart';
import 'package:project_flutter_football/ui/features/auth/signup_components/SignUpSecondPageOTP.dart';
import 'package:project_flutter_football/ui/view_model/shared_view_model/auth_view_model/signup_vm.dart';
import 'package:project_flutter_football/utils/ui_state.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {


  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    final currentPage = context.watch<SignUpVM>().currentPage;
    final isLoading = context.watch<SignUpVM>().isLoadingState;
    var padding = MediaQuery.of(context).padding.top;
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: padding),
          child: Stack(
            children: [
              if (isLoading) const LinearProgressIndicator(),
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        opacity: 0.1,
                        image: AssetImage("assets/images/trophy.png"))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    heightFactor: 1.3,
                    child: SingleChildScrollView(
                      child: Form(
                        key: Provider.of<SignUpVM>(context).formKey,
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
                              "Sign up",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 48),
                            AnimatedSwitcher(
                                duration: const Duration(microseconds: 500),
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              child: (currentPage == 1) ? const SignUpFirstPage(key: ValueKey(1),) :
                              SignUpSecondPageOTP(key: const ValueKey(2),) ,
                                  // Container(
                                  //   height: 400,
                                  //  child:
                                  //
                                  // )
                            ),
                            TextButton(
                              onPressed: () {
                                context.go("/",);
                              },
                              child: const Text('Already Have Account ?, login'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
