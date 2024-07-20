import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uvento/Views/Utilis/App_colors.dart';
import 'package:uvento/Views/Utilis/Utilis.dart';
import 'package:uvento/Views/Utilis/Widgets/button.dart';

import '../Utilis/Widgets/GeneralAppbar.dart';
import '../navbar/Nav_bar.dart';
import 'collaboration_list.dart';



class collaboration extends StatefulWidget {
  @override
  _CollaborationState createState() => _CollaborationState();
}

class _CollaborationState extends State<collaboration> {
  List<Offset?> points = [];
  bool ischeck = false;

  Future<void> _saveDrawing() async {
    setState(() {
      ischeck = true;
    });

    try {
      // Convert points to a format suitable for Firestore
      List<Map<String, num>> pointsData = points.map((point) {
        if (point == null) {
          return {'x': -1, 'y': -1}; // Use -1, -1 to indicate a null point
        } else {
          return {'x': point.dx, 'y': point.dy};
        }
      }).toList();

      // Create a new document in the 'drawings' collection
      await FirebaseFirestore.instance.collection('drawings').add({
        'points': pointsData,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Clear the drawing after saving
      setState(() {
        ischeck = false;
        points.clear();
      });

      Utilis.success('Your vision has been submitted!');
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Navbar(index: 3, img: '',)),
      );

    } catch (e) {
      setState(() {
        ischeck = false;
      });

      Utilis.toastmessage('Failed to save your vision');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: (!ischeck)
          ? Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(

          children: [
            CustomAppBar(title: 'Vision Board'),
           Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(''),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Navbar(index: 3, img: '',)),
                    );
                  },
                  child:
                  Column(children: [
                  Image.asset('assets/drawing.png', height: 40, width: 40,color: Colors.white,),
                    SizedBox(height: 5,),
                    Text('See Visionboard', style: TextStyle(color: AppColors.yellow, fontSize: 11),)
                ])  )

              ],
            ),
            SizedBox(height: 20,),
            Container(
              height: 400,
             
              decoration: BoxDecoration(color:Colors.white,  borderRadius: BorderRadius.circular(14)),
              child: ClipRect(
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      points.add(details.localPosition);
                    });
                  },
                  onPanEnd: (details) {
                    setState(() {
                      points.add(null); // Null indicates the end of a stroke
                    });
                  },
                  child: CustomPaint(
                    painter: DrawingPainter(points, Colors.black),
                    size: Size.infinite,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(''),
                InkWell(
                  onTap: (){
                    points.clear();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8)),
                    child: Text("Clear", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                  ),
                )

              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                roundbutton(
                  title: "SUBMIT",
                  onpress: () async {
                    if(points.isNotEmpty){
                    await _saveDrawing();}
                    else {
                      Utilis.toastmessage('Your vision is empty!');
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      )
          : Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;
  Color color;

  DrawingPainter(this.points, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color // Changed to black for better visibility
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}