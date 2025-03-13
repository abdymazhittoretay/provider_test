import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider_test/models/comment.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Comment>> fetchData() async {
    var response = await http.get(
      Uri.https("jsonplaceholder.typicode.com", "/comments"),
    );
    if (response.statusCode == 200) {
      return commentFromJson(response.body);
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var comments = snapshot.data;
            return ListView.builder(
              itemCount: comments!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(comments[index].body),
                  subtitle: Text(comments[index].email),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
