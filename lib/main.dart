import 'package:flutter/material.dart';
import 'package:rayha_shadowlands/homepage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'enlist.dart';

//flutter emulators --launch Pixel_2_API_28
void main() {
  final HttpLink httpLink =
      HttpLink(uri: "https://apollo.xn--ryh-qlac.com/graphql");
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: InMemoryCache(),
    ),
  );

  runApp(MyApp(client));
}

class MyApp extends StatelessWidget {
  const MyApp(this.client);
  final ValueNotifier<GraphQLClient> client;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            appBarTheme: AppBarTheme(color: Color(0xFF060e14)),
            scaffoldBackgroundColor: Color(0xFF0b1924),
            // e.g. dropdown menu background color
            canvasColor: Color(0xFF0b1924),
            accentColor: Colors.white,
            buttonTheme: ButtonThemeData(
                buttonColor: Color(0xFF060e14),
                textTheme: ButtonTextTheme.accent),
            textTheme: TextTheme(
              bodyText2: TextStyle(
                color: Colors.white,
              ),
              button: TextStyle(color: Colors.white),
            ),
            // This makes the visual density adapt to the platform that you run
            // the app on. For desktop platforms, the controls will be smaller and
            // closer together (more dense) than on mobile platforms.
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: "/",
          routes: {
            "/": (context) => Homepage(),
            "/enlist": (context) => Enlist(),
          }),
    );
  }
}
