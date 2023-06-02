import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  final String participantID;
  ConfirmationPage({required this.participantID});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetToDisplay(),
    );
  }
  Widget widgetToDisplay(){
    return FutureBuilder<ParticipantData>(
      future: fetchParticipantData(participantID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          debugPrint("--->${snapshot.error}");
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          return Container(
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
                      height: 30,
                    ),
                    Text(
                      "${snapshot.data!.schoolName}".toUpperCase(),
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("${snapshot.data!.name}",
                        style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    Text("Class ${snapshot.data!.className.toString()}",
                        style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
                    Text("Gender ${snapshot.data!.gender}",
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
                                8), // Optional: Add border radius
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
        } else {
          return Center(
            child: Text('No data available'),
          );
        }
      },
    );
  }

  Future<ParticipantData> fetchParticipantData(String participantID) async {
    DocumentSnapshot participantSnapshot = await FirebaseFirestore.instance
        .collection('participant')
        .doc(participantID)
        .get();

    if (participantSnapshot.exists) {
      Map<String, dynamic> data =
          participantSnapshot.data() as Map<String, dynamic>;
      return ParticipantData(
        schoolName: data['schoolName'],
        name: data['name'],
        className: data['class'],
        gender: data['gender'],
        arrived: data['arrived'],
        mobile: data['mobile'],
        eventID: data['eventId'],
        participantID: data['participantId'],
      );
    } else {
      throw Exception('Participant not found');
    }
  }
}

class ParticipantData {
  final String schoolName;
  final String name;
  final int className;
  final String gender;
  final int arrived;
  final int mobile;
  final String eventID;
  final String participantID;

  ParticipantData({
    required this.schoolName,
    required this.name,
    required this.className,
    required this.gender,
    required this.arrived,
    required this.mobile,
    required this.eventID,
    required this.participantID,
  });
}
