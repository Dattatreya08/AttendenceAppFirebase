import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:soham_academy/screens/display_student_info.dart';
import 'package:soham_academy/screens/reverified.dart';
class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var flashIcon = Icons.flash_off_outlined;


  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close_rounded)),
          actions: [
            IconButton(
                onPressed: () async {
                  await controller?.toggleFlash();
                  setState(() {});
                },
                icon: Icon(flashIcon))
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: true,
        body: _buildQrView(context)
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Color.fromARGB(255, 59, 192, 239),
          borderRadius: 20,
          borderLength: 40,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState((){
        result =scanData;
        processScannedData(lisFromString(result!.code)[0],lisFromString(result!.code)[1]);
       });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }



  List<String> lisFromString(st) {
    String trimmedString = st.substring(1, st.length - 1);

    // Remove the single quotes around each element
    List<String> resultList = trimmedString
        .split("', '")
        .map((element) => element.replaceAll("'", ''))
        .toList();

    return resultList;
  }


  void processScannedData(String eventID, String participantID) async {
    // Check if the event ID exists in the 'event' collection
    DocumentSnapshot eventSnapshot = await FirebaseFirestore.instance
        .collection('event')
        .doc(eventID)
        .get();
    // Check if the participant ID exists in the 'participant' collection
    DocumentSnapshot participantSnapshot = await FirebaseFirestore.instance
        .collection('participant')
        .doc(participantID)
        .get();

    if (eventSnapshot.exists && participantSnapshot.exists) {
      // Check if the 'arrived' field in the 'participant' collection is 0
      bool isArrived = (participantSnapshot.data() as Map<String, dynamic>)['arrived'] == 1;
      if (!isArrived) {
        // Update the 'arrived' field to 1
        controller!.pauseCamera();
        await FirebaseFirestore.instance
            .collection('participant')
            .doc(participantID)
            .update({'arrived': 1});

        // Pause the camera and navigate to the next screen

        print("updationSuccessful");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ConfirmationPage(participantID: participantID)),
        ).then((value)async{
           await controller!.resumeCamera();
        });
      } else if(isArrived)  {
        controller!.pauseCamera();
        print("Already Updated");
        // Navigate to the reverified screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Reverified(participantID: participantID,)),
        ).then((value){
           controller!.resumeCamera();
        });
      }
    } else {
      // Print error message for event or participant not found
      controller!.pauseCamera();
      print('Error: Event or participant not found');
    }
  }


}