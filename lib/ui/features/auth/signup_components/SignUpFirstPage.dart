
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_flutter_football/ui/shared/app_buttons.dart';
import 'package:project_flutter_football/ui/view_model/shared_view_model/auth_view_model/signup_vm.dart';
import 'package:project_flutter_football/utils/events.dart';
import 'package:project_flutter_football/utils/helperFunctions.dart';
import 'package:project_flutter_football/utils/ui_state.dart';
import 'package:provider/provider.dart';

import '../../../shared/text_field.dart';


class SignUpFirstPage extends StatefulWidget {
  const SignUpFirstPage({super.key});

  @override
  State<SignUpFirstPage> createState() => _SignUpFirstPageState();
}

class _SignUpFirstPageState extends State<SignUpFirstPage> {
  @override
  Widget build(BuildContext context) {
    final signUpViewModel = Provider.of<SignUpVM>(context, listen: false);

    return Column(
      children: [
      AppTextField(
        validator: (value) {
          if(value == null || value.isEmpty) {
            return "Username required";
          }
          return null;
        },
        controller: signUpViewModel.fullNameController,
        label: "full name",
        icon: const Icon(Icons.person_2_outlined),
      ),
      const SizedBox(height: 16),
      AppTextField(
        validator: validateEmail,
        controller: signUpViewModel.emailController,
        label: "email",
        icon: const Icon(Icons.email_outlined),
      ),
      const SizedBox(height: 16),
      AppTextField(
        validator: phoneValidator,
        controller: signUpViewModel.phoneNumberController,
        label: "phone",
        icon: const Icon(Icons.phone),
      ),
      const SizedBox(height: 16),
      // password field
      AppTextFieldPassword(

        textEditingController: signUpViewModel.passwordController
      ),
      const SizedBox(height: 20)          ,
      appPrimaryButton(
        context,
        "Sign up",
            () async {
            var event = await signUpViewModel.submitFormFirstPage();
            if(event is ErrorState) {
              if(context.mounted) {
                await showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => Center(
                        child: AlertDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: const Text("OK"))
                          ],
                          title: const Text("Error"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [Text(event.error)],
                          ),
                        )));
              }
            }
            },
      ),
      const SizedBox(height: 8),
      appSecondaryButton(context, "Cancel", () {}),
      const SizedBox(height: 16),
    ],);
  }
}
