import 'package:flutter/material.dart';

import 'raider.dart';

class RoleList extends StatelessWidget {
  const RoleList(this.raiders, {Key key}) : super(key: key);

  final List raiders;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // disable scrolling if there is "insufficient content",
      // which sort is always the case since this ListView is
      // nested inside another ListView
      primary: false,
      shrinkWrap: true,
      itemCount: raiders.length,
      itemBuilder: (context, index) {
        var raider = raiders[index];
        return Raider(raider["name"], raider["class"], raider["spec"]);
      },
    );
  }
}
