import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uvento/Views/Utilis/App_colors.dart';

import '../Utilis/Widgets/GeneralAppbar.dart';
import 'collaborations_view.dart';

class CollabList extends StatelessWidget {
  Future<List<List<Offset?>>> fetchDrawings() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('drawings').orderBy('timestamp', descending: true).get();
      List<List<Offset?>> drawings = querySnapshot.docs.map((doc) {
        List<dynamic> pointsData = doc['points'];
        return pointsData.map((point) {
          if (point['x'] == -1 && point['y'] == -1) {
            return null;
          } else {
            return Offset(point['x'].toDouble(), point['y'].toDouble());
          }
        }).toList();
      }).toList();
      // Print the data before reversing


      return drawings;
    } catch (e) {
      print("Error fetching drawings: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: 'Vision Board'),
          Expanded(
            child: FutureBuilder<List<List<Offset?>>>(
              future: fetchDrawings(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: AppColors.whiteColor));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data found', style: TextStyle(color: AppColors.yellow)));
                } else {
                  List<List<Offset?>> drawings = snapshot.data!;

                  return ListView.builder(
                    itemCount: drawings.length,
                    itemBuilder: (context, index) {

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: CustomPaint(
                              painter: DrawingPainter(drawings[index], Colors.white),
                              size: Size(double.infinity, 400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(color: AppColors.yellow),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

