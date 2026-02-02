import '../../../../core/usecases/usecase.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

/// Use case for fetching all posts
class GetPostsUseCase implements UseCaseNoParams<List<Post>> {
  final PostRepository repository;

  GetPostsUseCase(this.repository);

  @override
  Future<List<Post>> call() async {
    return await repository.getPosts();
  }
}
