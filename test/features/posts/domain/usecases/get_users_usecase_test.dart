import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/features/posts/domain/entities/user.dart';
import 'package:test/features/posts/domain/repositories/post_repository.dart';
import 'package:test/features/posts/domain/usecases/get_users_usecase.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  late GetUsersUseCase useCase;
  late MockPostRepository mockRepository;

  setUp(() {
    mockRepository = MockPostRepository();
    useCase = GetUsersUseCase(mockRepository);
  });

  const tUser = User(
    id: 1,
    name: 'Test User',
    username: 'testuser',
    email: 'test@example.com',
  );

  test('should get list of users from repository', () async {
    when(() => mockRepository.getUsers()).thenAnswer((_) async => [tUser]);

    final result = await useCase();

    expect(result, [tUser]);
    verify(() => mockRepository.getUsers()).called(1);
  });

  test('should return empty list when repository returns empty', () async {
    when(() => mockRepository.getUsers()).thenAnswer((_) async => []);

    final result = await useCase();

    expect(result, isEmpty);
    verify(() => mockRepository.getUsers()).called(1);
  });
}
