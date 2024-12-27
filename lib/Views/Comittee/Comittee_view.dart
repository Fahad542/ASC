import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:uvento/Views/Attendies/Attendies_view_model.dart';
import 'package:uvento/Views/Utilis/Widgets/Circular_progress_indicator.dart';

import '../../Data/response/status.dart';


import '../Attendies/Attendies_details.dart';
import '../Utilis/App_colors.dart';
import '../Utilis/Widgets/Comittee_widget.dart';
import '../Utilis/Widgets/GeneralAppbar.dart';
import '../Utilis/Widgets/Searchable_text_feild.dart';
import '../Utilis/Widgets/attendies.dart';
import 'Comittee view model.dart';



class Comittee extends StatefulWidget {
  @override
  State<Comittee> createState() => _speakersState();
}

class _speakersState extends State<Comittee> {

  Comittee_view_model model = Comittee_view_model();



  @override
  void initState() {

    super.initState();
    model.attendees();

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(

        title: Text('Team Members', style: TextStyle(color: AppColors.yellow)),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: true,
      ),


      body: ChangeNotifierProvider<Comittee_view_model>(
        create: (BuildContext context) => model,
        child: Consumer<Comittee_view_model>(
          builder: (context, value, _) {

            switch (value.list.status) {
              case Status.LOADING:
                return Center(child: circular_bar());
              case Status.ERROR:
                return Center(child: Text(value.list.message.toString(),style: TextStyle(
                    color: AppColors.yellow, fontSize: 13
                ),));
              case Status.COMPLETED:
                print('User count: ${value.list.data!}');

                if(model.filterlist.length<0)
                {
                  return Center(child: Text("NO ATTENDEES FOUND !", style: TextStyle(color: AppColors.yellow),));
                }
                else {
                  return

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                Lottie.asset('assets/team.json', height: 130, width: 140),


                        Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                              itemCount: model.filterlist.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index){
                                var data = model.filterlist[index];
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Comitteewidget(
                                    desc: data.memberDesignation, name: data.memberName, number: data.mobile.toString(), imgeAssetPath:data.image
                                ));

                              }),
                        ),
                      ],),
                    );

                }
              default:
                return Container();
            }  },
        ),

      ),
    );
  }
}