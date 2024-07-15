import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uvento/Views/Feedback/Feedback_view.dart';
import 'Live_stream/live_stream.dart';
import 'Location/Location_view.dart';
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

  @override
  void initState() {
    super.initState();
    getAndSaveImages();
  }

  Future<void> getAndSaveImages() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance
          .collection('logos')
          .doc('OVLPo8vmMvDWzU1LZHA0-logos')
          .get();

      Map<String, dynamic>? data = doc.data();
      print('Data retrieved from Firestore: $data');

      if (data != null) {
        String agendaLogo = data['agenda_logo'];
        String homepageLogo = data['homepage_logo'];
        String homepageMain = data['homepage_main'];

        // Check if URLs are not empty or null
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
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.white,))
          : Stack(
        children: <Widget>[
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
                Center(
                  child: Text(
                    "ANNUAL SALES CONFERENCE 2024-2025",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
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
                            MaterialPageRoute(
                                builder: (context) => Navbar(index: 0, img: '')),
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
                            MaterialPageRoute(
                                builder: (context) => GoogleMapScreen()),
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
                        title: 'CHANNEL',
                        ontap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LiveStreamWebView()),
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
                            MaterialPageRoute(
                                builder: (context) => Navbar(index: 1, img: '')),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 68),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: custombox(
                            title: 'FEEDBACKS',
                            ontap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Feedbacks()),
                              );
                            }
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (homepageMain != null)
                      Image.network(homepageMain!, height: 200, width: 250),
                  ],
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    "عہد کرو پروازِ جنون اپناؤ گے\nفلک پر اپنی بقا کے نشان چھوڑ جاؤ گے",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 23,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
