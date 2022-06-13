/*
THE MARVEL UNIVERSE LIST: list/1
OSCAR LIST: list/2
 */
class API {
  static String requestImg(String img) =>
      'https://image.tmdb.org/t/p/w500/$img';

  static const requestMovieList = 'list/1?page=1&language=pt-BR';
}
