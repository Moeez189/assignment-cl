import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posts_app/features/posts/domain/repositories/post_repository.dart';
import 'package:posts_app/features/posts/domain/usecases/get_bookmarks_usecase.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  late GetBookmarksUseCase useCase;
  late MockPostRepository mockRepository;

  setUp(() {
    mockRepository = MockPostRepository();
    useCase = GetBookmarksUseCase(mockRepository);
  });

  test('should get bookmarked post ids from repository', () async {
    const tBookmarks = {1, 2, 3};
    when(() => mockRepository.getBookmarkedPostIds())
        .thenAnswer((_) async => tBookmarks);

    final result = await useCase();

    expect(result, tBookmarks);
    verify(() => mockRepository.getBookmarkedPostIds()).called(1);
  });

  test('should return empty set when no bookmarks', () async {
    when(() => mockRepository.getBookmarkedPostIds())
        .thenAnswer((_) async => <int>{});

    final result = await useCase();

    expect(result, isEmpty);
    verify(() => mockRepository.getBookmarkedPostIds()).called(1);
  });
}
