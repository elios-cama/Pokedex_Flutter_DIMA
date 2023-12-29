import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/application/pokemon_filter_provider.dart';
import 'package:pokedex/presentation/widget/type_box.dart';
import 'package:pokedex/domain/type.dart';
import '../../application/pokemon_services.dart';
import '../../domain/pokemon.dart';

class PokemonFiltered {
  PokemonFiltered._();
  static final PokemonFiltered _instance = PokemonFiltered._();
  factory PokemonFiltered() {
    return _instance;
  }

  List<String> allTypes = [
    "Normal",
    "Fire",
    "Water",
    "Grass",
    "Flying",
    "Fighting",
    "Poison",
    "Electric",
    "Ground",
    "Rock",
    "Psychic",
    "Ice",
    "Bug",
    "Ghost",
    "Steel",
    "Dragon",
    "Dark",
    "Fairy"
  ];
  List<Pokemon> allPokemons = [];
  List<Pokemon> pokemonFiltered = [];

  List<String> typesInFilter = [];
  List<String> typesWeaknesses = [];
  List<String> favouritesPokemons = [];
  RangedParameter weight = RangedParameter();
  RangedParameter height = RangedParameter();

  bool isFavouriteFilter = false;

  // filter list provider. Doesn't work still
  final FilterPokemonProvider filterPokemonProvider = FilterPokemonProvider();

  void modifyListProvider() {
    filterPokemonProvider.updateList(pokemonFiltered);
  }

  void setAllPokemons(List<Pokemon> pokemons) {
    allPokemons = pokemons;
    pokemonFiltered = allPokemons;
    modifyListProvider();
  }

  void resetAllPokemons() {
    pokemonFiltered = allPokemons;
  }

  List<Pokemon> getPokemonNamesFiltered() {
    return pokemonFiltered;
  }

  void filterPokemons() {
    pokemonFiltered = [];
    for(int i = 0; i < allPokemons.length; i ++) {
      var pok = allPokemons[i];

      if( filterPokemonByType(pok) &&
      filterPokemonByWeaknesses(pok) &&
      filterPokemonByFavourite(pok) &&
      filterPokemonByWeight(pok) &&
      filterPokemonByHeight(pok) ) {
        pokemonFiltered.add(pok);
      }
    }

    modifyListProvider();
    resetFilters();
  }

  bool filterPokemonByType(Pokemon pokemon) {
    if(typesInFilter.isEmpty) { return true; }
    return pokemon.typeofpokemon.any((element) => typesInFilter.toSet().contains(element.name));
  }

  bool filterPokemonByWeaknesses(Pokemon pokemon) {
    if(typesWeaknesses.isEmpty) { return true; }
    return pokemon.weaknesses.any((element) => typesWeaknesses.toSet().contains(element.name));
  }

  bool filterPokemonByFavourite(Pokemon pokemon) {
    if(!isFavouriteFilter) { return true; }
    else { return favouritesPokemons.contains(pokemon.name); }
  }

  bool filterPokemonByWeight(Pokemon pokemon) {
    var w = double.parse(pokemon.weight.replaceAll(" lbs", ""));
    return w >= weight.rangeValues.start && w <= weight.rangeValues.end;
  }

  bool filterPokemonByHeight(Pokemon pokemon) {
    var h = int.parse(pokemon.height[0]);
    return h >= height.rangeValues.start && h <= height.rangeValues.end;
  }

  void notFavourite(bool value) {
    isFavouriteFilter = value;
  }

  void changeRangedValues(RangeValues rv, RangeValues values) {
    rv = values;
  }

  void findMax() {
    int maxHeight = 0;
    double maxWeight = 0.0;
    for(int i = 0; i < allPokemons.length; i ++) {
      var weight = double.parse(allPokemons[i].weight.replaceAll(" lbs", ""));
      var height = int.parse(allPokemons[i].height[0]) + 1;

      if(weight > maxWeight) { maxWeight = weight; }
      if(height > maxHeight) { maxHeight = height; }

      this.weight.maxValue = maxWeight;
      this.weight.rangeValues = RangeValues(0.0, maxWeight);

      this.height.maxValue = maxHeight.toDouble();
      this.height.rangeValues = RangeValues(0.0, maxHeight.toDouble());
    }
  }

  void resetFilters() {
    typesInFilter = [];
    typesWeaknesses = [];
    height.resetParameters();
    weight.resetParameters();
    isFavouriteFilter = false;
  }
}

class RangedParameter {
  late RangeValues rangeValues;
  late double maxValue;

  RangedParameter() {
    rangeValues = const RangeValues(0.0, 100.0);
    maxValue = 100.0;
  }

  void resetParameters() {
    rangeValues = RangeValues(0.0, maxValue);
  }
}

class FilterPokemonWidget extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonState = ref.watch(pokemonNotifierProvider);
    PokemonFiltered().allPokemons = pokemonState.pokemons;
    PokemonFiltered().findMax();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: 580,
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text(
                  'FILTER POKEMON',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              const Text(
                'Types:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              // Wrap(
              //   alignment: WrapAlignment.center,
              //   spacing: 5.0,
              //   runSpacing: 5.0,
              //   children: PokemonFiltered().allTypes.map((type) => PokemonSelectableType(type: type),).toList(),
              // ),
              Container(
                color: Colors.white,
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(2.0),
                  children: PokemonFiltered()
                      .allTypes
                      .map((type) => Row(children: [
                            PokemonSelectableType(
                              type: type,
                              filterListRef: PokemonFiltered().typesInFilter,
                            ),
                            const SizedBox(
                              width: 5.0,
                            )
                          ]))
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              const Text(
                'Weaknesses:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Container(
                color: Colors.white,
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(2.0),
                  children: PokemonFiltered()
                      .allTypes
                      .map((type) => Row(children: [
                            PokemonSelectableType(
                              type: type,
                              filterListRef: PokemonFiltered().typesWeaknesses,
                            ),
                            const SizedBox(
                              width: 5.0,
                            )
                          ]))
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              const Row(
                children: [
                  Text(
                    'Favourites:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  FavouriteSwitch(),
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              const Text(
                'Weight:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FilterSlidebar(rangedParam: PokemonFiltered().weight),
              const SizedBox(
                width: 12.0,
              ),
              const Text(
                'Height:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FilterSlidebar(rangedParam: PokemonFiltered().height),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8F0909),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Adjust the bevel as needed
                  ),
                ),
                onPressed: () {
                  PokemonFiltered().filterPokemons();

                  },
                child: const Text(
                  'APPLY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FavouriteSwitch extends StatefulWidget {
  const FavouriteSwitch({super.key});
  @override
  _FavouriteSwitchState createState() => _FavouriteSwitchState();
}

class _FavouriteSwitchState extends State<FavouriteSwitch> {
  var isFavEnabled = false;

  @override
  Widget build(BuildContext context) {
    PokemonFiltered().isFavouriteFilter = isFavEnabled;

    return Switch(
      value: isFavEnabled,
      onChanged: (bool value) {
        setState(() {
          PokemonFiltered().notFavourite(value);
          isFavEnabled = value;
        });
      },
    );
  }
}

class FilterSlidebar extends StatefulWidget {
  final RangedParameter rangedParam;
  const FilterSlidebar({super.key, required this.rangedParam});

  @override
  _FilterSlidebarState createState() => _FilterSlidebarState();
}

class _FilterSlidebarState extends State<FilterSlidebar> {
  RangeValues rangeValuesState = const RangeValues(0.0, 100.0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RangeSlider(
          values: widget.rangedParam.rangeValues,
          min: 0.0,
          max: widget.rangedParam.maxValue,
          onChanged: (RangeValues values) {
            setState(() {
              widget.rangedParam.rangeValues = values;
              rangeValuesState = values;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Min: ${widget.rangedParam.rangeValues.start.toStringAsFixed(2)} '
                  '- Max: ${widget.rangedParam.rangeValues.end.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Color(0xFFAAAAAA),
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class PokemonSelectableType extends StatefulWidget {
  final String type;
  final List<String> filterListRef;
  PokemonSelectableType(
      {super.key, required this.type, required this.filterListRef});

  @override
  _PokemonSelectableTypeState createState() => _PokemonSelectableTypeState();
}

class _PokemonSelectableTypeState extends State<PokemonSelectableType> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    isSelected = widget.filterListRef.contains(widget.type);
    // isSelected = widget.filterListRef.contains(widget.type);
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          if (isSelected) {
            if(!widget.filterListRef.contains(widget.type)) {
              widget.filterListRef.add(widget.type);
            }
          } else {
            widget.filterListRef.remove(widget.type);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD5E0E0) : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: typeBox(Type.fromJson(widget.type)),
        ),
      ),
    );
  }
}
