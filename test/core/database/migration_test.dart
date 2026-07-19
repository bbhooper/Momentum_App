import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/database/app_database.dart';

import '../../generated_migrations/schema.dart';

/// Verifies that existing Momentum databases can be upgraded safely.
///
/// The starting database is generated from the stored version-1 schema.
/// Momentum's real migration logic then upgrades it to version 2, and Drift
/// compares the result with the exported version-2 schema.
void main() {
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  test('upgrades database schema from version 1 to version 2', () async {
    final connection = await verifier.startAt(1);
    final database = AppDatabase(connection);

    await verifier.migrateAndValidate(database, 2);
    await database.close();
  });
}
