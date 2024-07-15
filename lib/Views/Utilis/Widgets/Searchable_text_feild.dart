import 'package:flutter/material.dart';
import 'package:uvento/Views/Utilis/App_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    Key? key,
     this.controller,
    this.hintText = 'Search...',
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(color: AppColors.yellow),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.yellow),
        prefixIcon: Icon(Icons.search, color: AppColors.yellow,),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color:AppColors.yellow ),
          borderRadius: BorderRadius.circular(16)
        ),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.yellow, width: 2),
            borderRadius: BorderRadius.circular(16)
        ),
        border: OutlineInputBorder(


          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
