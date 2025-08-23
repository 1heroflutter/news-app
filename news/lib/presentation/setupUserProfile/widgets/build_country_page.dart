import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/appbar/basicBtn.dart';
import '../../../common/widgets/appbar/basic_appbar.dart';
import '../../../core/configs/theme/app_colors.dart';

class BuildCountryPage extends StatefulWidget {
  final TextEditingController country ;
  final PageController pageController ;
   BuildCountryPage({super.key, required this.country,required this.pageController});

  @override
  State<BuildCountryPage> createState() => _BuildCountryPageState();
}

class _BuildCountryPageState extends State<BuildCountryPage> {
  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        BasicAppBar(
          icon: null,
          title: Text(
            "Select your Country",
            style: TextStyle(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          onLeadingTap: () {},
          suffer: null,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 14, right: 14, top: 12, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 46,
                        color: theme.colorScheme.onPrimary,
                      ),
                      children: [
                        TextSpan(text: "Continue\n"),
                        TextSpan(
                          text: "With!",
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "You will see news\n from the country you choose.",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: countryList(theme),
                ),
                Spacer(),
                BasicBtn(
                  onTap: () {
                    print('[Country]: ${widget.country.text}');
                    setState(() {
                      widget.pageController.animateToPage(
                        1,
                        duration: Duration(microseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    });
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
  Widget countryList( ThemeData theme) {
    return CountryListPick(
      initialSelection: "US",
      theme: CountryTheme(
        alphabetTextColor: theme.colorScheme.onSecondaryContainer,
        alphabetSelectedTextColor: theme.colorScheme.onSecondaryContainer,
        isShowCode: false,
      ),
      onChanged: (CountryCode? code) {
        if (code != null) {
          widget.country.text = code.code!;
        }
      },
    );
  }
}
