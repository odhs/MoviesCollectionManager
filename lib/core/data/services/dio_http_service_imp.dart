import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '/core/domain/services/http_service.dart';

/*
# The Movie DB

The Movie Database (TMDB) is a community built movie and TV database.

## API Documentation

Using version 4
https://developers.themoviedb.org/4/list/get-list

THE MARVEL UNIVERSE LIST: 1
OSCAR LIST: 2
MY FAVORITE LIST: 8203067 (Needs autentication, the referring code has been removed)

TODO Keep the bearer key in a safe place,flutter pub add mocktail
for now the key has been left here for testing purposes only. 

Examples:

```sh
curl --request GET \
  --url 'https://api.themoviedb.org/4/list/1?api_key=<<API key>>&page=1' \
  --header 'authorization: Bearer <<access_token>>' \
  --header 'content-type: application/json;charset=utf-8' \
  --data '{}'

curl --request GET \
  --url 'https://api.themoviedb.org/4/list/1?api_key=<<API key>>&page=1' \
  --header 'authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZjRmNzc2YzRmYzY5ZmQ4NDgyMWFmODBmYTQyZjAxOCIsInN1YiI6IjYyODUyOTdjMWEzMjQ4MDA2NjU4NTY4YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XQfN7982INKEoYyMAGa3NThMA7iZMWtPZXz0J_TFH2s' \
  --header 'content-type: application/json;charset=utf-8' \
  --data '{}'
```
*/

class DioHttpServiceImp implements HttpService {
  late Dio _dio;
  DioHttpServiceImp() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/4/',
        headers: {
          'content-type': 'application/json;charset=utf-8',
          'authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZjRmNzc2YzRmYzY5ZmQ4NDgyMWFmODBmYTQyZjAxOCIsInN1YiI6IjYyODUyOTdjMWEzMjQ4MDA2NjU4NTY4YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XQfN7982INKEoYyMAGa3NThMA7iZMWtPZXz0J_TFH2s',
        },
      ),
    );
    if (kDebugMode) {
      print('API Called');
    }
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
    );
  }
}
