import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utilis/App_colors.dart';
import '../../Utilis/Widgets/GeneralAppbar.dart';
import '../../Utilis/Widgets/Result_widget.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // or your data source


class Result extends StatefulWidget {
  final List<dynamic> nominees;
  final String title;
  const Result({super.key, required this.nominees, required this.title});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  late List<dynamic> sortedNominees;
  late int maxVotes;

  @override
  void initState() {
    super.initState();
    _sortNomineesAndFindMaxVotes();
  }

  void _sortNomineesAndFindMaxVotes() {
    sortedNominees = widget.nominees;
    sortedNominees.sort((a, b) => b['votes'].compareTo(a['votes']));
    maxVotes = sortedNominees.first['votes']; // Ensure it's a string
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: widget.title),
          Expanded(
            child: ListView.builder(
              itemCount: sortedNominees.length,
              itemBuilder: (context, index) {
                var nomineeData = sortedNominees[index];
                return ResultWidget(
                  title: nomineeData['nominee_name'],
                  voteNumber: nomineeData['votes'].toString(), // Ensure it's a string
                  isWinner: maxVotes == nomineeData['votes'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class ResultWidget extends StatefulWidget {
  final String title;
  final String voteNumber;
  final bool isWinner;

  ResultWidget({
    required this.title,
    required this.voteNumber,
    required this.isWinner,
  });

  @override
  State<ResultWidget> createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Row(
                children: [
                  Text(
                    "Nominee: ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: AppColors.yellow,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.voteNumber,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              if (widget.isWinner)
                Column(
                  children: [



                    Image.asset(
                      'assets/1.png',
                      height: 40,
                      width: 50,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}