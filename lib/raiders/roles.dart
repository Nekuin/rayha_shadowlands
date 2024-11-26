import 'package:flutter/material.dart';
import 'package:rayha_shadowlands/constants/class_spec.dart';

import 'raider.dart';
import 'role_list.dart';

class Roles extends StatelessWidget {
  List<dynamic> dps = [];
  List<dynamic> tank = [];
  List<dynamic> healer = [];
  ClassSpec classSpec = ClassSpec();
  Roles(List raiders) {
    raiders.forEach((element) {
      String spec = element['spec'];
      if (classSpec.roles["DPS"].contains(spec)) {
        dps.add(element);
      } else if (classSpec.roles["Healer"].contains(spec)) {
        healer.add(element);
      } else if (classSpec.roles["Tank"].contains(spec)) {
        tank.add(element);
      } else {
        print("Unknown spec $spec");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Tank:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          RoleList(tank),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Healer:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          RoleList(healer),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "DPS:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          RoleList(dps),
        ],
      ),
    ]);
  }
}
