import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/configs/theme/app_colors.dart';

import '../bloc/search_cubit.dart';
import '../bloc/selectable_option_cubit.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  const SearchField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      cursorColor: AppColors.primary,
      controller: controller,
      onChanged: (value) {
        context.read<SearchCubit>().search(
          value,
          context.read<SelectableOptionCubit>().state,
        );
      },
      decoration: const InputDecoration(), 
    );

  }
}
