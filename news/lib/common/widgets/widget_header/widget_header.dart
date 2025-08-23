import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuildWidgetHeader extends StatelessWidget {
  final String leading;
  final VoidCallback? onTap;

  const BuildWidgetHeader({
    super.key,
    required this.leading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leading,
          style: TextStyle(
            fontSize: 20,
            color: theme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap != null
            ? GestureDetector(
              onTap: onTap,
              child: Text(
                "See all",
                style: TextStyle(
                  fontSize: 13,
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w200,
                ),
              ),
            )
            : Container(),
      ],
    );
  }
}
