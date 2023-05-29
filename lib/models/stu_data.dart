import 'dart:convert';

List<StudentData> studentDataFromJson(String str) =>
    List<StudentData>.from(
        json.decode(str).map((x) => StudentData.fromJson(x)));

String studentDataToJson(List<StudentData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentData {
  String schoolName;
  String totalStudents;
  String totalPresent;
  String totalAbsent;

  StudentData({
    required this.schoolName,
    required this.totalStudents,
    required this.totalPresent,
    required this.totalAbsent,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) =>
      StudentData(
        schoolName: json["schoolName"],
        totalStudents: json["total_students"],
        totalPresent: json["total_present"],
        totalAbsent: json["total_absent"],
      );

  Map<String, dynamic> toJson() =>
      {
        "schoolName": schoolName,
        "total_students": totalStudents,
        "total_present": totalPresent,
        "total_absent": totalAbsent,
      };
}


List<StudentInfo> studentInfoFromJson(String str) =>
    List<StudentInfo>.from(
        json.decode(str).map((x) => StudentInfo.fromJson(x)));

String studentInfoToJson(List<StudentInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentInfo {
  String name;
  String studentInfoClass;
  String gender;
  String phoneNumber;
  String absentPresent;

  StudentInfo({
    required this.name,
    required this.studentInfoClass,
    required this.gender,
    required this.phoneNumber,
    required this.absentPresent,
  });

  factory StudentInfo.fromJson(Map<String, dynamic> json) =>
      StudentInfo(
        name: json["name"],
        studentInfoClass: json["class"],
        gender: json["gender"],
        phoneNumber: json["phoneNumber"],
        absentPresent: json["absentPresent"],
      );

  Map<String, dynamic> toJson() =>
      {
        "name": name,
        "class": studentInfoClass,
        "gender": gender,
        "phoneNumber": phoneNumber,
        "absentPresent": absentPresent,
      };
}




List<FinalInfo> finalInfoFromJson(String str) => List<FinalInfo>.from(json.decode(str).map((x) => FinalInfo.fromJson(x)));

String finalInfoToJson(List<FinalInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FinalInfo {
  String name;
  String finalInfoClass;
  String gender;
  String phoneNumber;
  String absentPresent;

  FinalInfo({
    required this.name,
    required this.finalInfoClass,
    required this.gender,
    required this.phoneNumber,
    required this.absentPresent,
  });

  factory FinalInfo.fromJson(Map<String, dynamic> json) => FinalInfo(
    name: json["name"],
    finalInfoClass: json["class"],
    gender: json["gender"],
    phoneNumber: json["phoneNumber"],
    absentPresent: json["absentPresent"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "class": finalInfoClass,
    "gender": gender,
    "phoneNumber": phoneNumber,
    "absentPresent": absentPresent,
  };
}
