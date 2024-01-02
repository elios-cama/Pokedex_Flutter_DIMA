import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/pokemon_repository.dart';
import '../domain/pokemon.dart';
import '../presentation/widget/pokemon_filter.dart';

class PokemonState {
  PokemonState(
      {required this.pokemons, this.error, required this.filteredPokemons});

  final List<Pokemon> pokemons;
  final Object? error;
  final List<Pokemon> filteredPokemons;
}

class PokemonNotifier extends StateNotifier<PokemonState> {
  PokemonNotifier({required this.repository})
      : super(PokemonState(pokemons: [], filteredPokemons: [])) {
    _fetchPokemons();
  }

  final PokemonRepository repository;

  void filterPokemons(PokemonFilter filter) {
    try {
      final filteredPokemons = state.pokemons.where((pokemon) {
        bool matchesType = filter.type == null ||
            pokemon.typeofpokemon.any((type) => type.name == filter.type);
        return matchesType;
      }).toList();

      state = PokemonState(
          pokemons: state.pokemons, filteredPokemons: filteredPokemons);
    } catch (e) {
      print(e);
    }
  }

  void _fetchPokemons() async {
    try {
      final pokemons = await repository.fetchPokemons(null);
      state = PokemonState(pokemons: pokemons, filteredPokemons: pokemons);
    } catch (e) {
      state = PokemonState(pokemons: [], filteredPokemons: [], error: e);
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
      final pokemon = state.pokemons.firstWhere(
          (pokemon) => pokemon.name.toLowerCase() == name.toLowerCase());
      return pokemon;
    } catch (e) {
      return null;
    }
  }

  List<String> getPokemonNames() {
    try {
      final pokemonNames =
          state.pokemons.map((pokemon) => pokemon.name).toList();
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
