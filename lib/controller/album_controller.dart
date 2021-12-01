import 'package:http_error_handling/models/album.dart';
import 'package:http_error_handling/repository/repository.dart';

class AlbumController {
  final Repository _repository;
  AlbumController(this._repository);

  Future<List<Album>> fetchAlbum(int userId) async {
    return _repository.getAlbums(userId);
  }
}
