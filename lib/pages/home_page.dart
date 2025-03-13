import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:provider_test/models/comment.dart';
import 'package:provider_test/models/favorite_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Comment>> dataFuture;

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
  void initState() {
    super.initState();
    dataFuture = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comments")),
      body: FutureBuilder(
        future: dataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var comments = snapshot.data;
            return ListView.builder(
              itemCount: comments!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    comments[index].body,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(comments[index].email),
                  trailing: IconButton(
                    onPressed: () {
                      Provider.of<FavoriteModel>(
                        context,
                        listen: false,
                      ).addRemove(comments[index]);
                    },
                    icon: Icon(
                      Provider.of<FavoriteModel>(
                            context,
                          ).favorites.contains(comments[index])
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
