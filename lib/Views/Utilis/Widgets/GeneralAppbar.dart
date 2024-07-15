
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../App_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final double elevation;
  final Color backgroundColor;
  final bool automaticallyImplyLeading;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.centerTitle = true,
    this.elevation = 0.0,
    this.backgroundColor = Colors.transparent,
    this.automaticallyImplyLeading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.yellow,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      elevation: elevation,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
