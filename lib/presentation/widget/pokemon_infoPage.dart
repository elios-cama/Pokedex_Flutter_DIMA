import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/domain/pokemon.dart';
import 'package:pokedex/presentation/widget/type_box.dart';

import '../../application/pokemon_services.dart';
import '../home_page.dart';

class PokemonInfoPage extends ConsumerWidget {
  const PokemonInfoPage({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonNotifier = ref.read(pokemonNotifierProvider.notifier);

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          try {
            if (details.delta.dx > 0.1) {
              var nextPokemon =
                  pokemonNotifier.getPokemon(_getPrevPokemonID(pokemon.id));
              if (nextPokemon == null) {
                throw '';
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PokemonInfoPage(
                    pokemon: nextPokemon,
                  ),
                ),
              );
            } else if (details.delta.dx < -0.1) {
              var nextPokemon =
                  pokemonNotifier.getPokemon(_getNextPokemonID(pokemon.id));
              if (nextPokemon == null) {
                throw '';
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => PokemonInfoPage(
                          pokemon: nextPokemon,
                        )),
              );
            }
          } catch (e) {}
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 240,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: pokemon.typeofpokemon[0].backgroundColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(pokemon.imageurl),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18.0), // padding
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          pokemon.name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        typeBoxes(pokemon.typeofpokemon),
                      ],
                    ),
                    Text(
                      pokemon.id,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            pokemon.xdescription,
                            style: TextStyle(
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    const Text(
                      "Characteristics",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "height : ${pokemon.height}",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          "weight : ${pokemon.weight}",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    const Text(
                      "Weaknesses",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    typeBox(pokemon.weaknesses[0]),
                    const SizedBox(
                      height: 24.0,
                    ),
                    const Text(
                      "Evolutions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 18.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: getEvolutionImages(
                        pokemon,
                        context,
                        pokemonNotifier,
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getEvolutionImages(
      Pokemon pokemon, BuildContext context, PokemonNotifier pokemonNotifier) {
    return pokemon.evolutions.fold([], (list, pokemonID) {
      var pokemonEvolution = pokemonNotifier.getPokemon(pokemonID);
      if (pokemonEvolution == null) {
        throw '';
      }
      if (pokemon.id == pokemonID) {
        list.add(
          Image.network(pokemonEvolution.imageurl,
              width: 90, height: 90, fit: BoxFit.contain),
        );
      } else {
        list.add(
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        PokemonInfoPage(pokemon: pokemonEvolution),
                    transitionDuration: const Duration(
                        seconds:
                            1), // Set transition duration to 0 for no animation
                  ),
                );
              },
              child: Opacity(
                opacity: (0.5),
                child: Image.network(pokemonEvolution.imageurl,
                    width: 90, height: 90, fit: BoxFit.contain),
              )),
        );
      }
      if (pokemonID != pokemon.evolutions.last) {
        list.add(const Icon(Icons.arrow_forward));
      }
      return list;
    });
  }

  String _getNextPokemonID(String currPokemonID) {
    int? currentID = int.tryParse(currPokemonID.substring(1));
    if (currentID == 809) {
      throw Exception("LastPokemon");
    } // Wrong now, to get from the repository length
    return '#${((currentID ?? 0) + 1).toString().padLeft(3, '0')}';
  }

  String _getPrevPokemonID(String currPokemonID) {
    int? currentID = int.tryParse(currPokemonID.substring(1));
    if (currentID == 0) {
      throw Exception("FirstPokemon");
    }
    return '#${((currentID ?? 0) - 1).toString().padLeft(3, '0')}';
  }
}
