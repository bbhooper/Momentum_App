import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/database/app_database.dart';

import '../../generated_migrations/schema.dart';

/// Verifies that older Momentum databases can be upgraded to the current
/// schema without leaving the database structure inconsistent.
///
/// The generated migration helper must contain the historical schema snapshot
/// being tested plus a v8 snapshot. See the bundle README for the Drift
/// commands.
void main() {
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  Future<void> expectUpgradeToV8(int fromVersion) async {
    final connection = await verifier.startAt(fromVersion);
    final database = AppDatabase(connection);

    try {
      await verifier.migrateAndValidate(database, 8);
    } finally {
      await database.close();
    }
  }

  test('upgrades database schema from version 1 to version 8', () async {
    await expectUpgradeToV8(1);
  });

  test('upgrades database schema from version 2 to version 8', () async {
    await expectUpgradeToV8(2);
  });

  test('upgrades database schema from version 3 to version 8', () async {
    await expectUpgradeToV8(3);
  });
}
