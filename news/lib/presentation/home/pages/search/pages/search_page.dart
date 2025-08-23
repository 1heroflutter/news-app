import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/common/helper/app_navigator.dart';
import 'package:news/common/widgets/appbar/basic_appbar.dart';

import '../bloc/search_cubit.dart';
import '../bloc/selectable_option_cubit.dart';
import '../widgets/search_bar.dart';
import '../widgets/search_content.dart';
import '../widgets/search_option.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  SearchPage({super.key});
  @override
  void onDispose(){
    controller.dispose();
    onDispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SelectableOptionCubit()),
          BlocProvider(create: (context) => SearchCubit()),
        ],
        child: Column(
          children: [
            BasicAppBar(
              icon: Icons.arrow_back,
              title: null,
              onLeadingTap: () {
                AppNavigator.pop(context);
              },
              suffer: null,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SearchField(controller: controller),
                    const SizedBox(height: 16),
                     SearchOption(),
                    const SizedBox(height: 16),
                    Expanded(child: SearchContent()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
