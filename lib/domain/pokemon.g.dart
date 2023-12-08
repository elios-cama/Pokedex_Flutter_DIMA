// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PokemonImpl _$$PokemonImplFromJson(Map<String, dynamic> json) =>
    _$PokemonImpl(
      name: json['name'] as String,
      id: json['id'] as String,
      imageurl: json['imageurl'] as String,
      xdescription: json['xdescription'] as String,
      height: json['height'] as String,
      weight: json['weight'] as String,
      typeofpokemon: (json['typeofpokemon'] as List<dynamic>)
          .map((e) => Type.fromJson(e as String))
          .toList(),
      weaknesses: (json['weaknesses'] as List<dynamic>)
          .map((e) => Type.fromJson(e as String))
          .toList(),
      evolutions: (json['evolutions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      abilities:
          (json['abilities'] as List<dynamic>).map((e) => e as String).toList(),
      evolvedfrom: json['evolvedfrom'] as String,
    );

Map<String, dynamic> _$$PokemonImplToJson(_$PokemonImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'imageurl': instance.imageurl,
      'xdescription': instance.xdescription,
      'height': instance.height,
      'weight': instance.weight,
      'typeofpokemon': instance.typeofpokemon,
      'weaknesses': instance.weaknesses,
      'evolutions': instance.evolutions,
      'abilities': instance.abilities,
      'evolvedfrom': instance.evolvedfrom,
    };
