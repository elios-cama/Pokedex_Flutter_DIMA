import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/domain/pokemon.dart';
import 'package:pokedex/presentation/home_page.dart';
import 'package:pokedex/presentation/widget/type_box.dart';

import '../../application/pokemon_services.dart';

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
                          )),
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
          child: ListView(children: [
            WillPopScope(
              // Override back button, but how to do that on iOS???
              onWillPop: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
                return false;
              },
              child: Column(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.32,
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
                      )),

                  const SizedBox(height: 18.0), // padding

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.058),
                      Text(
                        pokemon.name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      typeBoxes(pokemon.typeofpokemon),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.058),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.058),
                      Text(
                        pokemon.id,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.058),
                      Expanded(
                        child: Text(
                          pokemon.xdescription,
                          style: TextStyle(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                            color: Colors.grey[500],
                            height: 1,
                          ),
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.058),
                    ],
                  ),

                  const SizedBox(
                    height: 30.0,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.058),
                      const Text(
                        "Characteristics",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 12.0,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.058),
                      Text(
                        "height : ${pokemon.height}",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          height: 1,
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.058),
                      const Text(
                        "Weaknesses",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  typeBoxes(pokemon.weaknesses),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.058),
                      const Text(
                        "Evolutions",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 18.0,
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          getEvolutionImages(pokemon, context, pokemonNotifier),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
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
          Image.network(
            pokemonEvolution.imageurl,
            width: 100,
            height: 100,
          ),
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
                            0), // Set transition duration to 0 for no animation
                  ),
                );
              },
              child: Opacity(
                opacity: (0.5),
                child: Image.network(
                  pokemonEvolution.imageurl,
                  width: 100,
                  height: 100,
                ),
              )),
        );
      }
      if (pokemonID != pokemon.evolutions.last) {
        list.add(const Icon(Icons.arrow_forward));
      }
      return list;
    });
  }

  Widget pokemonCard(Pokemon pokemon) {
    return Card(
      color: pokemon.typeofpokemon[0].backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Image.network(
        pokemon.imageurl,
        fit: BoxFit.cover,
      ),
    );
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
