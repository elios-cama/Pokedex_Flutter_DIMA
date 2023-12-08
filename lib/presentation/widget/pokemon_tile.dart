import 'package:flutter/material.dart';
import 'package:pokedex/domain/pokemon.dart';

class PokemonTile extends StatelessWidget {
  const PokemonTile({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
