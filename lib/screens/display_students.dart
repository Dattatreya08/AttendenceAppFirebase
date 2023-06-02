import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:soham_academy/models/stu_data.dart';
// import 'package:soham_academy/services/remote_services.dart';
//
// class StudentsDisplay extends StatefulWidget {
//   // const StudentsDisplay({Key? key}) : super(key: key);
//   String _scName = "";
//
//   StudentsDisplay(schoolName) {
//     this._scName = schoolName;
//   }
//
//   @override
//   State<StudentsDisplay> createState() => _StudentsDisplayState(_scName);
// }
//
// class _StudentsDisplayState extends State<StudentsDisplay> {
//   String _schName = '';
//
//   _StudentsDisplayState(schName) {
//     this._schName = schName;
//   }
//
//   ApiClient apiClient = ApiClient();
//   List<StudentInfo> studentInfoList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchStudentInfo();
//   }
//
//   Future<void> fetchStudentInfo() async {
//     try {
//       String path =
//           '/mobile_connection.php?action=user_data&schName=$_schName'; // Replace with your PHP page path
//       List<StudentInfo> result = await apiClient.getStudentInfo(path);
//       setState(() {
//         studentInfoList = result;
//       });
//     } catch (e) {
//       // Handle the error
//       print('Error: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: new Text(
//             _schName,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: studentInfoList == null || studentInfoList!.isEmpty
//           ? Container(
//               child: Center(
//               child: CircularProgressIndicator(),
//             ))
//           : ListView.separated(
//               separatorBuilder: (BuildContext context, int index) =>
//                   const Divider(
//                 height: 3.0,
//                 color: Colors.black,
//               ),
//               itemCount: studentInfoList!.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(studentInfoList[index].name),
//                   subtitle: Text(studentInfoList[index].phoneNumber),
//                   trailing: studentInfoList[index].absentPresent == "1"
//                       ? presentIdentifier()
//                       : absentIdentifier(),
//                   onTap: () {},
//                 );
//               },
//             ),
//     );
//   }
//
//   Widget presentIdentifier() {
//     return CircleAvatar(
//       backgroundColor: Colors.green,
//       radius: 15,
//     );
//   }
//
//   Widget absentIdentifier() {
//     return CircleAvatar(
//       backgroundColor: Colors.red,
//       radius: 15,
//     );
//   }
// }



class EventParticipantsListPage extends StatefulWidget {
  final String schoolName;

  EventParticipantsListPage(this.schoolName);

  @override
  _EventParticipantsListPageState createState() =>
      _EventParticipantsListPageState();
}

class _EventParticipantsListPageState extends State<EventParticipantsListPage> {
  Stream<QuerySnapshot>? _participantsStream;

  @override
  void initState() {
    super.initState();
    _participantsStream = FirebaseFirestore.instance
        .collection('participant')
        .where('schoolName', isEqualTo: widget.schoolName)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.schoolName),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _participantsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final participants = snapshot.data!.docs;

            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(color: Colors.black),
              itemCount: participants.length,
              itemBuilder: (context, index) {
                final participant = participants[index];
                final participantName = participant['name'];
                final participantClass = participant['class'];
                final participantGender = participant['gender'];
                final participantArrived = participant['arrived'];
                final participantMobile = participant['mobile'];

                return ListTile(
                  title: Text(participantName),
                  subtitle: Text("$participantClass  $participantGender"),
                  trailing: participantArrived == 1
                      ? presentIdentifier()
                      : absentIdentifier(),
                  onTap: () {},
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget presentIdentifier() {
    return CircleAvatar(
      backgroundColor: Colors.green,
      radius: 15,
    );
  }

  Widget absentIdentifier() {
    return CircleAvatar(
      backgroundColor: Colors.red,
      radius: 15,
    );
  }
}


