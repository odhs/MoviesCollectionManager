import 'package:get_it/get_it.dart';

import '/core/data/services/dio_http_service_imp.dart';
import '/core/domain/services/http_service.dart';

import '/features/movies/data/datasources/get_movies_datasource.dart';
import '/features/movies/data/datasources/local/get_movies_local_datasource_decorator_imp.dart';
import '/features/movies/data/datasources/remote/get_movies_remote_datasource_imp.dart';
import '/features/movies/data/repositories/get_movies_repository_imp.dart';
import '/features/movies/domain/repositories/get_movies_repository.dart';
import '/features/movies/domain/usecases/get_movies_usecase.dart';
import '/features/movies/domain/usecases/get_movies_usecase_imp.dart';
import '/features/movies/presentation/controllers/movies_controller.dart';

class Inject {
  static initialize() {
    GetIt getIt = GetIt.instance;
    // core
    getIt.registerLazySingleton<HttpService>(() => DioHttpServiceImp());

    // datasources
    getIt.registerLazySingleton<GetMoviesDataSource>(
      () => GetMoviesLocalDataSourceDecoratorImp(
        GetMoviesRemoteDatasourceImp(getIt()),
      ),
    );
    // repositories
    getIt.registerLazySingleton<GetMoviesRepository>(
      () => GetMoviesRepositoryImp(getIt()),
    );
    // usecases
    getIt.registerLazySingleton<GetMoviesUseCase>(
      () => GetMoviesUseCaseImp(getIt()),
    );
    // controllers
    getIt.registerLazySingleton<MoviesController>(
      () => MoviesController(getIt()),
    );
  }
}
