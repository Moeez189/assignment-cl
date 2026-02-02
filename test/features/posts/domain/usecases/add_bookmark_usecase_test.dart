import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posts_app/features/posts/domain/repositories/post_repository.dart';
import 'package:posts_app/features/posts/domain/usecases/add_bookmark_usecase.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  late AddBookmarkUseCase useCase;
  late MockPostRepository mockRepository;

  setUp(() {
    mockRepository = MockPostRepository();
    useCase = AddBookmarkUseCase(mockRepository);
  });

  const tPostId = 1;

  test('should call repository addBookmark with post id', () async {
    when(() => mockRepository.addBookmark(any())).thenAnswer((_) async {});

    await useCase(tPostId);

    verify(() => mockRepository.addBookmark(tPostId)).called(1);
  });
}
