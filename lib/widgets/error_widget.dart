import 'package:flutter/material.dart';
import 'package:top_news/utils/dimensions.dart';

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
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.messageHorizontalPadding,
        ),
        child: Text(
          message,
          style: textTheme.bodyMedium?.copyWith(color: Colors.deepOrangeAccent),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
