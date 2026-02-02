import '../../../../core/usecases/usecase.dart';
import '../repositories/post_repository.dart';

/// Use case for adding a bookmark
class AddBookmarkUseCase implements UseCase<void, int> {
  final PostRepository repository;

  AddBookmarkUseCase(this.repository);

  @override
  Future<void> call(int postId) async {
    return await repository.addBookmark(postId);
  }
}
