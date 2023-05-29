import 'package:flutter/material.dart';
import 'package:soham_academy/models/stu_data.dart';
import 'package:soham_academy/services/remote_services.dart';

class Reverified extends StatefulWidget {
  // const DisplayInfo({Key? key}) : super(key: key);
  var _id;
  var _schName;

  Reverified(id, String schName) {
    this._id = id;
    this._schName = schName;
  }

  @override
  State<Reverified> createState() => _ReverifiedState(_id, _schName);
}

class _ReverifiedState extends State<Reverified> {
  var _id;
  var _scName;

  _ReverifiedState(id, scName) {
    this._id = id;
    this._scName = scName;
  }

  ApiClient apiClient = ApiClient();
  List<FinalInfo> studentInfoList = [];

  @override
  void initState() {
    super.initState();
    fetchStudentInfo();
  }

  Future<void> fetchStudentInfo() async {
    try {
      String path =
          '/mobile_connection.php?action=final_info'; // Replace with your PHP page path
      List<FinalInfo> result = await apiClient.getFinalInfo(path);
      setState(() {
        studentInfoList = result;
      });
    } catch (e) {
      // Handle the error
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dataToDisplay(),
    );
  }

  Widget dataToDisplay() {
    return studentInfoList == Null || studentInfoList.isEmpty
        ? Container(
            child: Center(child: CircularProgressIndicator()),
          )
        : Container(
            child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Icon(
                  Icons.verified_sharp,
                  color: Colors.green,
                  size: 100,
                )),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Reverified",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "$_scName".toUpperCase(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.visible,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(studentInfoList[int.parse(_id) - 1].name,
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                Text(studentInfoList[int.parse(_id) - 1].finalInfoClass,
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
                Text(studentInfoList[int.parse(_id) - 1].gender,
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
                SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), // Optional: Add border radius
                      ),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(
                          color: Color.fromARGB(
                              255, 59, 192, 239)), // Hide the button border
                    ),
                  ),
                  child: Text(
                    'OK',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal // Set the text color
                        ),
                  ),
                ),
              ],
            ),
          ));
  }
}
