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

  Pokemon? getPokemon(String id) {
    try {
      final pokemon = state.pokemons.firstWhere((pokemon) => pokemon.id == id);
      return pokemon;
    } catch (e) {
      return null;
    }
  }
}

final pokemonNotifierProvider =
    StateNotifierProvider<PokemonNotifier, PokemonState>((ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return PokemonNotifier(repository: repository);
});
