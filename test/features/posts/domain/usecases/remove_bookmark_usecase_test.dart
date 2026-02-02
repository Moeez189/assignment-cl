import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/features/posts/domain/repositories/post_repository.dart';
import 'package:test/features/posts/domain/usecases/remove_bookmark_usecase.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  late RemoveBookmarkUseCase useCase;
  late MockPostRepository mockRepository;

  setUp(() {
    mockRepository = MockPostRepository();
    useCase = RemoveBookmarkUseCase(mockRepository);
  });

  const tPostId = 1;

  test('should call repository removeBookmark with post id', () async {
    when(() => mockRepository.removeBookmark(any())).thenAnswer((_) async {});

    await useCase(tPostId);

    verify(() => mockRepository.removeBookmark(tPostId)).called(1);
  });
}
