class Datalist {
  String awardId;
  String awardTitle;
  String region;
  String date;
  String award_image;
  List<Nominee> nominees;

  Datalist({
    required this.awardId,
    required this.awardTitle,
    required this.region,
    required this.date,
    required this.award_image,
    required this.nominees,
  });

  factory Datalist.fromJson(Map<String, dynamic> json) {
    return Datalist(
      award_image:json['award_image'],
      awardId: json['award_id'],
      awardTitle: json['award_title'],
      region: json['region'],
      date: json['date'],
      nominees: (json['nominees'] as List)
          .map((nominee) => Nominee.fromJson(nominee))
          .toList(),
    );
  }
Map<String, dynamic> toMap(){
    return {
      'award_id': awardId,
      'award_title': awardTitle,
      'region': region,
      'date': date,
      'award_image':award_image
    };
}

  Map<String, dynamic> toJson() {
    return {
      'award_id': awardId,
      'award_title': awardTitle,
      'region': region,
      'date': date,
      'award_image':award_image,
      'nominees': nominees.map((nominee) => nominee.toJson()).toList(),
    };
  }
}

class Nominee {
  String nomineeId;
  String nomineeName;
  String awardId;

  Nominee({
    required this.nomineeId,
    required this.nomineeName,
    required this.awardId,
  });

  factory Nominee.fromJson(Map<String, dynamic> json) {
    return Nominee(
      nomineeId: json['nominee_id'],
      nomineeName: json['nominee_name'],
      awardId: json['award_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nominee_id': nomineeId,
      'nominee_name': nomineeName,
      'award_id': awardId,
    };
  }
  Map<String, dynamic> toMap() {
    return {
      'nominee_id': nomineeId,
      'nominee_name': nomineeName,
      'award_id': awardId,
    };
  }
}

class AwardList {
  List<Datalist> datalist;

  AwardList({required this.datalist});

  factory AwardList.fromJson(Map<String, dynamic> json) {
    return AwardList(datalist: (json['Datalist'] as List).map((data) => Datalist.fromJson(data)).toList(),
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'Datalist': datalist.map((data) => data.toJson()).toList(),
    };
  }
}
class Award {
  final String awardId;
  final String awardTitle;
  final String region;
  final String date;
  final String awardImage;
  List<Nominee> nominees;

  Award({
    required this.awardId,
    required this.awardTitle,
    required this.region,
    required this.date,
    required this.awardImage,
    required this.nominees,
  });

  // Convert a Award object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': awardId,
      'title': awardTitle,
      'region': region,
      'date': date,
      'image': awardImage,
    };
  }

  // Extract a Award object from a Map object
  factory Award.fromMap(Map<String, dynamic> map) {
    return Award(
      awardId: map['id'],
      awardTitle: map['title'],
      region: map['region'],
      date: map['date'],
      awardImage: map['image'],
      nominees: [], // Nominees need to be fetched separately
    );
  }
}
