import 'dart:async';
import 'dart:convert';

import 'package:flutter_peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider {
  String _apkey = '82f13e1d7e267a45d71722bfeb3c9cb5';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _peliculasPopularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _peliculasPopulares = new List();
  final _peliculasPopularesStreamController =
      StreamController<List<Pelicula>>.broadcast();
  Function(List<Pelicula>) get peliculasPopularesSink =>
      _peliculasPopularesStreamController.sink.add;
  Stream<List<Pelicula>> get peliculasPopularesStream =>
      _peliculasPopularesStreamController.stream;

  void disposeStreams() {
    _peliculasPopularesStreamController.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);

    final Peliculas peliculas =
        new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getPeliculasEnCine() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apkey, 'language': _language});
    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPeliculasPopulares() async {
    if (_cargando) return []; //Si esta cargando paramos aqui

    _cargando = true;
    _peliculasPopularesPage++;
    print("Cargando las siguiente peliculas...");
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apkey,
      'language': _language,
      'page': _peliculasPopularesPage.toString()
    });

    final respuesta = await _procesarRespuesta(url);

    _peliculasPopulares.addAll(respuesta);
    peliculasPopularesSink(_peliculasPopulares);
    _cargando = false;
    return respuesta;
  }
}
