import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:posts_app/main.dart';
import 'package:posts_app/features/posts/presentation/providers/posts_provider.dart';

import 'helpers/fake_post_remote_datasource.dart';

void main() {
  testWidgets('App shows Posts screen with app bar title', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          postRemoteDataSourceProvider.overrideWithValue(
            FakePostRemoteDataSource(),
          ),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Posts'), findsOneWidget);
  });
}
