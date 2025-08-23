import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/appbar/basicBtn.dart';
import '../../../common/widgets/appbar/basic_appbar.dart';

class BuildTopicPage extends StatefulWidget {
  final PageController pageController;

  final List<String> selectedTopics;

  const BuildTopicPage({
    super.key,
    required this.selectedTopics,
    required this.pageController,
  });

  @override
  State<BuildTopicPage> createState() => _BuildTopicPageState();
}

class _BuildTopicPageState extends State<BuildTopicPage> {
  final List<String> topics = [
    "general",
    "health",
    "science",
    "business",
    "entertainment",
    "sports",
    "technology",
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        BasicAppBar(
          icon: Icons.arrow_back,
          title: Text(
            "Select your Topics",
            style: TextStyle(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          onLeadingTap: () {
            widget.pageController.animateToPage(
              0,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          suffer: null,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 14, right: 14, top: 12, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                listTopics(theme),
                Spacer(),
                BasicBtn(
                  onTap: () async {
                    if (widget.selectedTopics.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please select your topic")),
                      );
                    } else {
                      for (var topic in widget.selectedTopics) {
                        print("Selected : $topic");
                      }

                      setState(() {
                        widget.pageController.animateToPage(
                          2,
                          duration: Duration(microseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      });
                    }
                  },
                  theme: theme,
                  text: "Next",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget listTopics(ThemeData theme) {
    List<String> selectedTopics = widget.selectedTopics;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          topics.map((item) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (selectedTopics.contains(item)) {
                    setState(() {
                      selectedTopics.remove(item);
                    });
                  } else {
                    setState(() {
                      selectedTopics.add(item);
                    });
                  }
                });
              },
              child: Chip(
                backgroundColor:
                    selectedTopics.contains(item)
                        ? theme.primaryColor
                        : theme.colorScheme.onSecondaryContainer,
                label: Text(
                  item.toUpperCase(),
                  style: TextStyle(
                    color:
                        selectedTopics.contains(item)
                            ? Colors.white
                            : theme.colorScheme.onPrimary,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: BorderSide(color: theme.primaryColor, width: 1.5),
                ),
              ),
            );
          }).toList(),
    );
  }
}
