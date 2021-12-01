import 'dart:convert';
import 'dart:io';
import 'package:http_error_handling/models/album.dart';
import 'package:http_error_handling/models/user.dart';
import 'package:http_error_handling/repository/repository.dart';
import 'package:http/http.dart' as http;
import 'package:http_error_handling/utility/http_exception.dart';

class JsonPlaceHolderRepository extends Repository {
  // make http
  String baseURL = 'https://jsonplaceholder.typicode.com';

  //http error handling
  dynamic _response(http.Response response) {
    // ignore: avoid_print
    print(response.request?.url);
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server with StatusCode:${response.statusCode}');
    }
  }

  @override
  Future<List<User>> getUsers() async {
    // return type JsonList
    List<User> userList = [];
    // JsonObject
    // Map<String, dynamic> --> responseJson['data']
    // https://jsonplaceholder.typicode.com/users
    var url = Uri.parse('$baseURL/users');

    try {
      var response = await http.get(url);
      var responseJson = _response(response);
      for (var i = 0; i < responseJson.length; i++) {
        userList.add(User.fromJson(responseJson[i]));
      }
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
    return userList;
  }

  @override
  Future<List<Album>> getAlbums(int userId) async {
    // https://jsonplaceholder.typicode.com/albums?userId=2
    // type 2
    try {
      var url = Uri.parse("$baseURL/albums?userId=$userId");
      var response = await http.get(url,
          headers: {HttpHeaders.authorizationHeader: "your_api_token_here"});

      var responseJson = _response(response) as List;
      return responseJson.map((json) => Album.fromJson(json)).toList();
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
  }
}
