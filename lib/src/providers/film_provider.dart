import 'package:peliculas/src/models/actor_model.dart';
import 'package:peliculas/src/models/film_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class FilmProvider {
  String _apiKey = "YOUR_API_KEY";
  String _url = "api.themoviedb.org";
  String _language = "es-ES";
  int _popularesPage = 0;

  List<Film> _populares = [];

  final _popularesStreamController = StreamController<List<Film>>.broadcast();

  bool _loadingData = false;

  void disposeStream() {
    _popularesStreamController?.close();
  }

  Function(List<Film>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Film>> get popularesStream => _popularesStreamController.stream;

  Future<List<Film>> getNowPlaying() async {
    final url = Uri.https(
      _url,
      '3/movie/now_playing',
      {
        'api_key': _apiKey,
        'language': _language,
      },
    );

    return await _getResponse(url);
  }

  Future<List<Film>> getPopular() async {
    if (_loadingData) return [];
    _loadingData = true;
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final response = await _getResponse(url);

    _populares.addAll(response);
    popularesSink(_populares);
    _loadingData = false;
    return response;
  }

  Future<List<Film>> _getResponse(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final films = Films.fromJSONList(decodedData['results']);
    return films.films;
  }

  Future<List<Actor>> getCast(String filmId) async {
    final url = Uri.https(_url, '3/movie/$filmId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodedData = await json.decode(resp.body);

    final cast = Cast.fromJsonList(decodedData['cast']);
    return cast.actors;
  }

  Future<List<Film>> searchFilm(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });

    return _getResponse(url);
  }
}
