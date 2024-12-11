import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_flutter_football/ui/shared/app_buttons.dart';
import 'package:project_flutter_football/ui/view_model/shared_view_model/auth_view_model/signup_vm.dart';
import 'package:project_flutter_football/utils/ui_state.dart';
import 'package:provider/provider.dart';



class SignUpSecondPageOTP extends StatefulWidget {
  SignUpSecondPageOTP({super.key});
  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<SignUpSecondPageOTP> {
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
     Provider.of<SignUpVM>(context, listen: false).sendOTP();
  }

  void _onFieldSubmitted(int index, String value) {
    if (index < _focusNodes.length - 1 && value.isNotEmpty) {
      _focusNodes[index + 1].requestFocus();
    }else if (index > 0 && value.isEmpty) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {

    final viewModel = Provider.of<SignUpVM>(context, listen: false);

    return Column(
          children: [
            const Text(
              "Enter the 6-digit OTP",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: List.generate(growable: false,  6, (index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: SizedBox(
                    width: 40,
                    height: 60,
                    child: TextField(
                      controller: viewModel.controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (value) => _onFieldSubmitted(index, value),
                    ),
                  ),
                );

              }),
            ),
            TextButton(onPressed: (){}, child: const Row(
              children: [
                 Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min,children: [Icon(Icons.schedule_send), SizedBox(width: 4,), Text("Resend")],),
              ],
            ),),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: appPrimaryButton(context, "Go ahead", () async {
                final event = await viewModel.verifyOTPCode();
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
                if(event is NavigationState) {
                  final route = event.route;
                  event.navigationCallback();
                  if(context.mounted) {
                    context.go(route);
                  }
                }
              })
              ),
            const SizedBox(height: 8,),
            SizedBox(
                width: 200,
                child: appSecondaryButton(context, "Later on?", (){})
            )
          ],
        );
  }
}
