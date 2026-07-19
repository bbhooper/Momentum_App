import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/app/momentum_app.dart';
import 'package:momentum/app/providers/app_initialisation_provider.dart';

void main() {
  testWidgets('Momentum app renders', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // This test only verifies the application interface.
          // Database startup is tested separately, so it is replaced here
          // with an immediately completed initialisation.
          appInitialisationProvider.overrideWith((ref) async {}),
        ],
        child: const MomentumApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Home'), findsWidgets);
    expect(find.text('Sleep'), findsOneWidget);
    expect(find.text('Fuel'), findsOneWidget);
    expect(find.text('Care'), findsOneWidget);
    expect(find.text('Move'), findsOneWidget);
    expect(find.text('Rewards'), findsOneWidget);
    expect(find.text('Diary'), findsOneWidget);
  });
}
