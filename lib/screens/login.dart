import 'package:flutter/material.dart';
import 'package:soham_academy/screens/authentication.dart';
import 'package:soham_academy/screens/scanner_page.dart';
class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  var _minPadding=5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Soham Talent Utsav"),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Padding(
                padding: EdgeInsets.all(_minPadding),
                child: ElevatedButton(child: Text(
                  "Admin Login",
                  style: TextStyle(
                      color: Colors.white,fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return MyHome();
                      }));
                    }
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_minPadding),
                child: ElevatedButton(child: Text(
                  "Scan QR",
                  style: TextStyle(
                      color: Colors.white,fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return QRViewExample();
                      }));
                    }
                ),
              ),
            ],
            ),
          ],
        )
      ),
    );
  }
}
