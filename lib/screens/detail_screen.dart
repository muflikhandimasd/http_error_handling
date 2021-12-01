import 'package:flutter/material.dart';
import 'package:http_error_handling/controller/album_controller.dart';
import 'package:http_error_handling/models/album.dart';
import 'package:http_error_handling/repository/json_placeholder_repository.dart';

// ignore: must_be_immutable
class DetailScreen extends StatelessWidget {
  static const routeName = '/detail';
  var controller = AlbumController(JsonPlaceHolderRepository());
  DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get user id
    final userId = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Screen'),
          centerTitle: true,
        ),
        // add type
        body: FutureBuilder<List<Album>>(
            future: controller.fetchAlbum(userId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Container(
                    width: 320,
                    padding: const EdgeInsets.all(40),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    color: Colors.orange[100],
                    child: Text(
                      snapshot.error.toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var albums = snapshot.data!;
              return GridView.builder(
                  itemCount: albums.length,
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 1),
                  itemBuilder: (context, index) {
                    // temp data
                    // https://i.picsum.photos/id/1002/4312/2868.jpg?hmac=5LlLE-NY9oMnmIQp7ms6IfdvSUQOzP_O3DPMWmyNxwo

                    return Container(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://picsum.photos/id/${albums[index].id}/200/300',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  });
            }));
  }
}
