import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/pokemon_repository.dart';
import '../domain/pokemon.dart';

class PokemonState {
  PokemonState({required this.pokemons, this.error});

  final List<Pokemon> pokemons;
  final Object? error;
}

class PokemonNotifier extends StateNotifier<PokemonState> {
  PokemonNotifier({required this.repository})
      : super(PokemonState(pokemons: [])) {
    _fetchPokemons();
  }

  final PokemonRepository repository;

  void _fetchPokemons() async {
    try {
      final pokemons = await repository.fetchPokemons(null);
      state = PokemonState(pokemons: pokemons);
    } catch (e) {
      state = PokemonState(pokemons: [], error: e);
    }
  }

  Pokemon? getPokemonById(String id) {
    try {
      final pokemon = state.pokemons.firstWhere((pokemon) => pokemon.id == id);
      return pokemon;
    } catch (e) {
      return null;
    }
  }
  Pokemon? getPokemonByName(String name) {
    try {
      final pokemon = state.pokemons.firstWhere((pokemon) => pokemon.name.toLowerCase() == name.toLowerCase());
      return pokemon;
    } catch (e) {
      return null;
    }
  }
  List<String> getPokemonNames() {
    try {
      final pokemonNames = state.pokemons.map((pokemon) => pokemon.name).toList();
      return pokemonNames;
    } catch (e) {
      return [];
    }
  }
  List<Pokemon> getPokemons() {
    try {
      final pokemonNames = state.pokemons.toList();
      return pokemonNames;
    } catch (e) {
      return [];
    }
  }
}

final pokemonNotifierProvider =
    StateNotifierProvider<PokemonNotifier, PokemonState>((ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return PokemonNotifier(repository: repository);
});
