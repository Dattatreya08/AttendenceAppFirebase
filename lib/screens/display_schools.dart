import 'package:flutter/material.dart';
import 'package:soham_academy/models/stu_data.dart';
import 'package:soham_academy/screens/display_students.dart';
import 'package:soham_academy/services/remote_services.dart';

class DataDisplay extends StatefulWidget {
  const DataDisplay({Key? key}) : super(key: key);

  @override
  State<DataDisplay> createState() => _DataDisplayState();
}

class _DataDisplayState extends State<DataDisplay> {
  List<StudentData>? _studentData = [];
  var schoolName;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    List<StudentData>? data = await API().getStudentData();
    if (data != null) {
      _studentData = data;
    }
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schools'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 59, 192, 239),
      ),
      body: _studentData == null || _studentData!.isEmpty
          ? Container(
              child: Center(
              child: CircularProgressIndicator(),
            ))
          : SafeArea(
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  height: 3.0,
                  color: Colors.black,
                ),
                itemCount: _studentData!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: new Text(
                        _studentData![index].schoolName,
                        style: new TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          child: Text(
                            _studentData![index].totalPresent,
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                          backgroundColor: Colors.lightGreen,
                          radius: 15,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        CircleAvatar(
                          child: Text(
                            _studentData![index].totalAbsent,
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                          backgroundColor: Colors.redAccent,
                          radius: 15,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        CircleAvatar(
                          child: Text(
                            _studentData![index].totalStudents,
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                          backgroundColor: Colors.blueAccent,
                          radius: 15,
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        schoolName = _studentData![index].schoolName;
                      });
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return StudentsDisplay(this.schoolName);
                      }));
                    },
                    tileColor: Colors.black12,
                  );
                },
              ),
            ),
    );
  }
}
