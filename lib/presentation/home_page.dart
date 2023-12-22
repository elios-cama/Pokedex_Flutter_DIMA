import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pokedex/presentation/pages/pokemon_info_page.dart';
import 'package:pokedex/presentation/widget/pokemon_grid.dart';

import '../application/pokemon_services.dart';
import '../application/search_delegate.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  CameraController? _cameraController;
  final _textRecognizer = TextRecognizer();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      final camera = cameras.first;
      _cameraController = CameraController(camera, ResolutionPreset.medium);
      await _cameraController!.initialize();
    }
  }

  Future<String> _scanImage(WidgetRef ref) async {
    try {
      final image = await _cameraController!.takePicture();
      final inputImage = InputImage.fromFilePath(image.path);
      final recognisedText = await _textRecognizer.processImage(inputImage);
      final text = recognisedText.text;
      return text;
     /* Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PokemonInfoPage(pokemonName: pokemonName),
        ),
      );*/
        } catch (e) {
      print(e);
      return "Ivysaur";
    }
  }
  String getSecondElement(String scannedText) {
    List<String> lines = scannedText.split('\n');
    if (lines.length >= 2) {
      return lines[1];
    } else {
      throw Exception('Scanned text does not contain enough lines');
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pokemonNotifier = ref.watch(pokemonNotifierProvider.notifier);
    final pokemonNames = pokemonNotifier.getPokemonNames();
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: const Text("POKEDEX"),
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: const Color(0xFFF0F0F0),
            height: 50,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: PokemonSearchDelegate(pokemonNames),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Search by name",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.filter_alt,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
          ),
          const Expanded(
            child: PokemonGrid(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFFC8614E),
        onPressed: () async {
          if (await Permission.camera.request().isGranted) {
            if (mounted) {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                builder: (BuildContext context) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFF8E0DE),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      height: 300,
                      child: _cameraController != null &&
                              _cameraController!.value.isInitialized
                          ? Stack(
                              children: [
                                CameraPreview(_cameraController!),
                                ElevatedButton(
                                    onPressed: () async{
                                      String text = await _scanImage(ref);
                                      text = getSecondElement(text);
                                      final pokemonNotifier = ref.read(pokemonNotifierProvider.notifier);
                                      final pokemonNames = pokemonNotifier.getPokemonNames();
                                      final pokemonName =
                                      pokemonNames.firstWhere((name) => text.contains(name));
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonInfoPage(pokemonName: pokemonName),),);
                                    },
                                    child: const Text("Scan")),
                              ],
                            )
                          : const Center(child: CircularProgressIndicator()),
                    ),
                  );
                },
              );
            }
          }
        },
        child: const Icon(
          Icons.camera_alt_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
