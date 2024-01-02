import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../presentation/widget/pokemon_filter.dart';

final pokemonFilterProvider = StateProvider<PokemonFilter>((ref) => PokemonFilter());