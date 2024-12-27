class Member {
  final String memberDesignation;
  final String memberName;
   String tableNo;
   String roomNo;
  final String image;
  final String hotel_of_stay;
  final String mobile;
  final String branch;
  final String member_code;

  Member({
    required this.memberDesignation,
    required this.memberName,
    required this.tableNo,
    required this.image,
    required this.roomNo,
    required this.hotel_of_stay,
     required this.mobile,
    required this.branch,
    required this.member_code
  });

  // Factory method to create an instance from a JSON object
  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      memberDesignation: json['member_designation'],
      memberName: json['member_name'],
      tableNo: json['table_no'].toString(),
        image:json['image'],
      roomNo: json['room_no'].toString() ,
        hotel_of_stay:json['hotel_of_stay'] ?? '',
        mobile:json['mobile'] ?? '',
        branch:json['branch'] ?? '', member_code: json['member_code'],

    );
  }

  // Method to convert an instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'member_designation': memberDesignation,
      'member_name': memberName,
      'table_no': tableNo,
      'image':image,
      'room_no':roomNo,
      'hotel_of_stay':hotel_of_stay,
      'mobile':mobile,
      'branch':branch,
      'member_code':member_code
    };
  }
}

class MemberList {
  final List<Member> datalist;

  MemberList({required this.datalist});

  factory MemberList.fromJson(Map<String, dynamic> json) {
    var list = json['Datalist'] as List;
    List<Member> memberList = list.map((i) => Member.fromJson(i)).toList();

    return MemberList(datalist: memberList);
  }

  Map<String, dynamic> toJson() {
    return {
      'Datalist': datalist.map((member) => member.toJson()).toList(),
    };
  }
}
