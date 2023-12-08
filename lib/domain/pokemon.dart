import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex/domain/type.dart';

part 'pokemon.freezed.dart';
part 'pokemon.g.dart';

@freezed
class Pokemon with _$Pokemon {
  factory Pokemon({
    required String name,
    required String id,
    required String imageurl,
    required String xdescription,
    required String height,
    required String weight,
    required List<Type> typeofpokemon,
    required List<Type> weaknesses,
    required List<String> evolutions,
    required List<String> abilities,
    required String evolvedfrom,
  }) = _Pokemon;

  factory Pokemon.fromJson(Map<String, dynamic> json) => _$PokemonFromJson(json);
}