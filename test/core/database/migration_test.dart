import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/database/app_database.dart';

import '../../generated_migrations/schema.dart';

/// Verifies that existing Momentum databases can be upgraded safely.
///
/// Tests both supported upgrade paths:
/// - version 1 databases upgrade through version 2 to version 3
/// - version 2 databases upgrade directly to version 3
void main() {
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  test('upgrades database schema from version 1 to version 3', () async {
    final connection = await verifier.startAt(1);
    final database = AppDatabase(connection);

    await verifier.migrateAndValidate(database, 3);
    await database.close();
  });

  test('upgrades database schema from version 2 to version 3', () async {
    final connection = await verifier.startAt(2);
    final database = AppDatabase(connection);

    await verifier.migrateAndValidate(database, 3);
    await database.close();
  });
}
