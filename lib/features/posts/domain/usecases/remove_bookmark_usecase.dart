import '../../../../core/usecases/usecase.dart';
import '../repositories/post_repository.dart';

/// Use case for removing a bookmark
class RemoveBookmarkUseCase implements UseCase<void, int> {
  final PostRepository repository;

  RemoveBookmarkUseCase(this.repository);

  @override
  Future<void> call(int postId) async {
    return await repository.removeBookmark(postId);
  }
}
