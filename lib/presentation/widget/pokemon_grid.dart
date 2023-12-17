import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/presentation/widget/pokemon_tile.dart';

import '../../application/pokemon_services.dart';

class PokemonGrid extends ConsumerWidget {
  const PokemonGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonState = ref.watch(pokemonNotifierProvider);
    final pokemons = pokemonState.pokemons;

    if (pokemonState.error != null) {
      return const Center(
        child: Text(
            'An error occurred. Please check your internet connection and try again.'),
      );
    }

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
  }
}
