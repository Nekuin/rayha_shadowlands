import 'package:flutter/material.dart';
import 'package:rayha_shadowlands/raiders/raider.dart';

class Raiders extends StatelessWidget {
  Raiders(this.raiders, {Key key}) : super(key: key);

  final List raiders;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            child: ListView.builder(
                itemCount: raiders.length,
                itemBuilder: (context, index) {
                  var raider = raiders[index];
                  return Raider(
                      raider["name"], raider["class"], raider["spec"]);
                }),
          ),
        ),
        RaisedButton(
          color: Color(0xFF12293b),
          onPressed: () {
            print("enlist");
            Navigator.pushNamed(context, "/enlist");
          },
          child: Text(
            "Enlist",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
