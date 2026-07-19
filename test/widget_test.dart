import 'package:flutter_test/flutter_test.dart';

import 'package:momentum/app/momentum_app.dart';

void main() {
  testWidgets('Momentum app renders', (tester) async {
    await tester.pumpWidget(const MomentumApp());

    expect(find.byType(MomentumApp), findsOneWidget);
  });
}
