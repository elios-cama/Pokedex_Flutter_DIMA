import 'package:flutter/material.dart';
import 'package:pokedex/presentation/widget/pokemon_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        title: Text("POKEDEX"),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Color(0xFFF0F0F0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.deepPurple.shade500,
              height: 50,
              width: MediaQuery.of(context).size.width,
            ),
            const SizedBox(height: 10,),
            const Expanded(child: PokemonGrid(),),
          ],
        ),
      ),
    );
  }
}
