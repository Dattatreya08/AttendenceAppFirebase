import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:soham_academy/models/stu_data.dart';
import 'package:soham_academy/services/constants.dart';

class API {
  Future<List<StudentData>?> getStudentData() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndPoint);
      var response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<StudentData> _model = studentDataFromJson(response.body);
        return _model;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class ApiClient {
  static var baseUrl = ApiConstants.baseUrl;

  Future<List<StudentInfo>> getStudentInfo(String path) async {
    var url = Uri.parse('$baseUrl$path');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => StudentInfo.fromJson(json)).toList();
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<List<FinalInfo>> getFinalInfo(String path) async {
    var url = Uri.parse('$baseUrl$path');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => FinalInfo.fromJson(json)).toList();
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<String> post(
      String path, Map<String, String> headers, dynamic body) async {
    var url = Uri.parse('$baseUrl$path');

    var response =
        await http.post(url, headers: headers, body: studentInfoToJson(body));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<String> put(
      String path, Map<String, String> headers, dynamic body) async {
    var url = Uri.parse('$baseUrl$path');

    var response =
        await http.put(url, headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<String> patch(
      String path, Map<String, String> headers, dynamic body) async {
    var url = Uri.parse('$baseUrl$path');

    var response =
        await http.patch(url, headers: headers, body: studentInfoToJson(body));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<void> delete(String path) async {
    var url = Uri.parse('$baseUrl$path');

    var response = await http.delete(url);
    if (response.statusCode == 200) {
      print('Request successful. Data deleted.');
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }
}
