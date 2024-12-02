import 'package:flutter/material.dart';

Widget appPrimaryButton(
  BuildContext context,
  String text,
  VoidCallback callback,
) {
  return Row(children: [
    Expanded(
        child: FilledButton(
      onPressed: callback,
      style: FilledButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          fixedSize: const Size(double.infinity, 50),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)))),
      child: Text(text),
    )),
  ]);
}

Widget appSecondaryButton(
  BuildContext context,
  String text,
  VoidCallback callback,
) {
  return Row(children: [
    Expanded(
        child: OutlinedButton(
      onPressed: callback,
      style: FilledButton.styleFrom(
          fixedSize: const Size(double.infinity, 50),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)))),
      child: Text(text),
    )),
  ]);
}
