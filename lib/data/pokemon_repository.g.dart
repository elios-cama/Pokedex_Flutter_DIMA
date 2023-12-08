// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pokemonRepositoryHash() => r'1007207ea4595e5958041ba86d88607758460d39';

/// See also [pokemonRepository].
@ProviderFor(pokemonRepository)
final pokemonRepositoryProvider = Provider<PokemonRepository>.internal(
  pokemonRepository,
  name: r'pokemonRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pokemonRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PokemonRepositoryRef = ProviderRef<PokemonRepository>;
String _$fetchPokemonsHash() => r'a8652e2b57f3d77c185e579be8607f481c63be56';

/// See also [fetchPokemons].
@ProviderFor(fetchPokemons)
final fetchPokemonsProvider = AutoDisposeFutureProvider<List<Pokemon>>.internal(
  fetchPokemons,
  name: r'fetchPokemonsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchPokemonsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchPokemonsRef = AutoDisposeFutureProviderRef<List<Pokemon>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
