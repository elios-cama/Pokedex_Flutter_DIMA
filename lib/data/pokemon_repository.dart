import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pokedex/domain/pokemon.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../application/api_error_handler.dart';
import '../application/dio_provider.dart';

part 'pokemon_repository.g.dart';

class PokemonRepository {
  PokemonRepository({required this.dio});

  final Dio dio;

  Future<List<Pokemon>> fetchPokemons(CancelToken? cancelToken) async {
    const url = 'https://elios-cama.github.io/pokemon_dataset/pokemons.json';
    final response = await dio.get(
      url,
      cancelToken: cancelToken,
    );
    final List<Pokemon> pokemons = (response.data as List<dynamic>)
        .map((pokemon) => Pokemon.fromJson(pokemon))
        .toList();
    return pokemons;
  }

  Future<T> _run<T>({
    required Future<Response> Function() request,
    required T Function(dynamic) parse,
  }) async {
    try {
      final response = await request();
      switch (response.statusCode) {
        case 200:
          return parse(response.data);
        case 201:
          return parse(response.data);
        case 404:
          throw const APIError.notFound();
        default:
          throw const APIError.unknown();
      }
    } on SocketException catch (_) {
      throw const APIError.noInternetConnection();
    }
  }
}

@Riverpod(keepAlive: true)
PokemonRepository pokemonRepository(PokemonRepositoryRef ref) {
  return PokemonRepository(dio: ref.watch(dioProvider));
}

@riverpod
Future<List<Pokemon>> fetchPokemons(FetchPokemonsRef ref) {
  final cancelToken = CancelToken();

  ref.onDispose(() => cancelToken.cancel());

  return ref.watch(pokemonRepositoryProvider).fetchPokemons(cancelToken);
}
