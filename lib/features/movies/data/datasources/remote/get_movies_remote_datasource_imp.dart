import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '/core/utils/api_utils.dart';
import '/core/domain/services/http_service.dart';
import '/features/movies/domain/entities/movie_entity.dart';
import '/features/movies/data/datasources/get_movies_datasource.dart';
import '/features/movies/data/dtos/movie_dto.dart';

class GetMoviesRemoteDatasourceImp implements GetMoviesDataSource {
  
  final HttpService _httpService;

  GetMoviesRemoteDatasourceImp(this._httpService);

  @override
  Future<Either<Exception, MovieEntity>> call() async {
    try {
      if (kDebugMode) {
        await Future.delayed(const Duration(seconds: 3));
      }
      var result = await _httpService.get(API.requestMovieList);
      return Right(MovieDto.fromJson(result.data));
    } catch (e) {
      return Left(Exception('API no answer'));
    }
  }
}
