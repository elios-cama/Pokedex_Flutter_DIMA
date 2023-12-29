import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/pokemon.dart';

class FilterPokemonProvider extends StateNotifier<List<Pokemon>> {
  FilterPokemonProvider() : super([]);

  void updateList(List<Pokemon> filterList) {
    state = filterList;
  }
}

final filterPokemonProvider =
    StateNotifierProvider<FilterPokemonProvider, List<Pokemon>>((ref) {
  return FilterPokemonProvider();
});
