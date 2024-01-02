/*
import 'package:flutter/material.dart';
import 'package:pokedex/presentation/widget/pokemon_filter.dart';

class FavouriteIcon extends StatefulWidget {
  final String pokemonName;

  const FavouriteIcon({required this.pokemonName, super.key});
  @override
  _FavouriteIconState createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon> {
  late bool isFavourite;

  @override
  void initState() {
    super.initState();
    isFavourite = Favourites().isFavourites(widget.pokemonName);
  }

  void toggleFavourite() {
    setState(() {
      isFavourite = !isFavourite;
      if (isFavourite) {
        Favourites().addToFavourites(widget.pokemonName);
        PokemonFiltered().favouritesPokemons.add(widget.pokemonName);
      } else {
        Favourites().removeFromFavourites(widget.pokemonName);
        PokemonFiltered().favouritesPokemons.remove(widget.pokemonName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavourite ? Icons.star : Icons.star_border,
        color: isFavourite ? Colors.yellow : null,
      ),
      onPressed: toggleFavourite,
    );
  }
}



class Favourites {
  Favourites._();
  static final Favourites _instance = Favourites._();
  factory Favourites() { return _instance; }

  final List<String> favouritePokemons = [];
  List<String> get favouriteItems => favouritePokemons;

  void addToFavourites(String item) { favouritePokemons.add(item); }

  void removeFromFavourites(String item) { favouritePokemons.remove(item); }

  bool isFavourites(String item) { return favouritePokemons.contains(item); }
}*/
