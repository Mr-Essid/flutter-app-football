import 'package:flutter/material.dart';
import 'package:project_flutter_football/utils/ui_state.dart';

Widget supportUiState(UiState state, Widget content) {
  return Stack(
    children: [
      content,
      if (state is LoadingState)
        const AnimatedOpacity(
          opacity: 1,
          duration: Duration(seconds: 1),
          child: AlertDialog(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              title: Text("Loading ..."),
              content: SizedBox(
                width: 100,
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )),
        ),
      if (state is SuccessState)
        AlertDialog(
          title: const Text("Success"),
          content: Text(state.message),
          actions: [
            TextButton(
                onPressed: () {
                  state.onDismis();
                },
                child: const Text("Ok"))
          ],
        ),
      if (state is ErrorState)
        AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("Error"),
          content: Text(state.error),
          actions: [
            TextButton(
                onPressed: () {
                  state.onDismis();
                },
                child: const Text("Ok"))
          ],
        ),
    ],
  );
}
