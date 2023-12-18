import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/presentation/widget/pokemon_grid.dart';

import '../application/pokemon_services.dart';
import '../application/search_delegate.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonNotifier = ref.watch(pokemonNotifierProvider.notifier);
    final pokemonNames = pokemonNotifier.getPokemonNames();
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: const Text("POKEDEX"),
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: const Color(0xFFF0F0F0),
            height: 50,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: PokemonSearchDelegate(pokemonNames),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Search by name",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.filter_alt,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
          ),
          const Expanded(
            child: PokemonGrid(),
          ),
        ],
      ),
    );
  }
}
