import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/configs/theme/app_colors.dart';


class SelectableOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableOption({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(title, style: TextStyle(fontWeight: isSelected?FontWeight.bold:FontWeight.w200, fontSize: 16),),
          SizedBox(height: 4,),
          isSelected?SizedBox(height:1, width:40,child: Divider(color: AppColors.primary,thickness: 4,)):Container()
        ],
      ),
    );
  }
}
