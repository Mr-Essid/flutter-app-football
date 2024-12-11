

import 'package:flutter/material.dart';




class ShowListComponent<T> extends StatefulWidget {
  final List<T>? ourList;
  final Widget Function(BuildContext context, T model) fuckingWidget;

   const ShowListComponent({super.key, this.ourList, required this.fuckingWidget});

  @override
  State<ShowListComponent> createState() => _ShowListComponentState();
}

class _ShowListComponentState extends State<ShowListComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}


