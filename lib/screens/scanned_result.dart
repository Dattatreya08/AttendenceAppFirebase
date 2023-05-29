import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class DataPage extends StatefulWidget {
//   @override
//   _DataPageState createState() {
//     return _DataPageState();
//   }
// }
//
// class _DataPageState extends State<DataPage> {
//   List<String> items=['1','2','3','4','5','6','7'];
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(),
//       extendBodyBehindAppBar: true,
//       body: Container(
//         alignment: AlignmentDirectional.center,
//         child: SafeArea(
//           child: ListView.builder(
//               itemBuilder: (BuildContext context,int index){
//             return ListTile(
//               leading: Icon(Icons.abc),
//               title: Text("Hello"),
//               subtitle:Text("$index"),
//               textColor: Colors.red,
//
//             );
//           },
//             itemCount: 100,
//             scrollDirection: Axis.vertical,
//           ),
//         )
//
//       ),
//     );
//   }
// }

// class DropDown extends StatefulWidget {
//   @override
//   State<DropDown> createState() {
//     // TODO: implement createState
//     return _DropDownState();
//   }
// }
//
// class _DropDownState extends State<DropDown> {
//   var _items = ['1', '2', '3', '4', '5'];
//   var _currentValueSelected = '1';
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Container(
//       alignment: AlignmentDirectional.c,
//       margin: EdgeInsets.all(5.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           DropdownButton<String>(
//             items: _items.map((String dStrItm) {
//               return DropdownMenuItem<String>(
//                 value: dStrItm,
//                 child: Text(dStrItm),
//               );
//             }).toList(),
//             onChanged: (newValueSelected) {
//               setState(() {
//                 this._currentValueSelected = newValueSelected!;
//               });
//             },
//             value: _currentValueSelected,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// void getData() async {
//   String url = 'http://localhost/mobile_connection.php';
//   http.Response response = await http.get(url as Uri);
//   String data = response.body;
//   print(data);
// }
