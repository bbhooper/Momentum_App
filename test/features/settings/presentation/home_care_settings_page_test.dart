import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/core/theme/momentum_theme.dart';
import 'package:momentum/features/care/application/care_repository_provider.dart';
import 'package:momentum/features/care/data/repositories/care_repository.dart';
import 'package:momentum/features/settings/presentation/pages/home_care_settings_page.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() => database.close());

  Future<void> pumpPage(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          careRepositoryProvider.overrideWithValue(CareRepository(database)),
        ],
        child: MaterialApp(
          theme: MomentumTheme.inkLight,
          home: const HomeCareSettingsPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('shows seeded tasks grouped by personal demand', (tester) async {
    await pumpPage(tester);

    expect(find.byKey(const ValueKey('add-home-care-task')), findsOneWidget);
    expect(find.text('Low demand'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Medium demand'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Medium demand'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('High demand'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('High demand'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Reset the kitchen'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Reset the kitchen'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Refill your water'),
      -250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Refill your water'), findsOneWidget);
  });

  testWidgets('adds a custom task', (tester) async {
    await pumpPage(tester);

    await tester.tap(find.byKey(const ValueKey('add-home-care-task')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('home-care-task-name')),
      'Water the balcony plants',
    );
    await tester.tap(find.text('Medium'));
    await tester.tap(find.byKey(const ValueKey('save-home-care-task')));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Water the balcony plants'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Water the balcony plants'), findsOneWidget);
    expect(find.text('Custom'), findsOneWidget);
  });

  testWidgets('restore dialog explains that custom tasks are preserved', (
    tester,
  ) async {
    await pumpPage(tester);

    await tester.tap(find.byTooltip('Restore built-in defaults'));
    await tester.pumpAndSettle();

    expect(find.text('Restore built-in tasks?'), findsOneWidget);
    expect(
      find.textContaining('custom tasks will not be changed'),
      findsOneWidget,
    );
  });
}
