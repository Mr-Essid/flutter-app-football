


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorStateComponent extends StatelessWidget {

  final void Function()? onRetry;
  final String message;
  const ErrorStateComponent({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        color: Colors.grey.shade200,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, color: Colors.redAccent,),
                  const SizedBox(width: 4),
                  Text(message, style:  Theme.of(context).textTheme.labelLarge)
                ],
              ),
              const SizedBox(height: 4),
              TextButton(
                onPressed:onRetry,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.repeat_one_outlined,),
                    Text('retry'),
                  ],
                ),
              )
            ],
          ),
        ),
      );
  }
}
