import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:graphql_flutter/graphql_flutter.dart';

import 'constants/class_spec.dart';

class Enlist extends StatefulWidget {
  Enlist({Key key}) : super(key: key);

  @override
  _EnlistState createState() => _EnlistState();
}

class _EnlistState extends State<Enlist> {
  final ClassSpec classSpec = ClassSpec();
  // initialize selected items, apparently I can't reference the classSpec
  // instance here yet, so I'll have to create a new one for each of these.
  String selectedClass = ClassSpec().classes[0];
  List<String> currentSpecs = ClassSpec().spec["Paladin"];
  String selectedSpec = ClassSpec().spec["Paladin"][0];
  String characterName = "";

  // mutation query
  final String addRaider = """
  mutation AddRaider(\$name: String!, \$class: String!, \$spec: String!) {
    addRaider(name: \$name, class: \$class, spec: \$spec) {
      name
      class
      spec
    }
  }
  """;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // unfocus any input when tapping away from the inputs
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Enlist")),
        key: scaffoldKey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        maxLines: 1,
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            characterName = value;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter a character name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Räystö",
                            labelText: "Character name",
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white30)),
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Class",
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        value: selectedClass,
                        isExpanded: true,
                        style: TextStyle(color: Colors.white),
                        items: classSpec.classes.map((String item) {
                          return DropdownMenuItem<String>(
                            child: Text(item),
                            value: item,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            print("selecting item $value");
                            selectedClass = value;
                            currentSpecs = classSpec.spec[value];
                            selectedSpec = classSpec.spec[value][0];
                          });
                        },
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Spec",
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        value: selectedSpec,
                        isExpanded: true,
                        style: TextStyle(color: Colors.white),
                        items: currentSpecs.map((String item) {
                          return DropdownMenuItem<String>(
                            child: Text(item),
                            value: item,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            print("selecting item $value");
                            selectedSpec = value;
                          });
                        },
                      ),
                      Mutation(
                        options: MutationOptions(
                          documentNode: gql(addRaider),
                          onCompleted: (dynamic data) {
                            developer.log("Enlisted response: $data");
                            Navigator.of(context).pop();
                          },
                        ),
                        builder: (runMutation, result) {
                          return RaisedButton(
                            color: Color(0xFF12293b),
                            child: Text("Submit"),
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                developer.log(
                                    "Name: $characterName, class: $selectedClass, spec: $selectedSpec",
                                    name: "Enlist submit");
                                scaffoldKey.currentState.showSnackBar(
                                    SnackBar(content: Text("Enlisting...")));
                                runMutation({
                                  "name": characterName,
                                  "class": selectedClass,
                                  "spec": selectedSpec,
                                });
                              } else {
                                developer.log("validation error",
                                    name: "Enlist submit");
                              }
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
