import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uvento/Views/Attendies/Attendies_view_model.dart';
import 'package:uvento/Views/Utilis/Widgets/Circular_progress_indicator.dart';

import '../../Data/response/status.dart';


import '../Utilis/App_colors.dart';
import '../Utilis/Widgets/GeneralAppbar.dart';
import '../Utilis/Widgets/Searchable_text_feild.dart';
import '../Utilis/Widgets/attendies.dart';
import '../Utilis/Widgets/speakers.dart';
import 'Attendies_details.dart';

class Attendies extends StatefulWidget {
  @override
  State<Attendies> createState() => _speakersState();
}

class _speakersState extends State<Attendies> {

  Attendies_view_model model = Attendies_view_model();



  @override
  void initState() {

    super.initState();
    model.attendees();

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        backgroundColor: AppColors.primaryColor,

        body: ChangeNotifierProvider<Attendies_view_model>(
        create: (BuildContext context) => model,
    child: Consumer<Attendies_view_model>(
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
            CustomAppBar(title: 'Attendees',),
            CustomTextField(controller:model.controller ,onChanged: (query){

              model.updatesearchquery(query);

            }, ),
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                  itemCount: model.filterlist.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    var data = model.filterlist[index];
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Attendieswidget(
                        desc: data.memberDesignation, name: data.memberName, tablenumber: data.tableNo.toString(), imgeAssetPath:data.image, ontap: () {
                          print("object");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Attendies_detail(imgeAssetPath: data.image, name:  data.memberName, decs: data.memberDesignation, room_no: data.roomNo, table_no: data.tableNo, number: data.mobile, hotel_name: data.hotel_of_stay, branch: data.branch,)

                            ),
                          );},


                      ),
                    );

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