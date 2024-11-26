import 'package:flutter/material.dart';
import 'package:rayha_shadowlands/raiders/raiders.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'raiders/roles.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key key}) : super(key: key);

  final String readRaiders = """
    query ReadRaiders {
      raiders {
        name
        class
        spec
      }
    }
    """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Raid roster"),
            bottom: TabBar(
              tabs: [Tab(text: "Raiders"), Tab(text: "Roles")],
            ),
          ),
          body: Query(
            options:
                QueryOptions(documentNode: gql(readRaiders), pollInterval: 5),
            builder: (result, {fetchMore, refetch}) {
              if (result.hasException) {
                return Text(result.exception.toString());
              }
              if (result.loading) {
                return Text("Loading...");
              }
              List raiders = result.data["raiders"];
              return TabBarView(
                children: [
                  Raiders(raiders),
                  Roles(raiders),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
