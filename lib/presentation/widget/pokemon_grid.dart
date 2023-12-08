import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/presentation/widget/pokemon_tile.dart';

import '../../data/pokemon_repository.dart';

class PokemonGrid extends ConsumerWidget {
  const PokemonGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonAsync = ref.watch(fetchPokemonsProvider);

    return pokemonAsync.maybeWhen(
      data: (pokemons) {
        return GridView.builder(
          itemCount: pokemons.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final pokemon = pokemons[index];
            return PokemonTile(pokemon: pokemon);
          },
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      orElse: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
