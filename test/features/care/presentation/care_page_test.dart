import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/app/providers/current_day_provider.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/core/theme/momentum_theme.dart';
import 'package:momentum/core/time/local_date.dart';
import 'package:momentum/features/care/application/care_repository_provider.dart';
import 'package:momentum/features/care/data/repositories/care_repository.dart';
import 'package:momentum/features/care/presentation/pages/care_page.dart';

void main() {
  const date = LocalDate(year: 2026, month: 8, day: 7);
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  Future<void> pumpCarePage(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentDayProvider.overrideWithValue(date),
          careRepositoryProvider.overrideWithValue(CareRepository(database)),
        ],
        child: MaterialApp(
          theme: MomentumTheme.inkLight,
          home: const CarePage(),
        ),
      ),
    );

    await tester.pumpAndSettle();
  }

  testWidgets('renders Self Care using the shared page structure', (
    tester,
  ) async {
    await pumpCarePage(tester);

    expect(find.text('Care'), findsOneWidget);
    expect(
      find.text('A gentle check-in for you and your space.'),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('self-care-tab')), findsOneWidget);
    expect(find.text('How are you feeling?'), findsOneWidget);
    expect(find.text('How is your energy now?'), findsOneWidget);
    expect(find.text('Notes (optional)'), findsOneWidget);
    expect(find.text('Save mood'), findsOneWidget);
  });

  testWidgets('mood and energy choices expose compact selector semantics', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();

    try {
      await pumpCarePage(tester);

      expect(find.bySemanticsLabel('Mood, 1 of 5, Low'), findsOneWidget);
      expect(find.bySemanticsLabel('Mood, 5 of 5, Great'), findsOneWidget);
      expect(
        find.bySemanticsLabel('Drained energy, Very little capacity'),
        findsOneWidget,
      );
      expect(
        find.bySemanticsLabel('Energised energy, Plenty of capacity'),
        findsOneWidget,
      );
    } finally {
      semantics.dispose();
    }
  });

  testWidgets('switches to Home Care without nested page scrolling', (
    tester,
  ) async {
    await pumpCarePage(tester);

    await tester.tap(find.text('Home Care').first);
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('home-care-tab')), findsOneWidget);
    expect(find.text('How are you feeling?'), findsNothing);
    expect(
      find.text(
        'Choose your current energy in Self Care to see a suitable task list.',
      ),
      findsOneWidget,
    );
  });
}
