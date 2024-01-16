import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/main.dart';
import 'package:pokedex/presentation/widget/pokemon_grid.dart';

void main() {
  testWidgets('MyApp widget should be rendered', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
          const ProviderScope(child: MyApp()), const Duration(seconds: 3));

      expect(find.byType(MyApp), findsOneWidget);
      expect(find.byType(PokemonGrid), findsOneWidget);
    });
  });
}
