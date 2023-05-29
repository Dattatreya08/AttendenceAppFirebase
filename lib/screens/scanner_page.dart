import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:soham_academy/models/stu_data.dart';
import 'package:soham_academy/screens/display_student_info.dart';
import 'package:soham_academy/screens/reverified.dart';
import 'package:soham_academy/services/remote_services.dart';

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
        // Column(
        //   children: <Widget>[
        //     Expanded(flex: 4, child: _buildQrView(context)),
        //     Expanded(
        //       flex: 1,
        //       child: FittedBox(
        //         fit: BoxFit.contain,
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           children: <Widget>[
        //             // if (result != null)
        //             //   // Text(
        //             //   //     'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
        //             //   Padding(
        //             //     padding: const EdgeInsets.all(20),
        //             //     child: Text(lisFromString(result!.code)[0]),
        //             //   )
        //             // else
        //             //   const Text('Scan a code'),
        //
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               children: <Widget>[
        //                 Container(
        //                   margin: const EdgeInsets.all(8),
        //                   child: ElevatedButton(
        //                       onPressed: () async {
        //                         await controller?.toggleFlash();
        //                         setState(() {});
        //                       },
        //                       child: FutureBuilder(
        //                         future: controller?.getFlashStatus(),
        //                         builder: (context, snapshot) {
        //                           return Text('Flash: ${snapshot.data}');
        //                         },
        //                       )),
        //                 ),
        //                 Container(
        //                   margin: const EdgeInsets.all(8),
        //                   child: ElevatedButton(
        //                       onPressed: () async {
        //                         await controller?.flipCamera();
        //                         setState(() {});
        //                       },
        //                       child: FutureBuilder(
        //                         future: controller?.getCameraInfo(),
        //                         builder: (context, snapshot) {
        //                           if (snapshot.data != null) {
        //                             return Text(
        //                                 'Camera facing ${describeEnum(snapshot.data!)}');
        //                           } else {
        //                             return const Text('loading');
        //                           }
        //                         },
        //                       )),
        //                 )
        //               ],
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               children: <Widget>[
        //                 Container(
        //                   margin: const EdgeInsets.all(8),
        //                   child: ElevatedButton(
        //                     onPressed: () async {
        //                       await controller?.pauseCamera();
        //                     },
        //                     child: const Text('pause',
        //                         style: TextStyle(fontSize: 20)),
        //                   ),
        //                 ),
        //                 Container(
        //                   margin: const EdgeInsets.all(8),
        //                   child: ElevatedButton(
        //                     onPressed: () async {
        //                       await controller?.resumeCamera();
        //                     },
        //                     child: const Text('resume',
        //                         style: TextStyle(fontSize: 20)),
        //                   ),
        //                 )
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
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
      setState(() async {
        result = await scanData;
        debugPrint(
            "---->${studentInfoList[int.parse(lisFromString(result!.code)[0])].absentPresent}");
        if (studentInfoList[int.parse(lisFromString(result!.code)[0]) - 1]
                .absentPresent ==
            "0") {
          updateAbsentPresent(await lisFromString(result!.code)[0], "1");
          controller?.pauseCamera();
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return DisplayInfo(lisFromString(result!.code)[0],
                lisFromString(result!.code)![1]);
          })).then((value) async {
            await controller?.resumeCamera();
          });
        } else if (studentInfoList[
                    int.parse(lisFromString(result!.code)[0]) - 1]
                .absentPresent ==
            "1") {
          controller?.pauseCamera();
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return Reverified(lisFromString(result!.code)[0],
                lisFromString(result!.code)![1]);
          })).then((value) async {
            await controller?.resumeCamera();
          });
        }
        ;
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

  void updateAbsentPresent(String studentId, String newAbsentPresentValue) {
    ApiClient apiClient = ApiClient();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> requestBody = {
      'id': studentId,
      'absentPresent': newAbsentPresentValue,
    };

    apiClient
        .put('/mobile_connection.php/event/schools', headers, requestBody)
        .then((response) {
      print('Update successful. Response: $response');
      // print(jsonDecode(result?.code));
    }).catchError((error) {
      print('Error occurred during update: $error');
    });
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
}
