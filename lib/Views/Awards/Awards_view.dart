import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uvento/Views/Utilis/App_colors.dart';
import '../Polls/Polls_view.dart';
import '../Utilis/Widgets/Circular_progress_indicator.dart';
import '../Utilis/Widgets/GeneralAppbar.dart';
import '../Utilis/Widgets/speakers.dart';
import 'Awards_view_model.dart';
import 'Result/Result_view.dart';

class Awards extends StatefulWidget {
  @override
  State<Awards> createState() => _AwardsState();
}

class _AwardsState extends State<Awards> {
  Awards_view_model model = Awards_view_model();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: ChangeNotifierProvider<Awards_view_model>(
        create: (BuildContext context) => model,
        child: Consumer<Awards_view_model>(
          builder: (context, value, _) {
            return StreamBuilder(
              stream: model.getdata,
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return circular_bar();
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.data() == null) {
                  return Center(child: Text('No Data Available'));
                }
                var data = snapshot.data!.data() as Map<String, dynamic>;
                var visible = data['visiblility']['ischeck'];
                if (visible == 'true')
                return

    Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomAppBar(title: 'Awards'),
                      SizedBox(height: 10),

                      Expanded(
                        child:

                        ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            String id = data.keys.toList()[index];
                            var awardKey = data.keys.elementAt(index);
                            var awardData = data[awardKey];


                            if (awardData['award_name'] == null) {
                              return SizedBox.shrink(); // Skip this item if award_name is null
                            }

                            // Check the visibility condition

                              var nominees = (awardData['nominee'] != null && awardData['nominee'] is Map<String, dynamic>)
                                  ? (awardData['nominee'] as Map<String, dynamic>).values.toList()
                                  : [];

                              return Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Awardswidget(
                                      desc: awardData['award_name'] ?? '',
                                      imgeAssetPath: awardData['award_image'] ?? '',
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Polls(nominees: nominees, id: id, title: awardData['award_name'],),
                                          ),
                                        );
                                      },
                                      address: '', // Add address if needed
                                      date: '', // Add date if needed
                                      resultonTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Result(nominees: nominees, title: awardData['award_name'],),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }

                        ),

                      ),

                    ],
                  ),
                );

      return
    Center(
    child: Text("No Awards Found", style: TextStyle(color: AppColors.yellow, fontSize: 16),),
    );
              },
            );
          },
        ),
      ),
    );
  }
}

