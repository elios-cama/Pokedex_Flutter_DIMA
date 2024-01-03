

class PokemonFilter {
  final String? type;

  PokemonFilter({this.type});
  PokemonFilter copyWith({String? type}) {
    return PokemonFilter(
      type: type ?? this.type,
    );
  }
}