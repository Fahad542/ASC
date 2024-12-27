import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uvento/Views/Utilis/App_colors.dart';
import '../Polls/Polls_view_model.dart';
import '../Splash_screen.dart';
import '../Utilis/Widgets/Circular_progress_indicator.dart';
import '../Utilis/Widgets/No_data_found.dart';
import '../Utilis/Widgets/container.dart';
import 'home_view_model.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {

    HomeScreen( );
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel model = HomeViewModel();
  Pollsviewmodel models=Pollsviewmodel();
  String homepageMain='';





  @override
  void initState()
  {
    super.initState();
    model.initialdate();
    fetchHomepageMainFromSharedPreferences();
  }
  Future<void> fetchHomepageMainFromSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedHomepageMain = prefs.getString('agenda_logo');

      if (storedHomepageMain != null) {
        setState(() {
          homepageMain = storedHomepageMain; // Update homepageMain from SharedPreferences
        });

        print('Homepage main image retrieved from SharedPreferences');
      } else {
        print('No homepage main image found in SharedPreferences');
      }
    } catch (e) {
      print("Error fetching homepage main image from SharedPreferences: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider<HomeViewModel>(
          create: (BuildContext context) => model,
          child: Consumer<HomeViewModel>(
              builder: (context, model, child) {
                return
                  StreamBuilder(
                    stream: model.getdata,
                    builder: (context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return circular_bar();
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.data() == null) {
                        return nodata();
                      }
                      var data = snapshot.data!.data() as Map<String, dynamic>;
        List<String> sortlist=data.keys.toList()..sort((a,b)=> a.compareTo(b));

                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 35),
                             Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
if(homepageMain.isNotEmpty)
                                    InkWell(
                                      onTap: (){  Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SplashScreen()),
                                      );},
                                        child: Image.network(
                                            homepageMain, height: 88)),
                                    InkWell(
                                        onTap: (){  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SplashScreen()),
                                        );},
                                        child: Icon(Icons.home, color: AppColors.yellow,size: 28,))
                                  ],
                                ),


                              Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Text("ASSALAM O ALAIKUM!", style: TextStyle(
                                        color: AppColors.yellow,
                                 fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      )),
                                      SizedBox(height: 6),
                                      Text(
                                          "Let's explore what’s happening nearby",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ))
                                    ],
                                  ),
                                  Spacer(),
                                ],
                              ),


                              /// Dates
                              SizedBox(height: 20,),
                              Container(
                                height: 55,

                                child: ListView.builder(
                                  itemCount: sortlist.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {

                                    String id = sortlist[index];

                                    List<String> parts=id.split('-');
                                    String day = parts[0];
                                    String month = parts[1];

                                    return DateTile(
                                      weekDay: day,
                                      date: month,
                                      isSelected: model.selecteddate == id,
                                      ontap: () {
                                        model.setSelectedDate(id);
                                        //model.notifyListeners();
                                      },
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 16),
                              Text("Upcoming Sessions", style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              )),
                              // SizedBox(height: 16),

                              Expanded(
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: model.selecteddate.isEmpty ? 0 : 1,
                                  itemBuilder: (context, index) {
                                    var sessions = data[model.selecteddate] as Map<String, dynamic>;

                                    // Convert the sessions map to a list of entries
                                    var sessionEntries = sessions.entries.toList();

                                    // Assuming the keys are numeric strings and need to be sorted as integers
                                    sessionEntries.sort((a,b) {
                                      var keyA = int.tryParse(a.key) ?? 0;
                                      var keyB = int.tryParse(b.key) ?? 0;
                                      return keyA.compareTo(keyB);
                                    });

                                    // Print sorted session keys for debugging
                                    for (var entry in sessionEntries) {
                                      print('Sorted Session ${entry.key}');
                                    }

                                    return Column(
                                      children: sessionEntries.map((entry) {
                                        var session = entry.value as Map<String, dynamic>;
                                        return PopularEventTile(conference: session);
                                      }).toList(),
                                    );
                                  },
                                ),
                              )


                            ]
                        ),
                      );
                    },
                  );
              }),


        ));
  }
}
class DateTile extends StatelessWidget {
  final String weekDay;
  final String date;
  final VoidCallback ontap;
  final bool isSelected;
  DateTile({required this.weekDay, required this.date, required this.isSelected, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Container(


        padding: EdgeInsets.symmetric(horizontal: 10),

        decoration: BoxDecoration(

            color: isSelected ? AppColors.yellow : Colors.transparent,
            borderRadius: BorderRadius.circular(10)
        ),
        child: InkWell(
          onTap: ontap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(weekDay, style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17
              )),
             SizedBox(height: 6,),
             // Text(),
              Text(date, style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight:  FontWeight.bold,
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class PopularEventTile extends StatelessWidget {
   var conference;

  PopularEventTile({required this.conference});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Container(

          margin: EdgeInsets.only(bottom: 13),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(
              color: AppColors.whiteColor.withOpacity(0.6),
            )],
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width - 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(conference['session_title']!=null ?conference['session_title'] :'No Data', style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                      )),
                      SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Session By: ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                            TextSpan(
                              text: conference['session_by']!=null ?conference['session_by'] :'No Data',
                              style: TextStyle(
                                color: AppColors.yellow,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          Icon(Icons.access_time, color: Colors.white, size: 16),
                          SizedBox(width: 5),
                          Text(
                              "${ conference['start_time']!=null ?conference['start_time']: 'No Data' } - ${conference['end_time']!=null ?conference['end_time']:'No Data'}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold
                              )
                          )
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(

                        children: <Widget> [

                          containerwidget(title: 'Conference Hall', color: Colors.purple, Textcolor: Colors.white,),
                          SizedBox(width: 8),
                          containerwidget(title: 'MEMBER ACCESS', color: Colors.green, Textcolor: Colors.white,),
                          Spacer(),
                          if(conference['live']=='true')
                            Row(children:[ Lottie.asset('assets/Animation - 1720071333989.json'),
                            Text("LIVE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 10),)
                            ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
