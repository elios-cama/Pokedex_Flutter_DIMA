import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/domain/pokemon.dart';
import 'package:pokedex/domain/type.dart';
import 'package:pokedex/presentation/pages/pokemon_info_page.dart';
import 'package:pokedex/presentation/widget/type_box.dart';

import '../../application/pokemon_services.dart';

class PokemonTile extends ConsumerWidget {
  const PokemonTile({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonNotifier = ref.read(pokemonNotifierProvider.notifier);
    return GestureDetector(
      onTap: () {
        final specificPokemon = pokemonNotifier.getPokemonById(pokemon.id);
        if (specificPokemon != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PokemonInfoPage(pokemonName: specificPokemon.name),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Card(
          color: pokemon.typeofpokemon[0].backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          borderOnForeground: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Padding around the column// Card border behind...?
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  flex: 8,
                  child: OverflowBox(
                    minHeight: 0,
                    minWidth: 0,
                    maxHeight: 130,
                    maxWidth: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Image.network(
                        pokemon.imageurl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Flexible(
                  flex: 2,
                  child: Text(
                    pokemon.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Flexible(
                  flex: 2,
                  child: typeBoxes(pokemon.typeofpokemon),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
