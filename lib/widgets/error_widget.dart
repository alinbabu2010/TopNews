import 'package:flutter/material.dart';

class EmptyMsgWidget extends StatelessWidget {
  final String message;

  const EmptyMsgWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Text(
        message,
        style: textTheme.bodyMedium?.copyWith(color: Colors.deepOrangeAccent),
        textAlign: TextAlign.center,
      ),
    );
  }
}
