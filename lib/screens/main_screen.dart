import 'package:flutter/material.dart';
import 'package:http_error_handling/controller/user_controller.dart';
import 'package:http_error_handling/models/user.dart';
import 'package:http_error_handling/repository/json_placeholder_repository.dart';
import 'package:http_error_handling/screens/detail_screen.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  static const routeName = '/';
  var controller = UserController(JsonPlaceHolderRepository());

  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('HTTP SAMPLE CODE')),
      ),
      body: FutureBuilder<List<User>>(
        future: controller.fetchUserList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              var user = snapshot.data?[index] as User;
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, DetailScreen.routeName,
                      arguments: user.id);
                },
                child: ListTile(
                  leading: Text(user.id.toString()),
                  title: Text(user.name.toString()),
                  subtitle: Text(user.name.toString()),
                  trailing: Text(user.website.toString()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
