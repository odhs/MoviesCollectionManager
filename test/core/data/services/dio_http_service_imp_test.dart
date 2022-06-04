import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movieapp/core/data/services/dio_http_service_imp.dart';

class FakeUri extends Fake implements Uri {}

void main() async {
  group('Movies API service calls', () {
    late DioHttpServiceImp movieDioService;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      movieDioService = DioHttpServiceImp();
    });

    group('Constructor', () {
      test('does not required a httpClient', () {
        expect(
          movieDioService,
          isNotNull,
        );
      });
    });
  });
}
