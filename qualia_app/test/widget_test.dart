import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qualia_app/app.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: QualiaApp(),
      ),
    );

    // Verify app title is displayed
    expect(find.text('Qualia'), findsOneWidget);
  });
}
