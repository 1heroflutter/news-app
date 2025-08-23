import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/presentation/setupUserProfile/widgets/build_country_page.dart';
import 'package:news/presentation/setupUserProfile/widgets/build_profile_page.dart';
import 'package:news/presentation/setupUserProfile/widgets/build_topic_page.dart';


class SetupUserProfilePage extends StatefulWidget {
  SetupUserProfilePage({super.key});

  @override
  State<SetupUserProfilePage> createState() => _SetupUserProfilePageState();
}
class _SetupUserProfilePageState extends State<SetupUserProfilePage> {
  final PageController pageController = PageController(initialPage: 0);
  final TextEditingController country = TextEditingController(text: "us");

  final List<String> selectedTopics = ["general"];

  @override
  void dispose() {
    pageController.dispose();
    country.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: PageView.builder(
          controller: pageController,
          itemCount: 3,
          itemBuilder: (context, index) {
            return buildPage(index, theme);
          },
        ),
      ),
    );
  }

  Widget buildPage(int index, ThemeData theme) {
    if (index == 0) {
      return BuildCountryPage(country: country, pageController: pageController);
    } else if (index == 1) {
      return BuildTopicPage(
          selectedTopics: selectedTopics, pageController: pageController);
    } else {
      return BuildProfilePage(
        pageController: pageController,
        selectedTopics: selectedTopics,
        country: country,
      );
    }
  }
}
