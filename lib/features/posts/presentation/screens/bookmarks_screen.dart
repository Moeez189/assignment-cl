import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/widgets/loading_view.dart';
import '../providers/posts_provider.dart';
import '../providers/posts_state.dart';
import '../widgets/post_card.dart';
import '../widgets/empty_state.dart';

/// Bookmarks screen showing only bookmarked posts
class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsState = ref.watch(postsNotifierProvider);
    final bookmarkedPosts = postsState.bookmarkedPosts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: postsState.status == PostsStatus.loading
          ? const LoadingView(message: 'Loading bookmarks...')
          : bookmarkedPosts.isEmpty
              ? const EmptyState(
                  title: 'No bookmarks yet',
                  subtitle: 'Bookmark posts to see them here',
                  icon: Icons.bookmark_border,
                )
              : ListView.builder(
                  padding: AppPadding.postListPadding,
                  itemCount: bookmarkedPosts.length,
                  itemBuilder: (context, index) {
                    final postWithUser = bookmarkedPosts[index];
                    return PostCard(
                      postWithUser: postWithUser,
                      onBookmarkTap: () {
                        ref
                            .read(postsNotifierProvider.notifier)
                            .toggleBookmark(postWithUser.post.id);
                      },
                      onTap: () {
                        context.push(
                          AppRoutes.postDetailPath(postWithUser.post.id),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
