/// Route paths constants
class AppRoutes {
  AppRoutes._();

  static const String posts = '/';
  static const String postDetail = '/post/:id';
  static const String bookmarks = '/bookmarks';

  /// Generate post detail path with id
  static String postDetailPath(int id) => '/post/$id';
}
