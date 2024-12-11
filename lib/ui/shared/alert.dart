import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// void showAlert(
//   BuildContext context,
//   String text,
// ) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text("Alert Title"),
//         content: const Text("This is an alert message."),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Dismiss the dialog
//             },
//             child: const Text("OK"),
//           ),
//         ],
//       );
//     },
//   );
// }

class AlertDialogController {
  final isPasswordShown = ValueNotifier<bool>(false);
  String? message;
  String? title;
  Function()? onDismis;
  Function()? onConfirm;

  void showAlertDialog(String title, String message, Function()? onDismiss,
      Function()? onConfirm) {
    this.message = message;
    this.title = title;
    this.onConfirm = onConfirm;
    this.onDismis = onDismiss;
    this.isPasswordShown.value = true;
  }

  void hide() {
    this.message = null;
    this.message = null;
    this.onConfirm = null;
    this.onDismis = null;
    isPasswordShown.value = false;
  }
}

AlertDialogController rememberAlertDialogStateState() {
  return AlertDialogController();
}

// class AppAlertDialog extends StatefulWidget {
//   AlertDialogController alertDialogState;

//   AppAlertDialog({super.key, required this.alertDialogState});

//   get message => null;

//   @override
//   _AlertState createState() => _AlertState();
// }

// class _AlertState extends State<AppAlertDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//         valueListenable: widget.alertDialogState.isPasswordShown,
//         builder: (context, value, child) {
//           AnimatedBuilder(
//             animation: widget.alertDialogState.isPasswordShown,
//             builder: (context, child) {},
//           );
//         });
//   }
// }

class AlertState extends StatefulWidget {
  @override
  _AlertState createState() => _AlertState();
}

class _AlertState extends State<AlertState> with TickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 2));
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  VoidCallback? onConfirm;
  final VoidCallback onCancel;

  CustomAlertDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.onCancel,
      this.onConfirm});
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: true,
      child: AnimatedOpacity(
        duration: const Duration(microseconds: 500),
        opacity: 1,
        child: Container(
          color: const Color.fromARGB(120, 0, 0, 0),
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      content,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: onCancel,
                          child: Text(onConfirm == null ? 'Cancel' : "OK",
                              style: const TextStyle(color: Colors.black)),
                        ),
                        if (onConfirm != null)
                          ElevatedButton(
                            onPressed: onConfirm,
                            child: const Text('OK'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
