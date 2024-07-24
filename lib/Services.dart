import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uvento/models/Notification_model.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'database3.db'),
      onCreate: (db, version) async {
         db.execute(
          'CREATE TABLE votes('
              'award_id TEXT,'
              'nominee_id TEXT,'
              'participant_token TEXT)',
        );
         db.execute(
          'CREATE TABLE feedbacks(''code TEXT,''rating TEXT,''feedback TEXT)',
        );
         db.execute(
           'CREATE TABLE notification('
               'Id INTEGER PRIMARY KEY,'
               'title TEXT,'
               'body TEXT,'
               'timestamp TEXT'
               ')',
         );
      },
      version: 1,
    );
  }


  Future<void> insertVote(String awardId, String nomineeId, String participantToken) async {
    final Database db = await database;

    // Check if the participant has already voted for this award
    List<Map<String, dynamic>> result = await db.query(
      'votes',
      where: 'award_id = ? AND participant_token = ?',
      whereArgs: [awardId, participantToken],
    );

    if (result.isEmpty) {
      // Participant hasn't voted yet for this award, insert the vote
      await db.insert(
        'votes',
        {
          'award_id': awardId,
          'nominee_id': nomineeId,
          'participant_token': participantToken,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore, // Ignore if entry already exists
      );
      print('Vote saved successfully: awardId=$awardId, nomineeId=$nomineeId, participantToken=$participantToken');

    } else {
      // Participant has already voted for this award
      throw 'Participant has already voted for this award!';
    }
  }



  Future<bool> hasVoted(String awardId, String nomineeId, String participantToken) async {
    final Database db = await database;

    // Check if the participant has already voted for this award and nominee
    List<Map<String, dynamic>> result = await db.query(
      'votes',
      where: 'award_id = ? AND nominee_id = ? AND participant_token = ?',
      whereArgs: [awardId, nomineeId, participantToken],
    );

    return result.isNotEmpty;
  }


  Future<void> insertFeedback(String code, String feedback, String rating) async {
    try {
      final Database db = await database;
      await db.insert(
        'feedbacks',
        {
          'code': code,
          'rating': rating,
          'feedback': feedback,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      print('Feedback saved successfully: code=$code, rating=$rating, feedback=$feedback');
    } catch (e) {
      print('Error inserting feedback: ${e.toString()}');
      throw Exception('Error inserting feedback: ${e.toString()}'); // Optional: Rethrow the exception for higher level handling
    }
  }

  Future<bool> hasFeedbacks() async {
    final Database db = await database;

    List<Map<String, dynamic>> result = await db.query('feedbacks');
    print(result);
    return result.isNotEmpty;
  }


  Future<void> insertnotification(Notification_model model) async {
    try {
      final Database db = await database;

      db.insert('notification', model.toJson());
      print("insert data sucessfully");
    }
    catch(e){
      throw Exception();
    }
}

Future<List<Notification_model>> getnotification() async {
  try {
    final Database db = await database;
  final List<Map<String, dynamic>> list = await db.query('notification');
  List<Notification_model> model= List.generate(list.length, (i) {
    return Notification_model.fromJson(list[i]);
  });

    return model;

  }
  catch(e){
    return
    throw Exception();
  }
}

}



