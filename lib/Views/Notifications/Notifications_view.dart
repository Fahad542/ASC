import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uvento/Views/Utilis/App_colors.dart';
import 'package:uvento/models/Notification_model.dart';
import '../../Services.dart';


class notifications extends StatefulWidget {
  const notifications({super.key});

  @override
  State<notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<notifications> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Notification_model> data = [];
  List<bool> expandedList = []; // Track which notifications are expanded

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      var model = await _databaseHelper.getnotification();
      model.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
      setState(() {
        data = model;
        expandedList = List<bool>.filled(data.length, false); // Initialize expanded state
        print('data: $data');
      });
    } catch (e) {
      // Handle error
      print('Error fetching data: $e');
    }
  }

  void _toggleExpand(int index) {
    setState(() {
      expandedList[index] = !expandedList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: TextStyle(color: AppColors.yellow)),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: data.length,
physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, index) {
            Notification_model noti = data[index];
            String formattedDate = DateFormat.yMMMd().format(noti.timestamp!); // E.g., 'Jul 23, 2024'
            String formattedTime = DateFormat.jm().format(noti.timestamp!);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () => _toggleExpand(index), // Toggle expansion on tap
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.notifications, color: AppColors.yellow),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              noti.title ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.whiteColor,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis, // Handle overflow
                            ),
                            SizedBox(height: 5),
                            // Body
                            AnimatedSize(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              child: ConstrainedBox(
                                constraints: expandedList[index]
                                    ? BoxConstraints()
                                    : BoxConstraints(maxHeight: 40), // Adjust height to fit your needs
                                child: Text(
                                  noti.body ?? '',
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 12,
                                  ),
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            // Formatted Time
                            Text(
                              formattedTime,
                              style: TextStyle(
                                color: AppColors.yellow,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      // Formatted Date
                      Text(
                        formattedDate,
                        style: TextStyle(
                          color: AppColors.yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
