import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:uvento/Views/Feedback/Feedback_view_model.dart';
import 'package:uvento/Views/Utilis/App_colors.dart';
import 'package:uvento/Views/Utilis/Utilis.dart';
import '../Utilis/Widgets/GeneralAppbar.dart';
import '../Utilis/Widgets/button.dart';

class Feedbacks extends StatefulWidget {
  const Feedbacks({super.key});

  @override
  State<Feedbacks> createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedbacks> {
  Feedback_view_model model = Feedback_view_model();

  bool hasSubmittedFeedback = false; // Track if feedback has been submitted

  @override
  void initState() {
    super.initState();
    loadData();
    if (!hasSubmittedFeedback) {
         model.attendees();
      }
  }

  Future<void> loadData() async {
    hasSubmittedFeedback = await model.loadData();
    print(hasSubmittedFeedback);
    // if (!hasSubmittedFeedback) {
    //   await model.attendees();
    // }
    setState(() {}); // Update the state after loading data
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Feedback_view_model>(
      create: (context) => model,
      child: Scaffold(
        body: Consumer<Feedback_view_model>(
          builder: (context, model, child) {
            if (hasSubmittedFeedback) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Lottie.asset(
                      "assets/Animation - 1720789588979.json",
                      height: 120,
                    ),
                    Text(
                      'Your feedback has been submitted.',
                      style: TextStyle(color: AppColors.yellow, fontSize: 18),
                    ),
                  ],
                ),
              );
            } else if (model.check) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else {
              // Show feedback form
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomAppBar(title: "FEEDBACK"),
                      SizedBox(height: 100),
                      Center(
                        child: Text(
                          'Please share your thoughts:',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.whiteColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      Lottie.asset(
                        "assets/Animation - 1720789588979.json",
                        height: 70,
                      ),
                      SizedBox(height: 10),
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            model.rating = rating.toString();
                            print(rating);
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: model.code,
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number, // Set keyboard type to number
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          labelText: 'Your Employee code',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter your Employee code here',
                          hintStyle: TextStyle(color: AppColors.whiteColor),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: model.controller,
                        maxLines: 5,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          labelText: 'Your feedback',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter your feedback here',
                          hintStyle: TextStyle(color: AppColors.whiteColor),
                        ),
                      ),
                      SizedBox(height: 20),
                      roundbutton(
                        title: 'Submit',
                        onpress: () {
                          if (model.rating.isNotEmpty &&
                              model.controller.text.isNotEmpty &&
                              model.code.text.isNotEmpty) {
                            if (model.list.data!.datalist.any(
                                    (element) =>
                                element.member_code == model.code.text.toString())) {
                              model.submit().then((_)=>loadData());
                              model.attendees();
                            } else {
                              Utilis.toastmessage('Your Employee Code is Invalid');
                            }
                          } else {
                            Utilis.toastmessage('Please Enter all Fields');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
