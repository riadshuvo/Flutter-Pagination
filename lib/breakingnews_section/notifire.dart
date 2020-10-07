import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'model_class.dart';


class PokemonNotifier extends ValueNotifier<List<Pokemon>> {
  PokemonNotifier() : super(null);

  Dio dio = Dio();

  int _pageNumber = 1;
  bool _hasMorePokemon = true;
  int _batchesOf = 1;
  final String _apiUrl = 'http://test.reolib.com/breking_news';
  List<Pokemon> _listPokemons;
  bool _loading = false;

  @override
  List<Pokemon> get value => _value;
  List<Pokemon> _value;
  @override
  set value(List<Pokemon> newValue) {
    _value = newValue;
    notifyListeners();
  }

  Future<void> reload() async {
    _listPokemons = <Pokemon>[];
    _pageNumber = 1;
    await httpGetPokemon(_pageNumber);
  }

  Future<void> getMore() async {
    if (_hasMorePokemon && !_loading) {
      _loading = true;
      await httpGetPokemon(_pageNumber);
      _loading = false;
    }
  }

  Future<void> httpGetPokemon(int page) async {
    _listPokemons ??= <Pokemon>[];
    int pageNumber = page;

    try{
      while (_hasMorePokemon && (pageNumber - page) < _batchesOf) {
        print("link: $_apiUrl?page=$pageNumber");

        final response = await dio.get("$_apiUrl?page=$pageNumber");
        if (response.statusCode == 200) {
          var bodylist = response.data;
          print("list: $bodylist");
          bodylist != null ?
          _listPokemons.add(Pokemon.fromJson(response.data)) : _hasMorePokemon = false;

          pageNumber++;
        }

        // http.Response res = await http.get('$_apiUrl?page=$pageNumber');
        // if(res.statusCode == 200){
        //   Map<String, dynamic> jsonDecoded = json.decode(res.body);
        //   jsonDecoded != null
        //       ? _listPokemons.add(Pokemon.fromJson(jsonDecoded))
        //       : _hasMorePokemon = false;
        //   pageNumber++;
        // }

      }

    }catch(e){
      Text(e.toString());
    }

    _pageNumber = pageNumber;
    value = _listPokemons;
  }
}
