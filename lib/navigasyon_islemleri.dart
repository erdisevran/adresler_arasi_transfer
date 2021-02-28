import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:transfer/form_islemleri.dart';

class NavigasyonIslemleri extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transfer Çalışması"),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Container(
          color: Colors.amberAccent.shade100,
          child: RaisedButton(
            onPressed: () {
              //Navigator.pushNamed(context, "/formIslemleri");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FormIslemleri()));
            },
            color: Colors.white,
            //elevation: 5,
            child: Text(
              "Giriş",
            ),
          ),
        ),
      ),
    );
  }
}
