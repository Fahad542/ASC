import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:uvento/Views/Utilis/Utilis.dart';
import '../Utilis/App_colors.dart';
import '../Utilis/Widgets/GeneralAppbar.dart';
import '../Utilis/Widgets/button.dart';
import 'Polls_view_model.dart';

class Polls extends StatefulWidget {
  final List<dynamic> nominees;
  final String id;
  final String title;

  Polls({
    required this.nominees,
    required this.id,
    required this.title
  });

  @override
  State<Polls> createState() => _PollsState();
}

class _PollsState extends State<Polls> {
  dynamic selectedvalue;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Pollsviewmodel>(
      create: (context) => Pollsviewmodel(),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Consumer<Pollsviewmodel>(
          builder: (context, model, child) {
            if (model.ischeck) {
              return Center(child: CircularProgressIndicator(color: Colors.white,));
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: widget.nominees.isEmpty
                    ? Center(
                  child: Text(
                    "NO NOMINEES FOUND!",
                    style: TextStyle(color: AppColors.yellow),
                  ),
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomAppBar(title: widget.title),
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.nominees.length,
                        itemBuilder: (context, index) {
                          var nominee = widget.nominees[index];
                          return RadioListTile<dynamic>(
                            title: Text(
                              nominee['nominee_name'],
                              style: TextStyle(color: AppColors.whiteColor),
                            ),
                            value: nominee,
                            groupValue: selectedvalue,
                            onChanged: (dynamic value) {
                              setState(() {
                                selectedvalue = value;
                              });
                            },
                            activeColor: AppColors.yellow,
                            controlAffinity: ListTileControlAffinity.trailing,
                          );
                        },
                      ),
                    ),
                    Lottie.asset("assets/Animation - 1720418399460.json"),
                    SizedBox(height: 40),
                    roundbutton(
                      title: "VOTE",
                      onpress: () async {
                        if (selectedvalue != null) {
                          if (selectedvalue['nominee_id'].toString() != null) {
                            await model.incrementVote(widget.id, selectedvalue['nominee_id'].toString());
                            selectedvalue=null;
                          }
                        } else {
                          Utilis.toastmessage("Please Select a Nominee First");
                        }
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
