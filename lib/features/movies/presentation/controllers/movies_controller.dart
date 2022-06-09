import 'package:flutter/foundation.dart';
import '../../domain/entities/movie_details_entity.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/usecases/get_movies_usecase.dart';

import '../dtos/movie_dto.dart';

class MoviesController {
  final GetMoviesUseCase _getMoviesUseCase;
  MoviesController(this._getMoviesUseCase) {
    //fetch();
  }

  ValueNotifier<MovieEntity?> movies = ValueNotifier<MovieEntity?>(null);
  // Cache movies list, used in Search
  MovieEntity? _cachedMovies;

  /// Get the movies list
  Future<bool> fetch() async {
    var result = await _getMoviesUseCase();

    try {
      result.fold(
        (error) {
          // API fails and cache is empty
          throw Exception(error);
        },
        (success) => movies.value = success,
      );
    } catch (e) {
      return false;
    }

    // Save on cache to permit search in memory by user later
    _cachedMovies = movies.value;
    return true;
  }

  // TODO improve the filter to remove special characteres and blank spaces
  onChanged(String value) {
    List<MovieDetailsEntity> list = _cachedMovies!.listMovies
        .where(
          (e) => e.toString().toLowerCase().contains((value.toLowerCase())),
        )
        .toList();

    movies.value = movies.value!.copyWith(listMovies: list);
  }
}
