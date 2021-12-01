import 'package:http_error_handling/models/album.dart';
import 'package:http_error_handling/models/user.dart';

abstract class Repository {
  Future<List<User>> getUsers();
  // https://jsonplaceholder.typicode.com/albums?userId=2
  // make model

  Future<List<Album>> getAlbums(int userId);
}
