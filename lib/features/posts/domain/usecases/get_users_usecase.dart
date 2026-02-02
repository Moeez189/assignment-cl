import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/post_repository.dart';

/// Use case for fetching all users
class GetUsersUseCase implements UseCaseNoParams<List<User>> {
  final PostRepository repository;

  GetUsersUseCase(this.repository);

  @override
  Future<List<User>> call() async {
    return await repository.getUsers();
  }
}
