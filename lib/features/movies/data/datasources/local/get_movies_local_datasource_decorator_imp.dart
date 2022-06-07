import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/features/movies/domain/entities/movie_entity.dart';
import '/features/movies/data/datasources/get_movies_datasource.dart';
import '/features/movies/data/dtos/movie_dto.dart';

import 'get_movies_datasource_decorator.dart';

class GetMoviesLocalDataSourceDecoratorImp
    extends GetMoviesDataSourceDecorator {
  GetMoviesLocalDataSourceDecoratorImp(GetMoviesDataSource getMoviesDataSource)
      : super(getMoviesDataSource);

  @override
  Future<Either<Exception, MovieEntity>> call() async {
    return (await super()).fold(
      (error) async {
        if (await _isThereCache()) {
          return Right(await _getFromCache());
        }
        return Left(Exception("Nothing In Cache"));
      },
      (result) {
        _saveInCache(result);
        return Right(result);
      },
    );
  }

  _saveInCache(MovieEntity movies) async {
    var prefs = await SharedPreferences.getInstance();
    String jsonMovies = jsonEncode(movies.toJson());
    prefs.setString('movies_cache', jsonMovies);
    if (kDebugMode) {
      print('Movies saved on cache' + jsonMovies);
    }
  }

  Future<bool> _isThereCache() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("movies_cache")) {
      return true;
    }
    return false;
  }

  Future<MovieEntity> _getFromCache() async {
    var prefs = await SharedPreferences.getInstance();
    var moviesJsonString = prefs.getString('movies_cache')!;
    var json = jsonDecode(moviesJsonString);
    var movies = MovieDto.fromJson(json);
    if (kDebugMode) {
      print('Get from cache the movies ' + movies.toString());
    }
    return movies;
  }
}
