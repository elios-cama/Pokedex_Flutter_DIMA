import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/domain/pokemon.dart';

import '../../application/pokemon_services.dart';

class PokemonTile extends ConsumerWidget {
  const PokemonTile({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonNotifier = ref.read(pokemonNotifierProvider.notifier);
    return GestureDetector(
      onTap: () {
        final specificPokemon = pokemonNotifier.getPokemon(pokemon.id);
      },
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                pokemon.imageurl,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              pokemon.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
