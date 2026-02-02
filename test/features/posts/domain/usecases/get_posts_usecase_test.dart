import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/features/posts/domain/entities/post.dart';
import 'package:test/features/posts/domain/repositories/post_repository.dart';
import 'package:test/features/posts/domain/usecases/get_posts_usecase.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  late GetPostsUseCase useCase;
  late MockPostRepository mockRepository;

  setUp(() {
    mockRepository = MockPostRepository();
    useCase = GetPostsUseCase(mockRepository);
  });

  const tPost = Post(
    id: 1,
    userId: 1,
    title: 'Test Title',
    body: 'Test body',
  );

  test('should get list of posts from repository', () async {
    when(() => mockRepository.getPosts()).thenAnswer((_) async => [tPost]);

    final result = await useCase();

    expect(result, [tPost]);
    verify(() => mockRepository.getPosts()).called(1);
  });

  test('should return empty list when repository returns empty', () async {
    when(() => mockRepository.getPosts()).thenAnswer((_) async => []);

    final result = await useCase();

    expect(result, isEmpty);
    verify(() => mockRepository.getPosts()).called(1);
  });
}
