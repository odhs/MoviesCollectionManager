import 'package:flutter/material.dart';
import '../../domain/entities/movie_details_entity.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/usecases/get_movies_usecase.dart';

import '../dtos/movie_dto.dart';

class MovieController {
  final GetMoviesUseCase _getMoviesUseCase;
  MovieController(this._getMoviesUseCase) {
    fetch();
  }

  ValueNotifier<MovieEntity?> movies = ValueNotifier<MovieEntity?>(null);
  // Cache movies list, used in Search
  MovieEntity? _cachedMovies;

  /// Get the movies list
  fetch() async {
    var result = await _getMoviesUseCase();

    result.fold(
      (error) => debugPrint(error.toString()),
      (success) => movies.value = success,
    );

    // Save on cache to permit search in memory by user later
    _cachedMovies = movies.value;
  }

  // TODO melhorar o filtro retirando também espaços e caracteres especiais
  onChanged(String value) {
    List<MovieDetailsEntity> list = _cachedMovies!.listMovies
        .where(
          (e) => e.toString().toLowerCase().contains((value.toLowerCase())),
        )
        .toList();
        
    movies.value = movies.value!.copyWith(listMovies: list);
  }
}
