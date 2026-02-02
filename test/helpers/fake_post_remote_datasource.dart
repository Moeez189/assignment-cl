import 'package:test/features/posts/data/datasources/post_remote_datasource.dart';
import 'package:test/features/posts/data/models/post_model.dart';
import 'package:test/features/posts/data/models/user_model.dart';

/// Fake remote data source that returns empty data immediately.
/// Used in widget tests to avoid real network calls and pending timers.
class FakePostRemoteDataSource implements PostRemoteDataSource {
  @override
  Future<List<PostModel>> getPosts() async => [];

  @override
  Future<List<UserModel>> getUsers() async => [];
}
