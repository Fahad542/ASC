import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uvento/Views/Collaborations/collaborations_view.dart';
import 'package:uvento/Views/Comittee/Comittee_view.dart';
import 'package:uvento/Views/Downloads/Downloads_view.dart';
import 'Feedback/Feedback_view.dart';
import 'Live_stream/live_stream.dart';
import 'Location/Location_view.dart';
import 'Notifications/Notifications_view.dart';
import 'Services/local_db.dart';
import 'Utilis/Widgets/Custom_boxes.dart';
import 'navbar/Nav_bar.dart';
class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? homepageLogo;
  String? homepageMain;
  bool isLoading = true;
  int notificationCount = 0;
  int Count=0;


  @override
  void initState() {
    super.initState();
    initNotifications();
    getAndSaveImages();
    loadNotificationCounts();

  }
  Future<void> loadNotificationCounts() async {
    try {
      DatabaseHelper databaseHelper = DatabaseHelper(); // Initialize your DatabaseHelper
      int count = await databaseHelper.getNotificationCount();
      setState(() {
        Count = count;
        print('Count: ${Count}');
      });
    } catch (e) {
      print('Error loading notification count: $e');

    }
  }

  void loadNotificationCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notificationCount = prefs.getInt('notificationCount') ?? 0;
    });
  }

  void saveNotificationCount(int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('notificationCount', count);
  }

  void initNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async  {
      await loadNotificationCounts();
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async  {
      await loadNotificationCounts();
    });
  }

  Future<void> getAndSaveImages() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
      await FirebaseFirestore.instance
          .collection('logos')
          .doc('OVLPo8vmMvDWzU1LZHA0-logos')
          .get();

      Map<String, dynamic>? data = doc.data();
      print('Data retrieved from Firestore: $data');

      if (data != null) {
        String agendaLogo = data['agenda_logo'];
        String homepageLogo = data['homepage_logo'];
        String homepageMain = data['homepage_main'];

        if (agendaLogo.isNotEmpty && homepageLogo.isNotEmpty && homepageMain.isNotEmpty) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('agenda_logo', agendaLogo);
          await prefs.setString('homepage_logo', homepageLogo);
          await prefs.setString('homepage_main', homepageMain);

          print('Images saved to SharedPreferences');

          setState(() {
            this.homepageLogo = homepageLogo;
            this.homepageMain = homepageMain;
            isLoading = false;
          });
        } else {
          print('One or more image URLs are empty.');
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print('No data found in Firestore');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error getting data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseHelper _databaseHelper = DatabaseHelper();
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.white,))
            : Padding(
          padding: EdgeInsets.all(10),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 24),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Image.asset(
                          'assets/loho.png',
                          height: 90,
                          width: 104,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => notifications(),
                          ),
                        );
                        setState(() {
                          Count = 0;
                        });
                        await _databaseHelper.updateNotificationCount();
                      },
                      child: Stack(
                        children: <Widget>[
                          Icon(Icons.notifications, color: Colors.yellow, size: 28),
                          if (Count > 0)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  Count.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        if (homepageLogo != null)
                          Image.network(homepageLogo!, height: 120, width: 120),
                      ],
                    ),
                    // Center(
                    //   child: Text(
                    //     "ANNUAL SALES CONFERENCE 2024-2025",
                    //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: custombox(
                            title: 'AGENDA',
                            ontap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Navbar(index: 0, img: '')),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 10),

                        Expanded(
                          child: custombox(
                            title: 'ATTENDEES',
                            ontap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Navbar(index: 1, img: '')),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: custombox(
                            title: 'AWARDS',
                            ontap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Navbar(index: 2, img: '')),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: custombox(
                            title: 'VISIONBOARD',
                            ontap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>collaboration()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: custombox(
                              title: 'FEEDBACKS',
                              ontap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Feedbacks()),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: custombox(
                              title: 'MAPS',
                              ontap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => GoogleMapScreen()),
                                );
                              },
                            ),
                          ),

                        ],

                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: custombox(
                                title: 'COMMITTEE',
                                ontap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Comittee()),
                                  );
                                },
                              ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: custombox(
                              title: 'DOWNLOADS',
                              ontap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => downloads()),
                                );
                              },
                            ),
                          ),


                        ],

                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (homepageMain != null) Image.network(homepageMain!, height: 200, width: 250),
                      ],
                    ),
                    // Directionality(
                    //   textDirection: TextDirection.rtl,
                    //   child: Text(
                    //     "عہد کرو پروازِ جنون اپناؤ گے\nفلک پر اپنی بقا کے نشان چھوڑ جاؤ گے",
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 23,
                    //     ),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
