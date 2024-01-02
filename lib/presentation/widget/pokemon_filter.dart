import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/application/pokemon_filter_provider.dart';
import 'package:pokedex/presentation/widget/type_box.dart';
import 'package:pokedex/domain/type.dart';
import '../../application/pokemon_services.dart';
import '../../domain/pokemon.dart';

class PokemonFilter {
  final String? type;

  PokemonFilter({this.type});
  PokemonFilter copyWith({String? type}) {
    return PokemonFilter(
      type: type ?? this.type,
    );
  }
}