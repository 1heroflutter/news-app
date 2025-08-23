import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsDetailBottomBar extends StatelessWidget {
  const NewsDetailBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BottomAppBar(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        child: Column(
          children: [
            Divider(color: theme.colorScheme.onSecondary, height: 1),

            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite, color: Colors.pink, size: 22),
                  ),
                  SizedBox(width: 30),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.insert_comment_outlined, color: theme.colorScheme.onPrimary, size: 22),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.bookmark, color: theme.primaryColor, size: 22),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}
