import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class containerwidget extends StatefulWidget {
  final String title ;
  final Color color;
   final VoidCallback? ontap;
  const containerwidget({super.key, required this.title, required this.color, this.ontap});


  @override
  State<containerwidget> createState() => _containerState();
}

class _containerState extends State<containerwidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: Container(

        decoration: BoxDecoration(
           // gradient: LinearGradient(colors: [widget.color, Colors.black]),
            color: widget.color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8)
        ),
        child:Padding(padding: EdgeInsets.all(8),
        child: Text(widget.title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        ),
      )),
    );
  }
}
