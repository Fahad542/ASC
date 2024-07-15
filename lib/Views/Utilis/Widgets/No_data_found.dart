import 'package:flutter/cupertino.dart';
import 'package:uvento/Views/Utilis/App_colors.dart';

class nodata extends StatefulWidget {
  const nodata({super.key});

  @override
  State<nodata> createState() => _nodataState();
}

class _nodataState extends State<nodata> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Center(child: Text("Sorry ! No Data Found", style: TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.yellow
    ),)));
  }
}
