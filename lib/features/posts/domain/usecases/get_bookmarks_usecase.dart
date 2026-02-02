import '../../../../core/usecases/usecase.dart';
import '../repositories/post_repository.dart';

/// Use case for getting bookmarked post IDs
class GetBookmarksUseCase implements UseCaseNoParams<Set<int>> {
  final PostRepository repository;

  GetBookmarksUseCase(this.repository);

  @override
  Future<Set<int>> call() async {
    return await repository.getBookmarkedPostIds();
  }
}
