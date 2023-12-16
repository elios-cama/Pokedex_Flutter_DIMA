import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/domain/pokemon.dart';
import 'package:pokedex/domain/type.dart';
import 'package:pokedex/presentation/widget/pokemon_infoPage.dart';

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
        if(specificPokemon != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PokemonInfoPage(pokemon: specificPokemon),
            ),
          );
        }
      },
      child: Card(
        color: pokemon.typeofpokemon[0].backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        borderOnForeground: true,
        child: Padding(
          padding: const EdgeInsets.all(
              8.0), // Padding around the column// Card border behind...?
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  height: 200, // Adjust the desired height for the image
                  child: OverflowBox(
                    minHeight: 0,
                    minWidth: 0,
                    maxHeight: double.infinity,
                    maxWidth: 150,
                    child: Image.network(
                      pokemon.imageurl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                pokemon.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Type.generateTypeBoxes(pokemon.typeofpokemon)],
              )
            ],
          ),
        ),
      ),
    );
  }
}
