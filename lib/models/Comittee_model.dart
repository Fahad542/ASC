import 'package:flutter/foundation.dart';

class CommitteeMember {
  final String image;
  final String memberDesignation;
  final String memberName;
  final String mobile;

  CommitteeMember({
    required this.image,
    required this.memberDesignation,
    required this.memberName,
    required this.mobile,
  });

  factory CommitteeMember.fromJson(Map<String, dynamic> json) {
    return CommitteeMember(
      image: json['image'] as String,
      memberDesignation: json['member_designation'] as String,
      memberName: json['member_name'] as String,
      mobile: json['mobile'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'member_designation': memberDesignation,
      'member_name': memberName,
      'mobile': mobile,
    };
  }
}

class CommitteeData {
  final List<CommitteeMember> datalist;

  CommitteeData({required this.datalist});

  factory CommitteeData.fromJson(Map<String, dynamic> json) {
    var list = json['Datalist'] as List;
    List<CommitteeMember> datalist = list.map((i) => CommitteeMember.fromJson(i)).toList();

    return CommitteeData(
      datalist: datalist,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Datalist': datalist.map((i) => i.toJson()).toList(),
    };
  }
}
