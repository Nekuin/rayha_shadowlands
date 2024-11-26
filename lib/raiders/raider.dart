import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import "package:rayha_shadowlands/constants/classcolors.dart";

class Raider extends StatelessWidget {
  const Raider(this.name, this.cls, this.spec, {Key key}) : super(key: key);
  final String name;
  final String cls;
  final String spec;

  @override
  Widget build(BuildContext context) {
    final Classcolors colors = Classcolors();
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Color(colors.classColors[cls]),
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Text(
                this.name.length > 13
                    ? (this.name?.substring(0, 13))
                    : (this.name) ?? "nimi",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Text(
                this.cls ?? "class",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Text(
                this.spec ?? "spec",
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
