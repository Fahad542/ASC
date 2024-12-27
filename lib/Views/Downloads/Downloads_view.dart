import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:lottie/lottie.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:uvento/Views/Utilis/App_colors.dart';

import 'Downloads_view_model.dart';

class downloads extends StatefulWidget {
  const downloads({super.key});

  @override
  State<downloads> createState() => _downloadsState();
}

class _downloadsState extends State<downloads> {
  downloadViewModel model = downloadViewModel();

  Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.status;
    if (status.isGranted) {
      return true;
    } else {
      final result = await Permission.storage.request();
      return result.isGranted;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Downloads', style: TextStyle(color: AppColors.yellow)),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<downloadViewModel>(
        create: (BuildContext context) => model,
        child: Consumer<downloadViewModel>(
          builder: (context, value, _) {
            return StreamBuilder(
              stream: model.getdata,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColors.whiteColor),
                  );
                }
                if (!snapshot.hasData || snapshot.data?.data() == null) {
                  return Center(
                    child: Text('No data!', style: TextStyle(color: AppColors.yellow)),
                  );
                }
                Map<String, dynamic>? data = snapshot.data!.data();
                List<dynamic> datalist = data?.values.toList() ?? [];

                return Column(
                  children: [
                    Lottie.asset('assets/pdf.json', height: 100, width: 100),
                    Expanded(
                      child: ListView.builder(
                        itemCount: datalist.length,
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.secondaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    datalist[index]['filename'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  InkWell(
                                    onTap: () async {
                                      try {
                                        // Get the URL of the file
                                        String url = datalist[index]['url'];
                                        String filename = datalist[index]['filename'];

                                        // Get the external storage directory
                                        String directory = await ExternalPath.getExternalStoragePublicDirectory(
                                          ExternalPath.DIRECTORY_DOWNLOADS,
                                        );

                                        // Create the full path to save the file
                                        String fullPath = '$directory/$filename';

                                        // Use Dio to download the file
                                        Dio dio = Dio();
                                        await dio.download(url, fullPath);

                                        // Notify user of successful download
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('File downloaded to $fullPath')),
                                        );

                                        // Open the downloaded file
                                        final result = await OpenFile.open(fullPath);
                                        if (result.type != ResultType.done) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Error opening file: ${result.message}')),
                                          );
                                        }
                                      } catch (e) {
                                        // Handle errors
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Error downloading file: $e')),
                                        );
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              "PDF",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              datalist[index]['url'],
                                              style: TextStyle(color: AppColors.secondaryColor),
                                            ),
                                          ),
                                          Icon(Icons.arrow_forward, size: 16)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
