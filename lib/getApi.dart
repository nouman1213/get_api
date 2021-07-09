import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class api extends StatefulWidget {
  @override
  _apiState createState() => _apiState();
}

class _apiState extends State<api> {
  getUser() async {
    var users = [];
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    print(jsonData);

    for (var i in jsonData) {
      UserModel user =
          UserModel(i['name'], i['username'], i['address']['street']);
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: FutureBuilder(
        future: getUser(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Text("Nothing in api"),
            );
          } else
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(snapshot.data[i].name),
                    subtitle: Text(snapshot.data[i].username),
                    trailing: Text(snapshot.data[i].address),
                  );
                });
        },
      )),
    );
  }
}

class UserModel {
  var name;
  var username;
  var address;
  UserModel(this.name, this.username, this.address);
}
