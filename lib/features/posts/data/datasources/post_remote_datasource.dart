import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/utils/app_logger.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';

/// Abstract class for remote data source
abstract class PostRemoteDataSource {
  /// Fetches posts from the API
  Future<List<PostModel>> getPosts();

  /// Fetches users from the API
  Future<List<UserModel>> getUsers();
}

/// Implementation of PostRemoteDataSource using Dio
class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final Dio dio;

  PostRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      AppLogger.i('Fetching posts from API');
      final response = await dio.get(ApiConstants.postsEndpoint);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        final posts = jsonList.map((json) => PostModel.fromJson(json)).toList();
        AppLogger.i('Successfully fetched ${posts.length} posts');
        return posts;
      } else {
        AppLogger.e('Failed to fetch posts: ${response.statusCode}');
        throw Exception('Failed to fetch posts: ${response.statusCode}');
      }
    } on DioException catch (e) {
      AppLogger.e('Dio error fetching posts', e);
      throw Exception(_handleDioError(e));
    } catch (e) {
      AppLogger.e('Error fetching posts', e);
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      AppLogger.i('Fetching users from API');
      final response = await dio.get(ApiConstants.usersEndpoint);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        final users = jsonList.map((json) => UserModel.fromJson(json)).toList();
        AppLogger.i('Successfully fetched ${users.length} users');
        return users;
      } else {
        AppLogger.e('Failed to fetch users: ${response.statusCode}');
        throw Exception('Failed to fetch users: ${response.statusCode}');
      }
    } on DioException catch (e) {
      AppLogger.e('Dio error fetching users', e);
      throw Exception(_handleDioError(e));
    } catch (e) {
      AppLogger.e('Error fetching users', e);
      rethrow;
    }
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
        return 'Send timeout. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout. Please try again.';
      case DioExceptionType.badResponse:
        return 'Server error: ${e.response?.statusCode}';
      case DioExceptionType.cancel:
        return 'Request cancelled.';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      default:
        return 'Network error occurred. Please try again.';
    }
  }
}
