import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("./assets/entry.PNG", height: 200, width: 200),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                primary: Color(0xFF6cb4b1),
                fixedSize: Size(100.0, 20.0)
                ),
                child:Text("Login", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                onPressed: () {
                Navigator.pushNamed(context, "/todo");
                },
              ),
            ],
          ),
        ),
   );
  }
}